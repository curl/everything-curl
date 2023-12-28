# Versions

Like all Internet protocols, the HTTP protocol has kept evolving over the
years and now there are clients and servers distributed over the world and
over time that speak different versions with varying levels of success. In
order to get libcurl to work with the URLs you pass in, libcurl offers ways
for you to specify which HTTP version to use. libcurl is designed in a way so
that it tries to use the most common, the most sensible if you want, default
values first but sometimes that is not enough and then you may need to
instruct libcurl what to do.

libcurl defaults to using HTTP/2 for HTTPS servers if you use a libcurl build
with HTTP/2 abilities built-in. libcurl then attempts to use HTTP/2
automatically or falls back to 1.1 in case the negotiation failed. Non-HTTP/2
capable libcurls use HTTP/1.1 over HTTPS by default. Plain HTTP requests
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
| CURL_HTTP_VERSION_3 | Try HTTP/3, allow fallback to older version.
| CURL_HTTP_VERSION_3ONLY | Use HTTP/3 or fail if not possible

## Version 2 not mandatory

When asking libcurl to use HTTP/2, it is an ask not a requirement. libcurl
then allows the server to select to use HTTP/1.1 or HTTP/2 and that is what
decides which protocol that is ultimately used.

## Version 3 can be mandatory

When asking libcurl to use HTTP/3 with the `CURL_HTTP_VERSION_3` option, it
makes libcurl do a second connection attempt in parallel but slightly delayed,
so that if the HTTP/3 connection fails, it can still try and use an older HTTP
version.

Using `CURL_HTTP_VERSION_3ONLY` means that the fallback mechanism is not used
and a failed QUIC connection fails the transfer completely.
