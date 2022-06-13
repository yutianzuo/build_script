#!/bin/sh


_compile() {
    SURFIX=$1
    TOOL=$2
    ARCH_FLAGS=$3
    ARCH_LINK=$4
    ARCH=$5

#custom NDK Path if needed
    #use lateset
    export ANDROID_NDK=~/Library/Android/sdk/ndk-bundle

    echo "NDK PATH:"
    echo ${ANDROID_NDK}
    
    
    mkdir "./nghttp2_${SURFIX}_out"     
    
    
    $ANDROID_NDK/build/tools/make-standalone-toolchain.sh --arch=${ARCH} --install-dir=./nghttp2_toolchain_${SURFIX} --force 
    # --platform=android-28
    

    export ANDROID_HOME=`pwd`
    export TOOLCHAIN=$ANDROID_HOME/nghttp2_toolchain_${SURFIX}
    export PKG_CONFIG_LIBDIR=$TOOLCHAIN/lib/pkgconfig
    export CROSS_SYSROOT=$TOOLCHAIN/sysroot
    export PATH=$TOOLCHAIN/bin:$PATH
    export CROSS_COMPILE=${TOOLCHAIN}/bin/${TOOL}-

    echo "CROSS_COMPILE IS :"
    echo $CROSS_COMPILE
    echo "CROSS_SYSROOT IS :"
    echo $CROSS_SYSROOT

    cd ./build_nghttp2/nghttp2-1.40.0

    PREFIX_PATH=$ANDROID_HOME/nghttp2_${SURFIX}_out/

    autoreconf -i

    ./configure --prefix=$PREFIX_PATH \
    --disable-shared \
    --enable-lib-only \
    --host=${TOOL} \
    --build=`dpkg-architecture -qDEB_BUILD_GNU_TYPE`

    make clean
    make -j16
    make install
}

# arm
#_compile "armeabi" "arm-linux-androideabi" "-mthumb -D__ANDROID_API__=20" "" "arm"
# armv7
# _compile "armeabi-v7a" "arm-linux-androideabi" "-march=armv7-a -mfloat-abi=softfp -mfpu=neon" "-march=armv7-a -Wl,--fix-cortex-a8" "arm"
# arm64v8, maybe should compile with a lower ndk
# _compile "arm64-v8a" "aarch64-linux-android" "" "" "arm64"
# x86
#_compile "x86" "i686-linux-android" "-march=i686 -m32 -msse3 -mstackrealign -mfpmath=sse -mtune=intel" "" "x86"
# x86_64
_compile "x86_64" "x86_64-linux-android" "-march=x86-64 -m64 -msse4.2 -mpopcnt  -mtune=intel" "" "x86_64"
# mips
#_compile "mips" "mipsel-linux-android" "" "" "mips"
# mips64
#_compile "mips64" "mips64el-linux-android" "" "" "mips64"


echo "all done"

