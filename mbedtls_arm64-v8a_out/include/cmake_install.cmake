# Install script for directory: /Users/tianzuoyu/code/github/mbedtls/include

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/usr/local")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "release")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "0")
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "TRUE")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/mbedtls" TYPE FILE PERMISSIONS OWNER_READ OWNER_WRITE GROUP_READ WORLD_READ FILES
    "/Users/tianzuoyu/code/github/mbedtls/include/mbedtls/aes.h"
    "/Users/tianzuoyu/code/github/mbedtls/include/mbedtls/aria.h"
    "/Users/tianzuoyu/code/github/mbedtls/include/mbedtls/asn1.h"
    "/Users/tianzuoyu/code/github/mbedtls/include/mbedtls/asn1write.h"
    "/Users/tianzuoyu/code/github/mbedtls/include/mbedtls/base64.h"
    "/Users/tianzuoyu/code/github/mbedtls/include/mbedtls/bignum.h"
    "/Users/tianzuoyu/code/github/mbedtls/include/mbedtls/build_info.h"
    "/Users/tianzuoyu/code/github/mbedtls/include/mbedtls/camellia.h"
    "/Users/tianzuoyu/code/github/mbedtls/include/mbedtls/ccm.h"
    "/Users/tianzuoyu/code/github/mbedtls/include/mbedtls/chacha20.h"
    "/Users/tianzuoyu/code/github/mbedtls/include/mbedtls/chachapoly.h"
    "/Users/tianzuoyu/code/github/mbedtls/include/mbedtls/check_config.h"
    "/Users/tianzuoyu/code/github/mbedtls/include/mbedtls/cipher.h"
    "/Users/tianzuoyu/code/github/mbedtls/include/mbedtls/cmac.h"
    "/Users/tianzuoyu/code/github/mbedtls/include/mbedtls/compat-2.x.h"
    "/Users/tianzuoyu/code/github/mbedtls/include/mbedtls/config_psa.h"
    "/Users/tianzuoyu/code/github/mbedtls/include/mbedtls/constant_time.h"
    "/Users/tianzuoyu/code/github/mbedtls/include/mbedtls/ctr_drbg.h"
    "/Users/tianzuoyu/code/github/mbedtls/include/mbedtls/debug.h"
    "/Users/tianzuoyu/code/github/mbedtls/include/mbedtls/des.h"
    "/Users/tianzuoyu/code/github/mbedtls/include/mbedtls/dhm.h"
    "/Users/tianzuoyu/code/github/mbedtls/include/mbedtls/ecdh.h"
    "/Users/tianzuoyu/code/github/mbedtls/include/mbedtls/ecdsa.h"
    "/Users/tianzuoyu/code/github/mbedtls/include/mbedtls/ecjpake.h"
    "/Users/tianzuoyu/code/github/mbedtls/include/mbedtls/ecp.h"
    "/Users/tianzuoyu/code/github/mbedtls/include/mbedtls/entropy.h"
    "/Users/tianzuoyu/code/github/mbedtls/include/mbedtls/error.h"
    "/Users/tianzuoyu/code/github/mbedtls/include/mbedtls/gcm.h"
    "/Users/tianzuoyu/code/github/mbedtls/include/mbedtls/hkdf.h"
    "/Users/tianzuoyu/code/github/mbedtls/include/mbedtls/hmac_drbg.h"
    "/Users/tianzuoyu/code/github/mbedtls/include/mbedtls/mbedtls_config.h"
    "/Users/tianzuoyu/code/github/mbedtls/include/mbedtls/md.h"
    "/Users/tianzuoyu/code/github/mbedtls/include/mbedtls/md5.h"
    "/Users/tianzuoyu/code/github/mbedtls/include/mbedtls/memory_buffer_alloc.h"
    "/Users/tianzuoyu/code/github/mbedtls/include/mbedtls/net_sockets.h"
    "/Users/tianzuoyu/code/github/mbedtls/include/mbedtls/nist_kw.h"
    "/Users/tianzuoyu/code/github/mbedtls/include/mbedtls/oid.h"
    "/Users/tianzuoyu/code/github/mbedtls/include/mbedtls/pem.h"
    "/Users/tianzuoyu/code/github/mbedtls/include/mbedtls/pk.h"
    "/Users/tianzuoyu/code/github/mbedtls/include/mbedtls/pkcs12.h"
    "/Users/tianzuoyu/code/github/mbedtls/include/mbedtls/pkcs5.h"
    "/Users/tianzuoyu/code/github/mbedtls/include/mbedtls/platform.h"
    "/Users/tianzuoyu/code/github/mbedtls/include/mbedtls/platform_time.h"
    "/Users/tianzuoyu/code/github/mbedtls/include/mbedtls/platform_util.h"
    "/Users/tianzuoyu/code/github/mbedtls/include/mbedtls/poly1305.h"
    "/Users/tianzuoyu/code/github/mbedtls/include/mbedtls/private_access.h"
    "/Users/tianzuoyu/code/github/mbedtls/include/mbedtls/psa_util.h"
    "/Users/tianzuoyu/code/github/mbedtls/include/mbedtls/ripemd160.h"
    "/Users/tianzuoyu/code/github/mbedtls/include/mbedtls/rsa.h"
    "/Users/tianzuoyu/code/github/mbedtls/include/mbedtls/sha1.h"
    "/Users/tianzuoyu/code/github/mbedtls/include/mbedtls/sha256.h"
    "/Users/tianzuoyu/code/github/mbedtls/include/mbedtls/sha512.h"
    "/Users/tianzuoyu/code/github/mbedtls/include/mbedtls/ssl.h"
    "/Users/tianzuoyu/code/github/mbedtls/include/mbedtls/ssl_cache.h"
    "/Users/tianzuoyu/code/github/mbedtls/include/mbedtls/ssl_ciphersuites.h"
    "/Users/tianzuoyu/code/github/mbedtls/include/mbedtls/ssl_cookie.h"
    "/Users/tianzuoyu/code/github/mbedtls/include/mbedtls/ssl_ticket.h"
    "/Users/tianzuoyu/code/github/mbedtls/include/mbedtls/threading.h"
    "/Users/tianzuoyu/code/github/mbedtls/include/mbedtls/timing.h"
    "/Users/tianzuoyu/code/github/mbedtls/include/mbedtls/version.h"
    "/Users/tianzuoyu/code/github/mbedtls/include/mbedtls/x509.h"
    "/Users/tianzuoyu/code/github/mbedtls/include/mbedtls/x509_crl.h"
    "/Users/tianzuoyu/code/github/mbedtls/include/mbedtls/x509_crt.h"
    "/Users/tianzuoyu/code/github/mbedtls/include/mbedtls/x509_csr.h"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/psa" TYPE FILE PERMISSIONS OWNER_READ OWNER_WRITE GROUP_READ WORLD_READ FILES
    "/Users/tianzuoyu/code/github/mbedtls/include/psa/crypto.h"
    "/Users/tianzuoyu/code/github/mbedtls/include/psa/crypto_builtin_composites.h"
    "/Users/tianzuoyu/code/github/mbedtls/include/psa/crypto_builtin_primitives.h"
    "/Users/tianzuoyu/code/github/mbedtls/include/psa/crypto_compat.h"
    "/Users/tianzuoyu/code/github/mbedtls/include/psa/crypto_config.h"
    "/Users/tianzuoyu/code/github/mbedtls/include/psa/crypto_driver_common.h"
    "/Users/tianzuoyu/code/github/mbedtls/include/psa/crypto_driver_contexts_composites.h"
    "/Users/tianzuoyu/code/github/mbedtls/include/psa/crypto_driver_contexts_primitives.h"
    "/Users/tianzuoyu/code/github/mbedtls/include/psa/crypto_extra.h"
    "/Users/tianzuoyu/code/github/mbedtls/include/psa/crypto_platform.h"
    "/Users/tianzuoyu/code/github/mbedtls/include/psa/crypto_se_driver.h"
    "/Users/tianzuoyu/code/github/mbedtls/include/psa/crypto_sizes.h"
    "/Users/tianzuoyu/code/github/mbedtls/include/psa/crypto_struct.h"
    "/Users/tianzuoyu/code/github/mbedtls/include/psa/crypto_types.h"
    "/Users/tianzuoyu/code/github/mbedtls/include/psa/crypto_values.h"
    )
endif()

