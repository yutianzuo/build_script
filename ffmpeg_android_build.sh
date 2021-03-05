#!/bin/sh

_compile() {
    SURFIX=$1
    TOOL=$2
    ARCH_FLAGS=$3
    ARCH_LINK=$4
    ARCH=$5
    
    X86_CFLAGS=""
    X86_CONFIGURE=""
    ARCH_FF=""
    if [ "$ARCH" == "arm" ];
    then
        ARCH_FF=arm
    elif [ "$ARCH" == "x86" ];
    then
        ARCH_FF=x86
        X86_CFLAGS="-mno-stackrealign"
        X86_CONFIGURE="--disable-asm --disable-x86asm --disable-inline-asm"
    else
        ARCH_FF=aarch64
    fi

    echo "x86_flags: ${X86_CFLAGS}; x86_configure:${X86_CONFIGURE}; arch_ff:${ARCH_FF}"

    mkdir "./ffmpeg_${SURFIX}_out" 

    #custom NDK Path, use latest
    export ANDROID_NDK=/Users/tianzuoyu/Library/Android/sdk/ndk-bundle

    #ffmpeg version 4.2.2
    TARGET_SOURCE="ffmpeg"
    
    $ANDROID_NDK/build/tools/make-standalone-toolchain.sh --arch=${ARCH} --install-dir=./ffmpeg_toolchain_${SURFIX} --force
    #--platform=android-19

    
    export ANDROID_HOME=`pwd`
    export TOOLCHAIN=$ANDROID_HOME/ffmpeg_toolchain_${SURFIX}
    export CROSS_PREFIX=$TOOLCHAIN/bin/${TOOL}-
    export PKG_CONFIG_LIBDIR=$TOOLCHAIN/lib/pkgconfig
    export CROSS_SYSROOT=$TOOLCHAIN/sysroot
    export PATH=$TOOLCHAIN/bin:$PATH
    export CC=$TOOLCHAIN/bin/${TOOL}-gcc
    export CXX=$TOOLCHAIN/bin/${TOOL}-g++
    export LINK=${CXX}
    export LD=$TOOLCHAIN/bin/${TOOL}-ld
    export AR=$TOOLCHAIN/bin/${TOOL}-ar
    export RANLIB=$TOOLCHAIN/bin/${TOOL}-ranlib
    export STRIP=$TOOLCHAIN/bin/${TOOL}-strip
    export ARCH_FLAGS=$ARCH_FLAGS
    export ARCH_LINK=$ARCH_LINK
    export CFLAGS="${ARCH_FLAGS} -fPIC -O3 -ffast-math -fstrict-aliasing -Werror=strict-aliasing -Wno-psabi -Wa,--noexecstack -DANDROID -DNDEBUG ${X86_CFLAGS}" 
    export CXXFLAGS="${CFLAGS} -fexceptions"
    export CPPFLAGS=${CXXFLAGS}
    export LDFLAGS="${ARCH_LINK} -lcrypto -lssl -lx264 -lm -ldl" #链接参数写好， 对于openssl在configure阶段不通过的问题，我们直接修改configure文件，将检查openssl的部分去掉，直接编译链接，省着ffmpeg对兼容性报问题，阻止正常进行
                                                                 #目前直接才去这样的修改，直接编译链接openssl

    ####################ffmpeg中的configure修改部分，下面可以全部注释掉####################
    # enabled openssl           && { check_pkg_config openssl openssl openssl/ssl.h OPENSSL_init_ssl ||
    #                                check_pkg_config openssl openssl openssl/ssl.h SSL_library_init ||
    #                                check_lib openssl openssl/ssl.h SSL_library_init -lssl -lcrypto ||
    #                                check_lib openssl openssl/ssl.h SSL_library_init -lssl32 -leay32 ||
    #                                check_lib openssl openssl/ssl.h SSL_library_init -lssl -lcrypto -lws2_32 -lgdi32 ||
    #                                die "ERROR: openssl not found"; }
    ####################ffmpeg中的configure修改部分#####################################


    #copy x264 .h and .a,fix the path
    cp -r ${ANDROID_HOME}/x264_${SURFIX}_out/lib/ ${CROSS_SYSROOT}/usr/lib
    cp -r ${ANDROID_HOME}/x264_${SURFIX}_out/include/ ${CROSS_SYSROOT}/usr/include

    #copy openssl .h and .a
    cp -r ${ANDROID_HOME}/openssl_${SURFIX}_out/lib/ ${CROSS_SYSROOT}/usr/lib
    cp -r ${ANDROID_HOME}/openssl_${SURFIX}_out/include/ ${CROSS_SYSROOT}/usr/include
        
    cd ./build_ffmpeg/${TARGET_SOURCE}
    
    ./configure --disable-doc \
    --sysroot="$CROSS_SYSROOT" \
    --cross-prefix="$CROSS_PREFIX" \
    --prefix="$ANDROID_HOME/ffmpeg_${SURFIX}_out" \
    --enable-cross-compile \
    --arch="$ARCH_FF" \
    --target-os=android \
    --disable-debug \
    --disable-ffmpeg \
    --disable-ffplay \
    --disable-ffprobe \
    --disable-shared \
    --enable-static \
    --enable-gpl \
    --enable-libx264 \
    --enable-version3 \
    --disable-avdevice \
    --disable-postproc \
    --enable-jni \
    --enable-mediacodec \
    --enable-decoder=h264_mediacodec \
    --enable-small \
    --enable-nonfree \
    --enable-openssl \
    --extra-ldflags="$LDFLAGS" \
    --extra-cflags="$CFLAGS" \
    --enable-pic \
    ${X86_CONFIGURE}



    # --enable-decoder=aac \
    # --enable-decoder=mpeg4 \
    # --enable-decoder=h264 \
    # --enable-decoder=h264_mediacodec \
    # --enable-decoder=opus \
    # --enable-demuxer=mov \
    # --enable-demuxer=mpegvideo \
    # --enable-demuxer=mpegps \
    # --enable-demuxer=m4v
    
    # --enable-protocol=http \
    # --enable-protocol=https \

    ################################################################################################################################################
    #ffmpeg的检验步骤中似乎只支持旧版本的openssl，所以这里用1.0.2版本的openssl
    ################################################################################################################################################
    
    make clean
    make -j16
    make install
}

# arm
# _compile "armeabi" "arm-linux-androideabi" "-mthumb -D__ANDROID_API__=20" "" "arm"
# armv7
_compile "armeabi-v7a" "arm-linux-androideabi" "-march=armv7-a -mfloat-abi=softfp -mfpu=vfpv3-d16" "-march=armv7-a -Wl,--fix-cortex-a8" "arm"
# arm64v8, maybe should compile with a lower ndk
# _compile "arm64-v8a" "aarch64-linux-android" "" "" "arm64"
# x86
# _compile "x86" "i686-linux-android" "-march=i686 -m32 -msse3 -mstackrealign -mfpmath=sse -mtune=intel" "" "x86"
# x86_64
# _compile "x86_64" "x86_64-linux-android" "-march=x86-64 -m64 -msse4.2 -mpopcnt  -mtune=intel" "" "x86_64"
# mips
#_compile "mips" "mipsel-linux-android" "" "" "mips"
# mips64
#_compile "mips64" "mips64el-linux-android" "" "" "mips64"


echo "done"
