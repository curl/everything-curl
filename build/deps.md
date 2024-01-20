# Dependencies

A key to making good software is to build on top of other great software. By
using libraries that many others use, we reinvent the same things fewer times
and we get more reliable software as there are more people using the same
code.

A whole slew of features that curl provides require that it is built to use
one or more external libraries. They are then dependencies of curl. None of
them are *required*, but most users want to use at least some of them.

## HTTP Compression

curl can do automatic decompression of data transferred over HTTP if built
with the proper 3rd party libraries. You can build curl to use one or more of
these libraries:

 - gzip compression with [zlib](https://zlib.net/)
 - brotli compression with [brotli](https://github.com/google/brotli)
 - zstd compression with [libzstd](https://github.com/facebook/zstd)

Getting compressed data over the wire uses less bandwidth, which might also
result in shorter transfer times.

## c-ares

<https://c-ares.org/>

curl can be built with c-ares to be able to do asynchronous name resolution.
Another option to enable asynchronous name resolution is to build curl with
the threaded name resolver backend, which then instead creates a separate
helper thread for each name resolve. c-ares does it all within the same
thread.

## nghttp2

<https://nghttp2.org/>

This is a library for handling HTTP/2 framing and is a prerequisite for curl
to support HTTP version 2.

## openldap

<https://www.openldap.org/>

This library is one option to allow curl to get support for the LDAP and LDAPS
URL schemes. On Windows, you can also opt to build curl to use the winldap library.

## librtmp

<https://rtmpdump.mplayerhq.hu/>

To enable curl's support for the RTMP URL scheme, you must build curl with the
librtmp library that comes from the RTMPDump project.

## libpsl

<https://rockdaboot.github.io/libpsl/>

When you build curl with support for libpsl, the cookie parser knows about the
Public Suffix List and thus handles such cookies appropriately.

## libidn2

<https://www.gnu.org/software/libidn/libidn2/manual/libidn2.html>

curl handles International Domain Names (IDN) with the help of the libidn2 library.

## SSH libraries

If you want curl to have SCP and SFTP support, build with one of these SSH
libraries:

- [libssh2](https://libssh2.org/)
- [libssh](https://www.libssh.org/)
- [wolfSSH](https://www.wolfssl.com/products/wolfssh/)

## TLS libraries

There are many different TLS libraries to choose from, so they are covered in
a [separate section](tls.md).

## QUIC and HTTP/3

To build curl with HTTP/3 support, you need one of these sets:

- [ngtcp2](https://github.com/ngtcp2/ngtcp2) + [nghttp3](https://github.com/ngtcp2/nghttp3)
- [quiche](https://github.com/cloudflare/quiche) (**experimental**)
- [msquic](https://github.com/microsoft/msquic) + [msh3](https://github.com/nibanks/msh3) (**experimental**)
