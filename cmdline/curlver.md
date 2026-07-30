# Version

To get to know what version of curl you have installed, run

    curl --version

or use the shorthand version:

    curl -V

The output from that command line is typically four lines, out of which some
are rather long and might wrap in your terminal window.

An example output from a Debian Linux in June 2020:

    curl 7.68.0 (x86_64-pc-linux-gnu) libcurl/7.68.0 OpenSSL/1.1.1g
    zlib/1.2.11 brotli/1.0.7 libidn2/2.3.0 libpsl/0.21.0 (+libidn2/2.3.0)
    libssh2/1.8.0 nghttp2/1.41.0 librtmp/2.3
    Release-Date: 2020-01-08
    Protocols: dict file ftp ftps gopher http https imap imaps ldap ldaps
    pop3 pop3s rtmp rtsp scp sftp smb smbs smtp smtps telnet tftp
    Features: AsynchDNS brotli GSS-API HTTP2 HTTPS-proxy IDN IPv6 Kerberos
    Largefile libz NTLM NTLM_WB PSL SPNEGO SSL TLS-SRP UnixSockets

while the same command line invoked on a Windows 10 machine on the same date
looks like:

    curl 7.55.1 (Windows) libcurl/7.55.1 WinSSL
    Release-Date: [unreleased]
    Protocols: dict file ftp ftps http https imap imaps pop3 pop3s smtp
    smtps telnet tftp
    Features: AsynchDNS IPv6 Largefile SSPI Kerberos SPNEGO NTLM SSL

The meaning of the four lines?

## Line 1: curl

The first line starts with `curl` and first shows the main version number of
the tool. Then follows the platform the tool was built for within parentheses
and the libcurl version. Those three fields are common for all curl builds.

If the curl version number has `-DEV` appended to it, it means the version is
built straight from an in-development source code and it is not an officially
released and blessed version.

The rest of this line contains names of third party components this build of
curl uses, often with their individual version number next to it with a slash
separator. Like `OpenSSL/1.1.1g` and `nghttp2/1.41.0`. This can for example
tell you which TLS backends this curl uses.

### Line 1: TLS versions

Line 1 may contain one or more TLS libraries. curl can be built to support
more than one TLS library which then makes curl - at start-up - select which
particular backend to use for this invocation.

If curl supports more than one TLS library like this, the ones that are *not*
selected by default are listed within parentheses. Thus, if you do not specify
which backend to use (with the `CURL_SSL_BACKEND` environment variable)
the one listed without parentheses is used.

## Line 2: Release-Date

This line shows the date this curl version was released by the curl project,
and it can also show a secondary "Patch date" if it has been updated somehow
after it was originally released.

This says `[unreleased]` if curl was built another way than from a release
tarball, and as you can see above that is how Microsoft did it for Windows 10
and the curl project does not recommend it.

## Line 3: Protocols

This is a list of all transfer protocols (URL schemes really) in alphabetical
order that this curl build supports. All names are shown in lowercase letters.

This list can contain these protocols:

dict, file, ftp, ftps, gopher, http, https, imap, imaps, ldap, ldaps, mqtt,
pop3, pop3s, rtsp, scp, sftp, smb, smbs, smtp, smtps, telnet and tftp

## Line 4: Features

The list of features this build of curl supports. If the name is present in
the list, that feature is enabled. If the name is not present, that feature is
not enabled.

Features that can be present there and their meaning:

 - **alt-svc** - Support for the `Alt-Svc:` header. See [--alt-svc](../http/https/altsvc.md)
 - **AsynchDNS** - This curl uses asynchronous name resolves. Asynchronous
   name resolves can be done using either the c-ares or the threaded resolver
   backends.
 - **brotli** - support for automatic brotli decompression over HTTP(S). See [--compress](../http/modify/compression.md)
 - **CharConv** - curl was built with support for character set conversions
   (like EBCDIC)
 - **Debug** - This curl uses a libcurl built with Debug. This enables more
   error-tracking and memory debugging etc. For curl-developers only. Never use a debug
   build in production.
 - **ECH** - Encrypted Client Hello (ECH) support is present. See
   [--ech](../usingcurl/tls/ech.md)
 - **gsasl** - The built-in SASL authentication includes extensions to support
   SCRAM because libcurl was built with libgsasl.
 - **GSS-API** - GSS-API authentication is enabled
 - **HSTS** - HTTP Strict Transport Security (HSTS) is supported. See
   [--hsts](../http/https/hsts.md)
 - **HTTP2** - HTTP/2 support has been built-in. See [--http2](../http/versions/http2.md)
 - **HTTP3** - HTTP/3 support has been built-in. See [--http3](../http/versions/http3.md)
 - **HTTPS-proxy** - This curl is built to support HTTPS proxy. See
   [--proxy](../usingcurl/proxies/https.md)
 - **IDN** - This curl supports IDN - international domain names.
 - **IPv6** - You can use IPv6 with this tool.
 - **Kerberos** - Kerberos V5 authentication is supported.
 - **Largefile** - This curl supports transfers of large files, files larger
   than 2GB.
 - **libz** - Automatic gzip decompression of compressed files over HTTP is
   supported.
 - **MultiSSL** - This curl supports multiple TLS backends. The first line
    details exactly which TLS libraries.
 - **NTLM** - NTLM authentication is supported.
 - **NTLM_WB** - NTLM authentication is supported. This feature was removed
   from curl in 8.8.0.
 - **PSL** - Public Suffix List (PSL) is available and means that this curl
   has been built with knowledge about *public suffixes*, used for cookies.
 - **SPNEGO** - SPNEGO authentication is supported.
 - **SSL** - SSL versions of various protocols are supported, such as HTTPS,
   FTPS, POP3S and so on.
 - **SSPI** - SSPI is supported
 - **TLS-SRP** - SRP (Secure Remote Password) authentication is supported for
   TLS. This feature was removed in curl 8.22.0.
 - **Unicode** - Unicode support enabled on Windows.
 - **UnixSockets** - Unix sockets support is provided.
 - **zstd** - support for automatic zstd decompression over HTTP(S). See [--compress](../http/modify/compression.md)
