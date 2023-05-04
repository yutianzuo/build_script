#!/usr/bin/env bash

CMAKE_PATH="/Users/tianzuoyu/Library/Android/sdk/cmake/3.10.2.4988404/bin"
CMAKE_BIN="${CMAKE_PATH}/cmake"
#NDK_PATH="/Users/tianzuoyu/Downloads/android-ndk-r15c"
NDK_PATH="/Users/tianzuoyu/Library/Android/sdk/ndk/21.1.6352462"
ARCH="$1"

mkdir "out_${ARCH}"

${CMAKE_BIN} -H/Users/tianzuoyu/code/github/mbedtls \
-DCMAKE_BUILD_TYPE=release \
-B"/Users/tianzuoyu/code/github/mbedtls/mbedtls_${ARCH}_out" \
-DANDROID_ABI="${ARCH}" \
-DANDROID_PLATFORM=android-21 \
-DANDROID_NDK="${NDK_PATH}" \
-DCMAKE_TOOLCHAIN_FILE="${NDK_PATH}/build/cmake/android.toolchain.cmake" \
-DCMAKE_VERBOSE_MAKEFILE:BOOL=ON \

