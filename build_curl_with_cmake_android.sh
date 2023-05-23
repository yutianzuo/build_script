#!/usr/bin/env bash

CMAKE_BIN="${HOME}/Library/Android/sdk/cmake/3.22.1/bin/cmake"
#NDK_PATH="/Users/tianzuoyu/Downloads/android-ndk-r15c"
NDK_PATH="${HOME}/Library/Android/sdk/ndk/21.1.6352462"
ARCH="$1"
NAME=curl8
CROSS_LIBS="$(pwd)/cross_compile_libs/${ARCH}"

if [[ -z "$1" ]]; then
    echo "input arch please"
    exit 1
fi

mkdir "$(pwd)/${NAME}_${ARCH}_out"
#通过cmake编译curl，无法strip，库会比较大，不影响使用，在最终的android编译动态库时，会统一被strip掉
#也可以通过-DCMAKE_C_FLAGS_RELEASE="-O3 -g0"将-g0参数传递给clang，将静态库的符号去除，-O3为可选
${CMAKE_BIN} -B "$(pwd)/${NAME}_${ARCH}_out" \
-DCMAKE_INSTALL_PREFIX="$(pwd)/${NAME}_${ARCH}_out" \
-DENABLE_MANUAL=OFF \
-DCURL_DISABLE_VERBOSE_STRINGS=ON \
-DCMAKE_FIND_ROOT_PATH="${CROSS_LIBS}" \
-DHTTP_ONLY=ON \
-DENABLE_THREADED_RESOLVER=ON \
-DCURL_USE_MBEDTLS=ON \
-DUSE_NGHTTP2=ON \
-DBUILD_SHARED_LIBS=OFF \
-DCMAKE_BUILD_TYPE=Release \
-DANDROID_ABI="${ARCH}" \
-DANDROID_PLATFORM=android-21 \
-DANDROID_NDK="${NDK_PATH}" \
-DCMAKE_TOOLCHAIN_FILE="${NDK_PATH}/build/cmake/android.toolchain.cmake" \
-DCMAKE_VERBOSE_MAKEFILE:BOOL=ON \
./build_curl/curl-8.0.1
