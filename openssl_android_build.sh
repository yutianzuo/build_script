#!/bin/sh


_compile() {
    SURFIX=$1
    TOOL=$2
    ARCH_FLAGS=$3
    ARCH_LINK=$4
    CFGNAME=$5
    ARCH=$6

#custom NDK Path 
    #need ndk r14!!!!
    #export ANDROID_NDK=/Users/yutianzuo/Library/Android/sdk/ndk-bundle

    echo "NDK PATH:"
    echo ${ANDROID_NDK}
    
    
    mkdir "./openssl_${SURFIX}_out"     
    
    $ANDROID_NDK/build/tools/make-standalone-toolchain.sh --arch=${ARCH} --install-dir=./openssl_toolchain_${SURFIX} --platform=android-16 --force
    

    export ANDROID_HOME=`pwd`
    export TOOLCHAIN=$ANDROID_HOME/openssl_toolchain_${SURFIX}
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
    export CFLAGS="${ARCH_FLAGS} -fpic -ffunction-sections -funwind-tables -fstack-protector -fno-strict-aliasing -finline-limit=64"
    export CXXFLAGS="${CFLAGS} -frtti -fexceptions"
    export LDFLAGS="${ARCH_LINK}"    
    
    cd ./build_openssl/openssl-1.1.0f

    PREFIX_PATH=$ANDROID_HOME/openssl_${SURFIX}_out/

    ./Configure ${CFGNAME} \
    --prefix=$PREFIX_PATH \
    zlib \
    no-asm \
    no-shared \
    no-unit-test


    make clean
    make -j4
    make install
}

# arm
#_compile "armeabi" "arm-linux-androideabi" "-mthumb" "" "android" "arm"
# armv7
_compile "armeabi-v7a" "arm-linux-androideabi" "-march=armv7-a -mfloat-abi=softfp -mfpu=vfpv3-d16" "-march=armv7-a -Wl,--fix-cortex-a8" "android-armeabi" "arm"
# arm64v8
#_compile "arm64-v8a" "aarch64-linux-android" "" "" "android64-aarch64" "arm64"
# x86
#_compile "x86" "i686-linux-android" "-march=i686 -m32 -msse3 -mstackrealign -mfpmath=sse -mtune=intel" "" "android-x86" "x86"
# x86_64
#_compile "x86_64" "x86_64-linux-android" "-march=x86-64 -m64 -msse4.2 -mpopcnt  -mtune=intel" "" "android64" "x86_64"
# mips
#_compile "mips" "mipsel-linux-android" "" "" "android-mips" "mips"
# mips64
#_compile "mips64" "mips64el-linux-android" "" "" "linux64-mips64" "mips64"

echo "all done"