# TLS libraries

To make curl support TLS based protocols, such as HTTPS, FTPS, SMTPS, POP3S,
IMAPS and more, you need to build with a third-party TLS library since curl
does not implement the TLS protocol itself.

curl is written to work with a large number of TLS libraries:

 - AmiSSL
 - AWS-LC
 - BearSSL
 - BoringSSL
 - GnuTLS
 - libressl
 - mbedTLS
 - OpenSSL
 - rustls
 - Schannel (native Windows)
 - Secure Transport (native macOS)
 - WolfSSL

When you build curl and libcurl to use one of these libraries, it is important
that you have the library and its include headers installed on your build
machine.

## configure

Below, you learn how to tell configure to use the different libraries. The
configure script does not select any TLS library by default. You must select
one, or instruct configure that you want to build without TLS support using
`--without-ssl`.

### OpenSSL, BoringSSL, libressl

    ./configure --with-openssl

configure detects OpenSSL in its default path by default. You can optionally
point configure to a custom install path prefix where it can find OpenSSL:

    ./configure --with-openssl=/home/user/installed/openssl

The alternatives [BoringSSL](boringssl.md) and libressl look similar enough
that configure detects them the same way as OpenSSL. It then uses additional
measures to figure out which of the particular flavors it is using.

### GnuTLS

    ./configure --with-gnutls

configure detects GnuTLS in its default path by default. You can optionally
point configure to a custom install path prefix where it can find gnutls:

    ./configure --with-gnutls=/home/user/installed/gnutls

### WolfSSL

    ./configure --with-wolfssl

configure detects WolfSSL in its default path by default. You can optionally
point configure to a custom install path prefix where it can find WolfSSL:

    ./configure --with-wolfssl=/home/user/installed/wolfssl

### mbedTLS

    ./configure --with-mbedtls

configure detects mbedTLS in its default path by default. You can optionally
point configure to a custom install path prefix where it can find mbedTLS:

    ./configure --with-mbedtls=/home/user/installed/mbedtls

### Secure Transport

    ./configure --with-secure-transport

configure detects Secure Transport in its default path by default. You can
optionally point configure to a custom install path prefix where it can find
Secure Transport:

    ./configure --with-secure-transport=/home/user/installed/darwinssl

### Schannel

    ./configure --with-schannel

configure detects Schannel in its default path by default.

(WinSSL was previously an alternative name for Schannel, and earlier curl
versions instead needed `--with-winssl`)

### BearSSL

    ./configure --with-bearssl

configure detects BearSSL in its default path by default. You can optionally
point configure to a custom install path prefix where it can find BearSSL:

    ./configure --with-bearssl=/home/user/installed/bearssl

### Rustls

    ./configure --with-rustls

When told to use rustls, curl is actually trying to find and use the
rustls-ffi library - the C API for the rustls library. configure detects
rustls-ffi in its default path by default. You can optionally point configure
to a custom install path prefix where it can find rustls-ffi:

    ./configure --with-rustls=/home/user/installed/rustls-ffi
