#!/bin/sh

_compile() {
    SURFIX=$1
    TOOL=$2
    ARCH_FLAGS=$3
    ARCH_LINK=$4
    ARCH=$5
    
    ARCH_FF=""
    if [ "$ARCH" == "arm" ]
    then
        ARCH_FF=arm
    else
        ARCH_FF=aarch64
    fi

    mkdir "./ffmpeg_${SURFIX}_out" 

    #custom NDK Path, use latest
    export ANDROID_NDK=/Users/yutianzuo/Library/Android/sdk/ndk-bundle

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
    export CFLAGS="${ARCH_FLAGS} -fpic -ffunction-sections -funwind-tables -fno-stack-protector -fno-strict-aliasing"
    export CXXFLAGS="${CFLAGS} -fexceptions"
    export CPPFLAGS=${CXXFLAGS}
    export LDFLAGS="${ARCH_LINK}"    

    #copy x264 .h and .a,fix the path
    cp -r ${ANDROID_HOME}/x264_${SURFIX}_out/lib/ ${CROSS_SYSROOT}/usr/lib
    cp -r ${ANDROID_HOME}/x264_${SURFIX}_out/include/ ${CROSS_SYSROOT}/usr/include

    
    cd ./build_ffmpeg/${TARGET_SOURCE}
    
    ./configure --disable-doc \
    --sysroot=$CROSS_SYSROOT \
    --cross-prefix=$CROSS_PREFIX \
    --prefix=$ANDROID_HOME/ffmpeg_${SURFIX}_out \
    --enable-cross-compile \
    --arch=$ARCH_FF \
    --target-os=android \
    --disable-debug \
    --disable-ffmpeg \
    --disable-ffplay \
    --disable-ffprobe \
    --disable-shared \
    --enable-static \
    --enable-gpl \
    --enable-version3 \
    --disable-avdevice \
    --disable-postproc \
    --enable-libx264 \
    

    make clean
    make -j16
    make install
}

# arm
#_compile "armeabi" "arm-linux-androideabi" "-mthumb -D__ANDROID_API__=20" "" "arm"
# armv7
# _compile "armeabi-v7a" "arm-linux-androideabi" "-march=armv7-a -mfloat-abi=softfp -mfpu=vfpv3-d16" "-march=armv7-a -Wl,--fix-cortex-a8" "arm"
# arm64v8, maybe should compile with a lower ndk
_compile "arm64-v8a" "aarch64-linux-android" "" "" "arm64"
# x86
#_compile "x86" "i686-linux-android" "-march=i686 -m32 -msse3 -mstackrealign -mfpmath=sse -mtune=intel" "" "x86"
# x86_64
#_compile "x86_64" "x86_64-linux-android" "-march=x86-64 -m64 -msse4.2 -mpopcnt  -mtune=intel" "" "x86_64"
# mips
#_compile "mips" "mipsel-linux-android" "" "" "mips"
# mips64
#_compile "mips64" "mips64el-linux-android" "" "" "mips64"


echo "done"
