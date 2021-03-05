#!/bin/sh

_compile() {
    SURFIX=$1
    TOOL=$2
    ARCH_FLAGS=$3
    ARCH_LINK=$4
    ARCH=$5
    echo 'begin'

    HOST=""
    X86_CFLAGS=""
    X86_CONFIGURE=""
    if [ "$ARCH" == "arm" ];
    then
        HOST=arm-linux
    elif [ "$ARCH" == "x86" ];
    then
        HOST=i686-linux
        X86_CFLAGS="-mno-stackrealign"
        X86_CONFIGURE="--disable-asm"
    else
        HOST=aarch64-linux
    fi
        
    echo "HOST is :$HOST"
    
    mkdir "./x264_${SURFIX}_out" 

    #custom NDK Path, use the latest ndk
    export ANDROID_NDK=/Users/tianzuoyu/Library/Android/sdk/ndk-bundle

    #x264 latest version
    TARGET_SOURCE="x264"
    
    $ANDROID_NDK/build/tools/make-standalone-toolchain.sh --arch=${ARCH} --install-dir=./x264_toolchain_${SURFIX} --force
    #  --platform=android-20

    
    export ANDROID_HOME=`pwd`
    export TOOLCHAIN=$ANDROID_HOME/x264_toolchain_${SURFIX}
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
    export CFLAGS="${ARCH_FLAGS} -fpic -ffunction-sections -funwind-tables -fno-stack-protector -fno-strict-aliasing ${X86_CFLAGS}"
    export CXXFLAGS="${CFLAGS} -frtti -fexceptions"
    export CPPFLAGS=${CXXFLAGS}
    export LDFLAGS="${ARCH_LINK}"


    
    cd ./build_x264/${TARGET_SOURCE}
    
    ./configure --prefix=$ANDROID_HOME/x264_${SURFIX}_out \
    --cross-prefix=$CROSS_PREFIX \
    --host=$HOST \
    --sysroot=$CROSS_SYSROOT \
    --enable-pic \
    --enable-strip \
    --enable-static \
    --disable-cli \
    ${X86_CONFIGURE}

    make clean
    make -j16
    make install
}

# arm
# _compile "armeabi" "arm-linux-androideabi" "-mthumb -D__ANDROID_API__=20" "" "arm"
# armv7
_compile "armeabi-v7a" "arm-linux-androideabi" "-march=armv7-a -mfloat-abi=softfp -mfpu=neon" "-march=armv7-a -Wl,--fix-cortex-a8" "arm"
# arm64v8, maybe should compile with a lower ndk
# _compile "arm64-v8a" "aarch64-linux-android" "" "" "arm64"
# x86
# _compile "x86" "i686-linux-android" "-march=i686 -m32 -msse3 -mstackrealign -mfpmath=sse -mtune=intel" "" "x86"
# x86_64
#_compile "x86_64" "x86_64-linux-android" "-march=x86-64 -m64 -msse4.2 -mpopcnt  -mtune=intel" "" "x86_64"
# mips
#_compile "mips" "mipsel-linux-android" "" "" "mips"
# mips64
#_compile "mips64" "mips64el-linux-android" "" "" "mips64"


echo "done"
