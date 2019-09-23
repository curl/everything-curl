# HTTP versions

As any other Internet protocol, the HTTP protocol has kept evolving over the
years and now there are clients and servers distributed over the world and
over time that speak different versions with varying levels of success. So in
order to get libcurl to work with the URLs you pass in libcurl offers ways for
you to specify which HTTP version that request and transfer should
use. libcurl is designed in a way so that it tries to use the most common, the
most sensible if you want, default values first but sometimes that is not
enough and then you may need to instruct libcurl what to do.

Since mid 2016, libcurl defaults to use HTTP/2 for HTTPS servers if you have a
libcurl that has HTTP/2 abilities built-in, libcurl will attempt to use HTTP/2
automatically or fall back to 1.1 in case the negotiation failed. Non-HTTP/2
capable libcurls get 1.1 over HTTPS by default. Plain HTTP requests still
default to HTTP/1.1.

If the default behavior is not good enough for your transfer, the
`CURLOPT_HTTP_VERSION` option is there for you.

| Option                              | Description |
|-------------------------------------|-------------|
| CURL_HTTP_VERSION_NONE              | Reset back to default behavior
| CURL_HTTP_VERSION_1_0               | Enforce use of the legacy HTTP/1.0 protocol version
| CURL_HTTP_VERSION_1_1               | Do the request using the HTTP/1.1 protocol version
| CURL_HTTP_VERSION_2_0               | Attempt to use HTTP/2
| CURL_HTTP_VERSION_2TLS              | Attempt to use HTTP/2 on HTTPS connections only, otherwise do HTTP/1.1
| CURL_HTTP_VERSION_2_PRIOR_KNOWLEDGE | Use HTTP/2 straight away without "upgrading" from 1.1. It requires that you know that this server is OK with it.
| CURL_HTTP_VERSION_3 | Use HTTP/3 straight away. It requires that you know that this server is OK with it.
