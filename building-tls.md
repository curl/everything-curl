# Build to use a TLS library

To make curl support TLS based protocols, such as HTTPS, FTPS, SMTPS, POP3S,
IMAPS and more, you need to build with a third-party TLS library since curl
doesn't implement the TLS protocol itself.

curl is written to work with a large number of TLS libraries:

 - BoringSSL
 - GSkit (OS/400 specific)
 - GnuTLS
 - NSS
 - OpenSSL
 - Secure Transport (native macOS)
 - WolfSSL
 - axTLS
 - libressl
 - mbedTLS
 - Schannel (native Windows)

When you build curl and libcurl to use one of these libraries, it is important
that you have the library and its include headers installed on your build
machine.

## configure

Below, you will learn how to tell configure to use the different
libraries. Note that for all libraries except OpenSSL and its siblings, you
must *disable* the check for OpenSSL by using `--without-ssl`.

### OpenSSL, BoringSSL, libressl

    ./configure

configure will detect OpenSSL in its default path by default. You can
optionally point configure to a custom install path prefix where it can find
openssl:

    ./configure --with-ssl=/home/user/installed/openssl

The alternatives [BoringSSL](building-boringssl.md) and libressl look similar
enough that configure will detect them the same way as OpenSSL but it will use
some additional measures to find out which of the particular flavors it is
using.

### GnuTLS

    ./configure --with-gnutls --without-ssl

configure will detect GnuTLS in its default path by default. You can
optionally point configure to a custom install path prefix where it can find
gnutls:

    ./configure --with-gnutls=/home/user/installed/gnutls --without-ssl

### NSS

    ./configure --with-nss --without-ssl

configure will detect NSS in its default path by default. You can optionally
point configure to a custom install path prefix where it can find nss:

    ./configure --with-nss=/home/user/installed/nss --without-ssl

### WolfSSL

    ./configure --with-cyassl --without-ssl

(cyassl was the former name of the library) configure will detect WolfSSL in
its default path by default. You can optionally point configure to a custom
install path prefix where it can find WolfSSL:

    ./configure --with-cyassl=/home/user/installed/nss --without-ssl

### axTLS

    ./configure --with-axtls --without-ssl

configure will detect axTLS in its default path by default. You can optionally
point configure to a custom install path prefix where it can find axTLS:

    ./configure --with-axtls=/home/user/installed/axtls --without-ssl

### mbedTLS

    ./configure --with-mbedtls --without-ssl

configure will detect mbedTLS in its default path by default. You can
optionally point configure to a custom install path prefix where it can find
mbedTLS:

    ./configure --with-mbedtls=/home/user/installed/mbedtls --without-ssl

### Secure Transport

    ./configure --with-darwinssl --without-ssl

(DarwinSSL is an alternative name for Secure Transport)
configure will detect Secure Transport in its default path by default. You can
optionally point configure to a custom install path prefix where it can find
DarwinSSL:

    ./configure --with-darwinssl=/home/user/installed/darwinssl --without-ssl

### Schannel

    ./configure --with-winssl --without-ssl

(WinSSL is an alternative name for Schannel)
configure will detect Schannel in its default path by default. You can
optionally point configure to a custom install path prefix where it can find
WinSSL:

    ./configure --with-winssl=/home/user/installed/winssl --without-ssl
