#!/usr/bin/env bash

CMAKE_BIN="${HOME}/Library/Android/sdk/cmake/3.22.1/bin/cmake"
#NDK_PATH="/Users/tianzuoyu/Downloads/android-ndk-r15c"
NDK_PATH="${HOME}/Library/Android/sdk/ndk/21.1.6352462"
ARCH="$1"

mkdir "$(pwd)/mbedtls_${ARCH}_out"

${CMAKE_BIN} -B "$(pwd)/mbedtls_${ARCH}_out" \
-DCMAKE_BUILD_TYPE=Release \
-DANDROID_ABI="${ARCH}" \
-DANDROID_PLATFORM=android-21 \
-DANDROID_NDK="${NDK_PATH}" \
-DCMAKE_TOOLCHAIN_FILE="${NDK_PATH}/build/cmake/android.toolchain.cmake" \
-DCMAKE_VERBOSE_MAKEFILE:BOOL=ON \
../mbedtls
