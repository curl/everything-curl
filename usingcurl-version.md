## Version

To get to know what version of curl you have installed, run

    curl --version

or use the shorthand version:

    curl -V

The output from that command line is typically four lines, out of which some
will be rather long and might very well wrap in your terminal window.

An example output from a Debian Linux as of June 2020:

    curl 7.68.0 (x86_64-pc-linux-gnu) libcurl/7.68.0 OpenSSL/1.1.1g zlib/1.2.11 brotli/1.0.7 libidn2/2.3.0 libpsl/0.21.0 (+libidn2/2.3.0) libssh2/1.8.0 nghttp2/1.41.0 librtmp/2.3
    Release-Date: 2020-01-08
    Protocols: dict file ftp ftps gopher http https imap imaps ldap ldaps pop3 pop3s rtmp rtsp scp sftp smb smbs smtp smtps telnet tftp 
    Features: AsynchDNS brotli GSS-API HTTP2 HTTPS-proxy IDN IPv6 Kerberos Largefile libz NTLM NTLM_WB PSL SPNEGO SSL TLS-SRP UnixSockets

while the same command line invoked on a Windows 10 machine on the same date looks like:

    curl 7.55.1 (Windows) libcurl/7.55.1 WinSSL
    Release-Date: [unreleased]
    Protocols: dict file ftp ftps http https imap imaps pop3 pop3s smtp smtps telnet tftp
    Features: AsynchDNS IPv6 Largefile SSPI Kerberos SPNEGO NTLM SSL
    
The meaning of the four lines?

## Line 1: curl

The first line starts with `curl` and first shows the main version number of
the tool. Then follows the "platform" the tool was built for within
parentheses and the libcurl version. Those three fields are common for all curl bvuilds

## Line 2: Release-Date

TBD

## Line 3: Protocols

TBD

## Line 4: Features

TBD
