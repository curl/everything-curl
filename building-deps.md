# Dependencies

A key to making good software is to build on top of other great software. By
using libraries that many others use, we reinvent the same things fewer times
and we get more reliable software as there are more people using the same
code.

A whole slew of features that curl provides require that it is built to use
one or more external libraries. They are then dependencies of curl. None of
them are *required*, but most users will want to use at least some of them.

## zlib

https://zlib.net/

curl can do automatic decompression of data transferred over HTTP if built with
zlib. Getting compressed data over the wire will use less bandwidth.

## c-ares

https://c-ares.haxx.se/

curl can be built with c-ares to be able to do asynchronous name resolution.
Another option to enable asynchronous name resolution is to build curl with the
threaded name resolver backend, which will then instead create a separate
helper thread for each name resolve. c-ares does it all within the
same thread.

## libssh2

https://libssh2.org/

When curl is built with libssh2, it enables support for the SCP and SFTP
protocols.

## nghttp2

https://nghttp2.org/

This is a library for handling HTTP/2 framing and is a prerequisite for curl
to support HTTP version 2.

## openldap

https://www.openldap.org/

This library is one option to allow curl to get support for the LDAP and LDAPS
URL schemes. On Windows, you can also opt to build curl to use the winldap library.

## librtmp

https://rtmpdump.mplayerhq.hu/

To enable curl's support for the RTMP URL scheme, you must build curl with the
librtmp library that comes from the RTMPDump project.

## libmetalink

https://launchpad.net/libmetalink

Build curl with libmetalink to have it support the
[metalink](https://www.metalinker.org/) format, which allows curl to download
the same file from multiple places. It includes checksums and more. See curl's
[--metalink](https://www.curl.se/docs/manpage.html#--metalink) option.

## libpsl

https://rockdaboot.github.io/libpsl/

When you build curl with support for libpsl, the cookie parser will know about
the Public Suffix List and thus handle such cookies appropriately.

## libidn2

https://www.gnu.org/software/libidn/libidn2/manual/libidn2.html

curl handles International Domain Names (IDN) with the help of the libidn2 library.

## TLS libraries

There are many different TLS libraries to choose from, so they are covered in
a [separate section](building-tls.md).
