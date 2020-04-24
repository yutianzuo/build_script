#!/bin/sh

_compile() {
    SURFIX=$1
    TOOL=$2
    ARCH_FLAGS=$3
    ARCH_LINK=$4
    ARCH=$5
    
    mkdir "./curl_${SURFIX}_out" 

    #custom NDK Path, use android studio default(latest)
    #export ANDROID_NDK=/Users/yutianzuo/Library/Android/sdk/ndk-bundle

    TARGET_SOURCE="curl-7.59.0"
    
    $ANDROID_NDK/build/tools/make-standalone-toolchain.sh --arch=${ARCH} --install-dir=./curl_toolchain_${SURFIX} --force

    
    export ANDROID_HOME=`pwd`
    export TOOLCHAIN=$ANDROID_HOME/curl_toolchain_${SURFIX}
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
    export CFLAGS="${ARCH_FLAGS} -fpic -ffunction-sections -funwind-tables -fno-stack-protector -fno-strict-aliasing -finline-limit=64"
    export CXXFLAGS="${CFLAGS} -frtti -fexceptions"
    export LDFLAGS="${ARCH_LINK}"    

    #copy ssl .h and .a,fix the path
    cp ${ANDROID_HOME}/openssl_${SURFIX}_out/lib/libssl.a ${CROSS_SYSROOT}/usr/lib
    cp ${ANDROID_HOME}/openssl_${SURFIX}_out/lib/libcrypto.a ${CROSS_SYSROOT}/usr/lib
    cp -r ${ANDROID_HOME}/openssl_${SURFIX}_out/include/openssl ${CROSS_SYSROOT}/usr/include
    
    cd ./build_curl/${TARGET_SOURCE}
    
    ./configure --prefix=$ANDROID_HOME/curl_${SURFIX}_out \
       --with-sysroot=$TOOLCHAIN/sysroot \
       --host=${TOOL} \
       --enable-ipv6 \
       --enable-static \
       --enable-threaded-resolver \
       --disable-dict \
       --disable-gopher \
       --disable-ldap --disable-ldaps \
       --disable-manual \
       --disable-pop3 --disable-smtp --disable-imap \
       --disable-rtsp \
       --disable-shared \
       --disable-smb \
       --disable-telnet \
       --disable-verbose \
       --with-ssl=$TOOLCHAIN/sysroot/usr
       #--with-ca-bundle=$ANDROID_HOME/cacert.pem
       #--with-nghttp2=$TOOLCHAIN/sysroot/usr/local

    make clean
    make -j16
    make install
}

# arm
#_compile "armeabi" "arm-linux-androideabi" "-mthumb -D__ANDROID_API__=20" "" "arm"
# armv7
#_compile "armeabi-v7a" "arm-linux-androideabi" "-march=armv7-a -mfloat-abi=softfp -mfpu=vfpv3-d16" "-march=armv7-a -Wl,--fix-cortex-a8" "arm"
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
