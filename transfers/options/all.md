# All options

This is a table of available options for `curl_easy_setopt()`.

| Option                               | Purpose                                                                |
|--------------------------------------|------------------------------------------------------------------------|
| `CURLOPT_ABSTRACT_UNIX_SOCKET`       | abstract Unix domain socket                                            |
| `CURLOPT_ACCEPT_ENCODING`            | automatic decompression of HTTP downloads                              |
| `CURLOPT_ACCEPTTIMEOUT_MS`           | timeout waiting for FTP server to connect back                         |
| `CURLOPT_ADDRESS_SCOPE`              | scope id for IPv6 addresses                                            |
| `CURLOPT_ALTSVC_CTRL`                | control alt-svc behavior                                               |
| `CURLOPT_ALTSVC`                     | alt-svc cache filename                                                 |
| `CURLOPT_APPEND`                     | append to the remote file                                              |
| `CURLOPT_AUTOREFERER`                | automatically update the referer header                                |
| `CURLOPT_AWS_SIGV4`                  | V4 signature                                                           |
| `CURLOPT_BUFFERSIZE`                 | receive buffer size                                                    |
| `CURLOPT_CA_CACHE_TIMEOUT`           | life-time for cached certificate stores                                |
| `CURLOPT_CAINFO_BLOB`                | Certificate Authority (CA) bundle in PEM format                        |
| `CURLOPT_CAINFO`                     | path to Certificate Authority (CA) bundle                              |
| `CURLOPT_CAPATH`                     | directory holding CA certificates                                      |
| `CURLOPT_CERTINFO`                   | request SSL certificate information                                    |
| `CURLOPT_CHUNK_BGN_FUNCTION`         | callback before a transfer with FTP wildcardmatch                      |
| `CURLOPT_CHUNK_DATA`                 | pointer passed to the FTP chunk callbacks                              |
| `CURLOPT_CHUNK_END_FUNCTION`         | callback after a transfer with FTP wildcardmatch                       |
| `CURLOPT_CLOSESOCKETDATA`            | pointer passed to the socket close callback                            |
| `CURLOPT_CLOSESOCKETFUNCTION`        | callback to socket close replacement                                   |
| `CURLOPT_CONNECT_ONLY`               | stop when connected to target server                                   |
| `CURLOPT_CONNECT_TO`                 | connect to a specific host and port instead of the URL's host and port |
| `CURLOPT_CONNECTTIMEOUT_MS`          | timeout for the connect phase                                          |
| `CURLOPT_CONNECTTIMEOUT`             | timeout for the connect phase                                          |
| `CURLOPT_CONV_FROM_NETWORK_FUNCTION` | convert data from network to host encoding                             |
| `CURLOPT_CONV_FROM_UTF8_FUNCTION`    | convert data from UTF8 to host encoding                                |
| `CURLOPT_CONV_TO_NETWORK_FUNCTION`   | convert data to network from host encoding                             |
| `CURLOPT_COOKIE`                     | HTTP Cookie header                                                     |
| `CURLOPT_COOKIEFILE`                 | filename to read cookies from                                          |
| `CURLOPT_COOKIEJAR`                  | filename to store cookies to                                           |
| `CURLOPT_COOKIELIST`                 | add to or manipulate cookies held in memory                            |
| `CURLOPT_COOKIESESSION`              | start a new cookie session                                             |
| `CURLOPT_COPYPOSTFIELDS`             | have libcurl copy data to POST                                         |
| `CURLOPT_CRLF`                       | CRLF conversion                                                        |
| `CURLOPT_CRLFILE`                    | Certificate Revocation List file                                       |
| `CURLOPT_CURLU`                      | URL in CURLU * format                                                  |
| `CURLOPT_CUSTOMREQUEST`              | custom request method                                                  |
| `CURLOPT_DEBUGDATA`                  | pointer passed to the debug callback                                   |
| `CURLOPT_DEBUGFUNCTION`              | debug callback                                                         |
| `CURLOPT_DEFAULT_PROTOCOL`           | default protocol to use if the URL is missing a                        |
| `CURLOPT_DIRLISTONLY`                | ask for names only in a directory listing                              |
| `CURLOPT_DISALLOW_USERNAME_IN_URL`   | disallow specifying username in the URL                                |
| `CURLOPT_DNS_CACHE_TIMEOUT`          | life-time for DNS cache entries                                        |
| `CURLOPT_DNS_INTERFACE`              | interface to speak DNS over                                            |
| `CURLOPT_DNS_LOCAL_IP4`              | IPv4 address to bind DNS resolves to                                   |
| `CURLOPT_DNS_LOCAL_IP6`              | IPv6 address to bind DNS resolves to                                   |
| `CURLOPT_DNS_SERVERS`                | DNS servers to use                                                     |
| `CURLOPT_DNS_SHUFFLE_ADDRESSES`      | shuffle IP addresses for hostname                                      |
| `CURLOPT_DNS_USE_GLOBAL_CACHE`       | global DNS cache                                                       |
| `CURLOPT_DOH_SSL_VERIFYHOST`         | verify the hostname in the DoH SSL certificate                         |
| `CURLOPT_DOH_SSL_VERIFYPEER`         | verify the DoH SSL certificate                                         |
| `CURLOPT_DOH_SSL_VERIFYSTATUS`       | verify the DoH SSL certificate's status                                |
| `CURLOPT_DOH_URL`                    | provide the DNS-over-HTTPS URL                                         |
| `CURLOPT_EGDSOCKET`                  | EGD socket path                                                        |
| `CURLOPT_ERRORBUFFER`                | error buffer for error messages                                        |
| `CURLOPT_EXPECT_100_TIMEOUT_MS`      | timeout for Expect: 100-continue response                              |
| `CURLOPT_FAILONERROR`                | request failure on HTTP response >= 400                                |
| `CURLOPT_FILETIME`                   | get the modification time of the remote resource                       |
| `CURLOPT_FNMATCH_DATA`               | pointer passed to the fnmatch callback                                 |
| `CURLOPT_FNMATCH_FUNCTION`           | wildcard match callback                                                |
| `CURLOPT_FOLLOWLOCATION`             | follow HTTP 3xx redirects                                              |
| `CURLOPT_FORBID_REUSE`               | make connection get closed at once after use                           |
| `CURLOPT_FRESH_CONNECT`              | force a new connection to be used                                      |
| `CURLOPT_FTP_ACCOUNT`                | account info for FTP                                                   |
| `CURLOPT_FTP_ALTERNATIVE_TO_USER`    | command to use instead of USER with FTP                                |
| `CURLOPT_FTP_CREATE_MISSING_DIRS`    | create missing dirs for FTP and SFTP                                   |
| `CURLOPT_FTP_FILEMETHOD`             | select directory traversing method for FTP                             |
| `CURLOPT_FTP_RESPONSE_TIMEOUT`       | time allowed to wait for FTP response                                  |
| `CURLOPT_FTP_SKIP_PASV_IP`           | ignore the IP address in the PASV response                             |
| `CURLOPT_FTP_SSL_CCC`                | switch off SSL again with FTP after auth                               |
| `CURLOPT_FTP_USE_EPRT`               | use EPRT for FTP                                                       |
| `CURLOPT_FTP_USE_EPSV`               | use EPSV for FTP                                                       |
| `CURLOPT_FTP_USE_PRET`               | use PRET for FTP                                                       |
| `CURLOPT_FTPPORT`                    | make FTP transfer active                                               |
| `CURLOPT_FTPSSLAUTH`                 | order in which to attempt TLS vs SSL                                   |
| `CURLOPT_GSSAPI_DELEGATION`          | allowed GSS-API delegation                                             |
| `CURLOPT_HAPPY_EYEBALLS_TIMEOUT_MS`  | head start for ipv6 for happy eyeballs                                 |
| `CURLOPT_HAPROXY_CLIENT_IP`          | set HAProxy PROXY protocol client IP                                   |
| `CURLOPT_HAPROXYPROTOCOL`            | send HAProxy PROXY protocol v1 header                                  |
| `CURLOPT_HEADER`                     | pass headers to the data stream                                        |
| `CURLOPT_HEADERDATA`                 | pointer to pass to header callback                                     |
| `CURLOPT_HEADERFUNCTION`             | callback that receives header data                                     |
| `CURLOPT_HEADEROPT`                  | send HTTP headers to both proxy and host or separately                 |
| `CURLOPT_HSTS_CTRL`                  | control HSTS behavior                                                  |
| `CURLOPT_HSTS`                       | HSTS cache filename                                                    |
| `CURLOPT_HSTSREADDATA`               | pointer passed to the HSTS read callback                               |
| `CURLOPT_HSTSREADFUNCTION`           | read callback for HSTS hosts                                           |
| `CURLOPT_HSTSWRITEDATA`              | pointer passed to the HSTS write callback                              |
| `CURLOPT_HSTSWRITEFUNCTION`          | write callback for HSTS hosts                                          |
| `CURLOPT_HTTP09_ALLOWED`             | allow HTTP/0.9 response                                                |
| `CURLOPT_HTTP200ALIASES`             | alternative matches for HTTP 200 OK                                    |
| `CURLOPT_HTTP_CONTENT_DECODING`      | HTTP content decoding control                                          |
| `CURLOPT_HTTP_TRANSFER_DECODING`     | HTTP transfer decoding control                                         |
| `CURLOPT_HTTP_VERSION`               | HTTP protocol version to use                                           |
| `CURLOPT_HTTPAUTH`                   | HTTP server authentication methods to try                              |
| `CURLOPT_HTTPGET`                    | ask for an HTTP GET request                                            |
| `CURLOPT_HTTPHEADER`                 | set of HTTP headers                                                    |
| `CURLOPT_HTTPPOST`                   | multipart formpost content                                             |
| `CURLOPT_HTTPPROXYTUNNEL`            | tunnel through HTTP proxy                                              |
| `CURLOPT_IGNORE_CONTENT_LENGTH`      | ignore content length                                                  |
| `CURLOPT_INFILESIZE_LARGE`           | size of the input file to send off                                     |
| `CURLOPT_INFILESIZE`                 | size of the input file to send off                                     |
| `CURLOPT_INTERFACE`                  | source interface for outgoing traffic                                  |
| `CURLOPT_INTERLEAVEDATA`             | pointer passed to RTSP interleave callback                             |
| `CURLOPT_INTERLEAVEFUNCTION`         | callback for RTSP interleaved data                                     |
| `CURLOPT_IOCTLDATA`                  | pointer passed to I/O callback                                         |
| `CURLOPT_IOCTLFUNCTION`              | callback for I/O operations                                            |
| `CURLOPT_IPRESOLVE`                  | IP protocol version to use                                             |
| `CURLOPT_ISSUERCERT_BLOB`            | issuer SSL certificate from memory blob                                |
| `CURLOPT_ISSUERCERT`                 | issuer SSL certificate filename                                        |
| `CURLOPT_KEEP_SENDING_ON_ERROR`      | keep sending on early HTTP response >= 300                             |
| `CURLOPT_KEYPASSWD`                  | passphrase to private key                                              |
| `CURLOPT_KRBLEVEL`                   | FTP kerberos security level                                            |
| `CURLOPT_LOCALPORT`                  | local port number to use for socket                                    |
| `CURLOPT_LOCALPORTRANGE`             | number of additional local ports to try                                |
| `CURLOPT_LOGIN_OPTIONS`              | login options                                                          |
| `CURLOPT_LOW_SPEED_LIMIT`            | low speed limit in bytes per second                                    |
| `CURLOPT_LOW_SPEED_TIME`             | low speed limit time period                                            |
| `CURLOPT_MAIL_AUTH`                  | SMTP authentication address                                            |
| `CURLOPT_MAIL_FROM`                  | SMTP sender address                                                    |
| `CURLOPT_MAIL_RCPT_ALLOWFAILS`       | allow RCPT TO command to fail for some recipients                      |
| `CURLOPT_MAIL_RCPT`                  | list of SMTP mail recipients                                           |
| `CURLOPT_MAX_RECV_SPEED_LARGE`       | rate limit data download speed                                         |
| `CURLOPT_MAX_SEND_SPEED_LARGE`       | rate limit data upload speed                                           |
| `CURLOPT_MAXAGE_CONN`                | max idle time allowed for reusing a connection                         |
| `CURLOPT_MAXCONNECTS`                | maximum connection cache size                                          |
| `CURLOPT_MAXFILESIZE_LARGE`          | maximum file size allowed to download                                  |
| `CURLOPT_MAXFILESIZE`                | maximum file size allowed to download                                  |
| `CURLOPT_MAXLIFETIME_CONN`           | max lifetime (since creation) allowed for reusing a connection         |
| `CURLOPT_MAXREDIRS`                  | maximum number of redirects allowed                                    |
| `CURLOPT_MIME_OPTIONS`               | set MIME option flags                                                  |
| `CURLOPT_MIMEPOST`                   | send data from mime structure                                          |
| `CURLOPT_NETRC_FILE`                 | filename to read .netrc info from                                      |
| `CURLOPT_NETRC`                      | enable use of .netrc                                                   |
| `CURLOPT_NEW_DIRECTORY_PERMS`        | permissions for remotely created directories                           |
| `CURLOPT_NEW_FILE_PERMS`             | permissions for remotely created files                                 |
| `CURLOPT_NOBODY`                     | do the download request without getting the body                       |
| `CURLOPT_NOPROGRESS`                 | switch off the progress meter                                          |
| `CURLOPT_NOPROXY`                    | disable proxy use for specific hosts                                   |
| `CURLOPT_NOSIGNAL`                   | skip all signal handling                                               |
| `CURLOPT_OPENSOCKETDATA`             | pointer passed to open socket callback                                 |
| `CURLOPT_OPENSOCKETFUNCTION`         | callback for opening socket                                            |
| `CURLOPT_PASSWORD`                   | password to use in authentication                                      |
| `CURLOPT_PATH_AS_IS`                 | do not handle dot dot sequences                                        |
| `CURLOPT_PINNEDPUBLICKEY`            | pinned public key                                                      |
| `CURLOPT_PIPEWAIT`                   | wait for pipelining/multiplexing                                       |
| `CURLOPT_PORT`                       | remote port number to connect to                                       |
| `CURLOPT_POST`                       | make an HTTP POST                                                      |
| `CURLOPT_POSTFIELDS`                 | data to POST to server                                                 |
| `CURLOPT_POSTFIELDSIZE_LARGE`        | size of POST data pointed to                                           |
| `CURLOPT_POSTFIELDSIZE`              | size of POST data pointed to                                           |
| `CURLOPT_POSTQUOTE`                  | (S)FTP commands to run after the transfer                              |
| `CURLOPT_POSTREDIR`                  | how to act on an HTTP POST redirect                                    |
| `CURLOPT_PRE_PROXY`                  | pre-proxy host to use                                                  |
| `CURLOPT_PREQUOTE`                   | commands to run before an FTP transfer                                 |
| `CURLOPT_PREREQDATA`                 | pointer passed to the pre-request callback                             |
| `CURLOPT_PREREQFUNCTION`             | user callback called when a connection has been                        |
| `CURLOPT_PRIVATE`                    | store a private pointer                                                |
| `CURLOPT_PROGRESSDATA`               | pointer passed to the progress callback                                |
| `CURLOPT_PROGRESSFUNCTION`           | progress meter callback                                                |
| `CURLOPT_PROTOCOLS_STR`              | allowed protocols                                                      |
| `CURLOPT_PROTOCOLS`                  | allowed protocols                                                      |
| `CURLOPT_PROXY_CAINFO_BLOB`          | proxy Certificate Authority (CA) bundle in PEM format                  |
| `CURLOPT_PROXY_CAINFO`               | path to proxy Certificate Authority (CA) bundle                        |
| `CURLOPT_PROXY_CAPATH`               | directory holding HTTPS proxy CA certificates                          |
| `CURLOPT_PROXY_CRLFILE`              | HTTPS proxy Certificate Revocation List file                           |
| `CURLOPT_PROXY_ISSUERCERT_BLOB`      | proxy issuer SSL certificate from memory blob                          |
| `CURLOPT_PROXY_ISSUERCERT`           | proxy issuer SSL certificate filename                                  |
| `CURLOPT_PROXY_KEYPASSWD`            | passphrase for the proxy private key                                   |
| `CURLOPT_PROXY_PINNEDPUBLICKEY`      | pinned public key for https proxy                                      |
| `CURLOPT_PROXY_SERVICE_NAME`         | proxy authentication service name                                      |
| `CURLOPT_PROXY_SSL_CIPHER_LIST`      | ciphers to use for HTTPS proxy                                         |
| `CURLOPT_PROXY_SSL_OPTIONS`          | HTTPS proxy SSL behavior options                                       |
| `CURLOPT_PROXY_SSL_VERIFYHOST`       | verify the proxy certificate's name against host                       |
| `CURLOPT_PROXY_SSL_VERIFYPEER`       | verify the proxy's SSL certificate                                     |
| `CURLOPT_PROXY_SSLCERT_BLOB`         | SSL proxy client certificate from memory blob                          |
| `CURLOPT_PROXY_SSLCERT`              | HTTPS proxy client certificate                                         |
| `CURLOPT_PROXY_SSLCERTTYPE`          | type of the proxy client SSL certificate                               |
| `CURLOPT_PROXY_SSLKEY_BLOB`          | private key for proxy cert from memory blob                            |
| `CURLOPT_PROXY_SSLKEY`               | private keyfile for HTTPS proxy client cert                            |
| `CURLOPT_PROXY_SSLKEYTYPE`           | type of the proxy private key file                                     |
| `CURLOPT_PROXY_SSLVERSION`           | preferred HTTPS proxy TLS version                                      |
| `CURLOPT_PROXY_TLS13_CIPHERS`        | ciphers suites for proxy TLS 1.3                                       |
| `CURLOPT_PROXY_TLSAUTH_PASSWORD`     | password to use for proxy TLS authentication                           |
| `CURLOPT_PROXY_TLSAUTH_TYPE`         | HTTPS proxy TLS authentication methods                                 |
| `CURLOPT_PROXY_TLSAUTH_USERNAME`     | username to use for proxy TLS authentication                           |
| `CURLOPT_PROXY_TRANSFER_MODE`        | append FTP transfer mode to URL for proxy                              |
| `CURLOPT_PROXY`                      | proxy to use                                                           |
| `CURLOPT_PROXYAUTH`                  | HTTP proxy authentication methods                                      |
| `CURLOPT_PROXYHEADER`                | set of HTTP headers to pass to proxy                                   |
| `CURLOPT_PROXYPASSWORD`              | password to use with proxy authentication                              |
| `CURLOPT_PROXYPORT`                  | port number the proxy listens on                                       |
| `CURLOPT_PROXYTYPE`                  | proxy protocol type                                                    |
| `CURLOPT_PROXYUSERNAME`              | username to use for proxy authentication                               |
| `CURLOPT_PROXYUSERPWD`               | username and password to use for proxy authentication                  |
| `CURLOPT_PUT`                        | make an HTTP PUT request                                               |
| `CURLOPT_QUICK_EXIT`                 | allow to exit quickly                                                  |
| `CURLOPT_QUOTE`                      | (S)FTP commands to run before transfer                                 |
| `CURLOPT_RANDOM_FILE`                | file to read random data from                                          |
| `CURLOPT_RANGE`                      | byte range to request                                                  |
| `CURLOPT_READDATA`                   | pointer passed to the read callback                                    |
| `CURLOPT_READFUNCTION`               | read callback for data uploads                                         |
| `CURLOPT_REDIR_PROTOCOLS_STR`        | protocols allowed to redirect to                                       |
| `CURLOPT_REDIR_PROTOCOLS`            | protocols allowed to redirect to                                       |
| `CURLOPT_REFERER`                    | the HTTP referer header                                                |
| `CURLOPT_REQUEST_TARGET`             | alternative target for this request                                    |
| `CURLOPT_RESOLVE`                    | provide custom hostname to IP address resolves                         |
| `CURLOPT_RESOLVER_START_DATA`        | pointer passed to the resolver start callback                          |
| `CURLOPT_RESOLVER_START_FUNCTION`    | callback called before a new name resolve is started                   |
| `CURLOPT_RESUME_FROM_LARGE`          | offset to resume transfer from                                         |
| `CURLOPT_RESUME_FROM`                | offset to resume transfer from                                         |
| `CURLOPT_RTSP_CLIENT_CSEQ`           | RTSP client CSEQ number                                                |
| `CURLOPT_RTSP_REQUEST`               | RTSP request                                                           |
| `CURLOPT_RTSP_SERVER_CSEQ`           | RTSP server CSEQ number                                                |
| `CURLOPT_RTSP_SESSION_ID`            | RTSP session ID                                                        |
| `CURLOPT_RTSP_STREAM_URI`            | RTSP stream URI                                                        |
| `CURLOPT_RTSP_TRANSPORT`             | RTSP Transport: header                                                 |
| `CURLOPT_SASL_AUTHZID`               | authorization identity (identity to act as)                            |
| `CURLOPT_SASL_IR`                    | send initial response in first packet                                  |
| `CURLOPT_SEEKDATA`                   | pointer passed to the seek callback                                    |
| `CURLOPT_SEEKFUNCTION`               | user callback for seeking in input stream                              |
| `CURLOPT_SERVER_RESPONSE_TIMEOUT`    | time in seconds allowed to wait for server response                    |
| `CURLOPT_SERVER_RESPONSE_TIMEOUT_MS` | time in milliseconds allowed to wait for server response               |
| `CURLOPT_SERVICE_NAME`               | authentication service name                                            |
| `CURLOPT_SHARE`                      | share handle to use                                                    |
| `CURLOPT_SOCKOPTDATA`                | pointer to pass to sockopt callback                                    |
| `CURLOPT_SOCKOPTFUNCTION`            | callback for setting socket options                                    |
| `CURLOPT_SOCKS5_AUTH`                | methods for SOCKS5 proxy authentication                                |
| `CURLOPT_SOCKS5_GSSAPI_NEC`          | socks proxy gssapi negotiation protection                              |
| `CURLOPT_SOCKS5_GSSAPI_SERVICE`      | SOCKS5 proxy authentication service name                               |
| `CURLOPT_SSH_AUTH_TYPES`             | auth types for SFTP and SCP                                            |
| `CURLOPT_SSH_COMPRESSION`            | enable SSH compression                                                 |
| `CURLOPT_SSH_HOST_PUBLIC_KEY_MD5`    | MD5 checksum of SSH server public key                                  |
| `CURLOPT_SSH_HOST_PUBLIC_KEY_SHA256` | SHA256 hash of SSH server public key                                   |
| `CURLOPT_SSH_HOSTKEYDATA`            | pointer to pass to the SSH host key callback                           |
| `CURLOPT_SSH_HOSTKEYFUNCTION`        | callback to check host key                                             |
| `CURLOPT_SSH_KEYDATA`                | pointer passed to the SSH key callback                                 |
| `CURLOPT_SSH_KEYFUNCTION`            | callback for known host matching logic                                 |
| `CURLOPT_SSH_KNOWNHOSTS`             | filename holding the SSH known hosts                                   |
| `CURLOPT_SSH_PRIVATE_KEYFILE`        | private key file for SSH auth                                          |
| `CURLOPT_SSH_PUBLIC_KEYFILE`         | public key file for SSH auth                                           |
| `CURLOPT_SSL_CIPHER_LIST`            | ciphers to use for TLS                                                 |
| `CURLOPT_SSL_CTX_DATA`               | pointer passed to ssl_ctx callback                                     |
| `CURLOPT_SSL_CTX_FUNCTION`           | SSL context callback for OpenSSL, wolfSSL or mbedTLS                   |
| `CURLOPT_SSL_EC_CURVES`              | key exchange curves                                                    |
| `CURLOPT_SSL_ENABLE_ALPN`            | Application Layer Protocol Negotiation                                 |
| `CURLOPT_SSL_ENABLE_NPN`             | use NPN                                                                |
| `CURLOPT_SSL_FALSESTART`             | TLS false start                                                        |
| `CURLOPT_SSL_OPTIONS`                | SSL behavior options                                                   |
| `CURLOPT_SSL_SESSIONID_CACHE`        | use the SSL session-ID cache                                           |
| `CURLOPT_SSL_VERIFYHOST`             | verify the certificate's name against host                             |
| `CURLOPT_SSL_VERIFYPEER`             | verify the peer's SSL certificate                                      |
| `CURLOPT_SSL_VERIFYSTATUS`           | verify the certificate's status                                        |
| `CURLOPT_SSLCERT_BLOB`               | SSL client certificate from memory blob                                |
| `CURLOPT_SSLCERT`                    | SSL client certificate                                                 |
| `CURLOPT_SSLCERTTYPE`                | type of client SSL certificate                                         |
| `CURLOPT_SSLENGINE_DEFAULT`          | make SSL engine default                                                |
| `CURLOPT_SSLENGINE`                  | SSL engine identifier                                                  |
| `CURLOPT_SSLKEY_BLOB`                | private key for client cert from memory blob                           |
| `CURLOPT_SSLKEY`                     | private keyfile for TLS and SSL client cert                            |
| `CURLOPT_SSLKEYTYPE`                 | type of the private key file                                           |
| `CURLOPT_SSLVERSION`                 | preferred TLS/SSL version                                              |
| `CURLOPT_STDERR`                     | redirect stderr to another stream                                      |
| `CURLOPT_STREAM_DEPENDS_E`           | stream this transfer depends on exclusively                            |
| `CURLOPT_STREAM_DEPENDS`             | stream this transfer depends on                                        |
| `CURLOPT_STREAM_WEIGHT`              | numerical stream weight                                                |
| `CURLOPT_SUPPRESS_CONNECT_HEADERS`   | suppress proxy CONNECT response headers from user callbacks            |
| `CURLOPT_TCP_FASTOPEN`               | TCP Fast Open                                                          |
| `CURLOPT_TCP_KEEPALIVE`              | TCP keep-alive probing                                                 |
| `CURLOPT_TCP_KEEPIDLE`               | TCP keep-alive idle time wait                                          |
| `CURLOPT_TCP_KEEPINTVL`              | TCP keep-alive interval                                                |
| `CURLOPT_TCP_NODELAY`                | the TCP_NODELAY option                                                 |
| `CURLOPT_TELNETOPTIONS`              | set of telnet options                                                  |
| `CURLOPT_TFTP_BLKSIZE`               | TFTP block size                                                        |
| `CURLOPT_TFTP_NO_OPTIONS`            | send no TFTP options requests                                          |
| `CURLOPT_TIMECONDITION`              | select condition for a time request                                    |
| `CURLOPT_TIMEOUT_MS`                 | maximum time the transfer is allowed to complete                       |
| `CURLOPT_TIMEOUT`                    | maximum time the transfer is allowed to complete                       |
| `CURLOPT_TIMEVALUE_LARGE`            | time value for conditional                                             |
| `CURLOPT_TIMEVALUE`                  | time value for conditional                                             |
| `CURLOPT_TLS13_CIPHERS`              | ciphers suites to use for TLS 1.3                                      |
| `CURLOPT_TLSAUTH_PASSWORD`           | password to use for TLS authentication                                 |
| `CURLOPT_TLSAUTH_TYPE`               | TLS authentication methods                                             |
| `CURLOPT_TLSAUTH_USERNAME`           | username to use for TLS authentication                                |
| `CURLOPT_TRAILERDATA`                | pointer passed to trailing headers callback                            |
| `CURLOPT_TRAILERFUNCTION`            | callback for sending trailing headers                                  |
| `CURLOPT_TRANSFER_ENCODING`          | ask for HTTP Transfer Encoding                                         |
| `CURLOPT_TRANSFERTEXT`               | request a text based transfer for FTP                                  |
| `CURLOPT_UNIX_SOCKET_PATH`           | Unix domain socket                                                     |
| `CURLOPT_UNRESTRICTED_AUTH`          | send credentials to other hosts too                                    |
| `CURLOPT_UPKEEP_INTERVAL_MS`         | connection upkeep interval                                             |
| `CURLOPT_UPLOAD_BUFFERSIZE`          | upload buffer size                                                     |
| `CURLOPT_UPLOAD`                     | data upload                                                            |
| `CURLOPT_URL`                        | URL for this transfer                                                  |
| `CURLOPT_USE_SSL`                    | request using SSL / TLS for the transfer                               |
| `CURLOPT_USERAGENT`                  | HTTP user-agent header                                                 |
| `CURLOPT_USERNAME`                   | username to use in authentication                                     |
| `CURLOPT_USERPWD`                    | username and password to use in authentication                        |
| `CURLOPT_VERBOSE`                    | verbose mode                                                           |
| `CURLOPT_WILDCARDMATCH`              | directory wildcard transfers                                           |
| `CURLOPT_WRITEDATA`                  | pointer passed to the write callback                                   |
| `CURLOPT_WRITEFUNCTION`              | callback for writing received data                                     |
| `CURLOPT_WS_OPTIONS`                 | WebSocket behavior options                                             |
| `CURLOPT_XFERINFODATA`               | pointer passed to the progress callback                                |
| `CURLOPT_XFERINFOFUNCTION`           | progress meter callback                                                |
| `CURLOPT_XOAUTH2_BEARER`             | OAuth 2.0 access token                                                 |
