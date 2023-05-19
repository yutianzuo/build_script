#!/usr/bin/env bash

CMAKE_BIN="${HOME}/Library/Android/sdk/cmake/3.22.1/bin/cmake"
#NDK_PATH="/Users/tianzuoyu/Downloads/android-ndk-r15c"
NDK_PATH="${HOME}/Library/Android/sdk/ndk/21.1.6352462"
ARCH="$1"
NAME=nghttp2-1400

if [[ -z "$1" ]]; then
    echo "input arch please"
    exit 1
fi

mkdir "$(pwd)/${NAME}_${ARCH}_out"
${CMAKE_BIN} -B "$(pwd)/${NAME}_${ARCH}_out" \
-DCMAKE_BUILD_TYPE=Release \
-DANDROID_ABI="${ARCH}" \
-DANDROID_PLATFORM=android-21 \
-DANDROID_NDK="${NDK_PATH}" \
-DCMAKE_TOOLCHAIN_FILE="${NDK_PATH}/build/cmake/android.toolchain.cmake" \
-DCMAKE_VERBOSE_MAKEFILE:BOOL=ON \
-DENABLE_STATIC_LIB=ON \
-DENABLE_SHARED_LIB=OFF \
./build_nghttp2/nghttp2-1.40.0