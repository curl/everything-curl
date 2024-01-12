# Post transfer info

Remember how libcurl transfers are associated with *easy handles*. Each
transfer has such a handle and when a transfer is completed, before the handle
is cleaned or reused for another transfer, it can be used to extract
information from the previous operation.

Your friend for doing this is called `curl_easy_getinfo()` and you tell it
which specific information you are interested in and it returns that if it
can.

When you use this function, you pass in the easy handle, which information you
want and a pointer to a variable to hold the answer. You must pass in a
pointer to a variable of the correct type or you risk that things go
side-ways. These information values are designed to be provided *after* the
transfer is completed.

The data you receive can be a long, a 'char *', a 'struct curl_slist *', a
double or a socket.

This is how you extract the `Content-Type:` value from the previous HTTP
transfer:

    CURLcode res;
    char *content_type;
    res = curl_easy_getinfo(curl, CURLINFO_CONTENT_TYPE, &content_type);

If you want to extract the local port number that was used in that connection:

    CURLcode res;
    long port_number;
    res = curl_easy_getinfo(curl, CURLINFO_LOCAL_PORT, &port_number);

## Available information

| Getinfo option                       | Type                  | Description                                                                   |
|-------------------------------------------------|-------------------|---------------------------------------------|
| `CURLINFO_ACTIVESOCKET`              | `curl_socket_t`       | The session's active socket                                                   |
| `CURLINFO_APPCONNECT_TIME`           | `double`              | Time from start until SSL/SSH handshake completed                             |
| `CURLINFO_APPCONNECT_TIME_T`         | `curl_off_t`          | Time from start until SSL/SSH handshake completed (in microseconds)           |
| `CURLINFO_CAINFO`                    | `char *`              | Path to the default CA file libcurl is built to use                           |
| `CURLINFO_CAPATH`                    | `char *`              | Path to the CA directory libcurl is built to use                              |
| `CURLINFO_CERTINFO`                  | `struct curl_slist *` | Certificate chain                                                             |
| `CURLINFO_CONDITION_UNMET`           | `long`                | Whether or not a time conditional was met                                     |
| `CURLINFO_CONNECT_TIME`              | `double`              | Time from start until remote host or proxy completed                          |
| `CURLINFO_CONNECT_TIME_T`            | `curl_off_t`          | Time from start until remote host or proxy completed (in microseconds)        |
| `CURLINFO_CONN_ID`                   | `curl_off_t`          | Numerical id of the current connection (meant for callbacks)                  |
| `CURLINFO_CONTENT_LENGTH_DOWNLOAD`   | `double`              | Content length from the Content-Length header                                 |
| `CURLINFO_CONTENT_LENGTH_DOWNLOAD_T` | `curl_off_t`          | Content length from the Content-Length header                                 |
| `CURLINFO_CONTENT_LENGTH_UPLOAD`     | `double`              | Upload size                                                                   |
| `CURLINFO_CONTENT_LENGTH_UPLOAD_T`   | `curl_off_t`          | Upload size                                                                   |
| `CURLINFO_CONTENT_TYPE`              | `char *`              | Content type from the Content-Type header                                     |
| `CURLINFO_COOKIELIST`                | `struct curl_slist *` | List of all known cookies                                                     |
| `CURLINFO_EFFECTIVE_METHOD`          | `char *`              | Last used HTTP request method                                                 |
| `CURLINFO_EFFECTIVE_URL`             | `char *`              | Last used URL                                                                 |
| `CURLINFO_FILETIME`                  | `long`                | Remote time of the retrieved document                                         |
| `CURLINFO_FILETIME_T`                | `curl_off_t`          | Remote time of the retrieved document                                         |
| `CURLINFO_FTP_ENTRY_PATH`            | `char *`              | The entry path after logging in to an FTP server                              |
| `CURLINFO_HEADER_SIZE`               | `long`                | Number of bytes of all headers received                                       |
| `CURLINFO_HTTP_CONNECTCODE`          | `long`                | Last proxy CONNECT response code                                              |
| `CURLINFO_HTTP_VERSION`              | `long`                | The HTTP version used in the connection                                       |
| `CURLINFO_HTTPAUTH_AVAIL`            | `long`                | Available HTTP authentication methods (bitmask)                               |
| `CURLINFO_LASTSOCKET`                | `long`                | Last socket used                                                              |
| `CURLINFO_LOCAL_IP`                  | `char *`              | Local-end IP address of last connection                                       |
| `CURLINFO_LOCAL_PORT`                | `long`                | Local-end port of last connection                                             |
| `CURLINFO_NAMELOOKUP_TIME`           | `double`              | Time from start until name resolving completed                                |
| `CURLINFO_NAMELOOKUP_TIME_T`         | `curl_off_t`          | Time from start until name resolving completed (in microseconds)              |
| `CURLINFO_NUM_CONNECTS`              | `long`                | Number of new successful connections used for previous transfer               |
| `CURLINFO_OS_ERRNO`                  | `long`                | The errno from the last failure to connect                                    |
| `CURLINFO_PRETRANSFER_TIME`          | `double`              | Time from start until just before the transfer begins                         |
| `CURLINFO_PRETRANSFER_TIME_T`        | `curl_off_t`          | Time from start until just before the transfer begins (in microseconds)       |
| `CURLINFO_PRIMARY_IP`                | `char *`              | IP address of the last connection                                             |
| `CURLINFO_PRIMARY_PORT`              | `long`                | Port of the last connection                                                   |
| `CURLINFO_PRIVATE`                   | `char *`              | User's private data pointer                                                   |
| `CURLINFO_PROTOCOL`                  | `long`                | The protocol used for the connection                                          |
| `CURLINFO_PROXY_ERROR`               | `long`                | Detailed (SOCKS) proxy error if `CURLE_PROXY` was returned from the transfer  |
| `CURLINFO_PROXY_SSL_VERIFYRESULT`    | `long`                | Proxy certificate verification result                                         |
| `CURLINFO_PROXYAUTH_AVAIL`           | `long`                | Available HTTP proxy authentication methods                                   |
| `CURLINFO_QUEUE_TIME_T`              | `curl_off_t`          | Time in microseconds this transfer was held in queue waiting to start         |
| `CURLINFO_REDIRECT_COUNT`            | `long`                | Total number of redirects that were followed                                  |
| `CURLINFO_REDIRECT_TIME`             | `double`              | Time taken for all redirect steps before the final transfer                   |
| `CURLINFO_REDIRECT_TIME_T`           | `curl_off_t`          | Time taken for all redirect steps before the final transfer (in microseconds) |
| `CURLINFO_REDIRECT_URL`              | `char *`              | URL a redirect would take you to, had you enabled redirects                   |
| `CURLINFO_REFERER`                   | `char *`              | The used request `Referer:` header                                                |
| `CURLINFO_REQUEST_SIZE`              | `long`                | Number of bytes sent in the issued HTTP requests                              |
| `CURLINFO_RESPONSE_CODE`             | `long`                | Last received response code                                                   |
| `CURLINFO_RETRY_AFTER`               | `curl_off_t`          | The value from the response `Retry-After:` header                             |
| `CURLINFO_RTSP_CLIENT_CSEQ`          | `long`                | RTSP next expected client CSeq                                                |
| `CURLINFO_RTSP_CSEQ_RECV`            | `long`                | RTSP last received                                                            |
| `CURLINFO_RTSP_SERVER_CSEQ`          | `long`                | RTSP next expected server CSeq                                                |
| `CURLINFO_RTSP_SESSION_ID`           | `char *`              | RTSP session ID                                                               |
| `CURLINFO_SCHEME`                    | `char *`              | The scheme used for the connection                                            |
| `CURLINFO_SIZE_DOWNLOAD`             | `double`              | Number of bytes downloaded                                                    |
| `CURLINFO_SIZE_DOWNLOAD_T`           | `curl_off_t`          | Number of bytes downloaded                                                    |
| `CURLINFO_SIZE_UPLOAD`               | `double`              | Number of bytes uploaded                                                      |
| `CURLINFO_SIZE_UPLOAD_T`             | `curl_off_t`          | Number of bytes uploaded                                                      |
| `CURLINFO_SPEED_DOWNLOAD`            | `double`              | Average download speed                                                        |
| `CURLINFO_SPEED_DOWNLOAD_T`          | `curl_off_t`          | Average download speed                                                        |
| `CURLINFO_SPEED_UPLOAD`              | `double`              | Average upload speed                                                          |
| `CURLINFO_SPEED_UPLOAD_T`            | `curl_off_t`          | Average upload speed                                                          |
| `CURLINFO_SSL_ENGINES`               | `struct curl_slist *` | A list of OpenSSL crypto engines                                              |
| `CURLINFO_SSL_VERIFYRESULT`          | `long`                | Certificate verification result                                               |
| `CURLINFO_STARTTRANSFER_TIME`        | `double`              | Time from start until just when the first byte is received                    |
| `CURLINFO_STARTTRANSFER_TIME_T`      | `curl_off_t`          | Time from start until just when the first byte is received (in microseconds)  |
| `CURLINFO_TLS_SSL_PTR`               | `struct curl_slist *` | TLS session info that can be used for further processing                      |
| `CURLINFO_TOTAL_TIME`                | `double`              | Total time of previous transfer                                               |
| `CURLINFO_TOTAL_TIME_T`              | `curl_off_t`          | Total time of previous transfer (in microseconds)                             |
| `CURLINFO_XFER_ID`                   | `curl_off_t`          | Numerical id of the current transfer (meant for callbacks)                    |
