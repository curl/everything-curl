## HTTP versions

As any other Internet protocol, the HTTP protocol has kept evolving over the
years and now there are clients and servers distributed over the world and
over time that speak different versions with varying levels of success. So in
order to get libcurl to work with the URLs you pass in libcurl offers ways for
you to specify which HTTP version that request and transfer should
use. libcurl is designed in a way so that it tries to use the most common, the
most sensible if you want, default values first but sometimes that is not
enough and then you may need to instruct libcurl on what to do.

Since perhaps mid 2016, curl will default to use HTTP/1.1 for HTTP servers. If
you connect to HTTPS and you have a libcurl that has HTTP/2 abilities
built-in, curl will attempt to use HTTP/2 automatically or fall back to 1.1 in
case the negotiation failed. Non-HTTP/2 capable curls get 1.1 over HTTPS by
default.

If the default is not good enough for your transfer, the
`CURLOPT_HTTP_VERSION` option is there for you.

| Option                              | Description |
|-------------------------------------|-------------|
| [default]                           |
| --http1.0                           | HTTP/1.0
| --http1.1                           | HTTP/1.1
| --http2                             | [HTTP/2](http-http2.md)
| --http2-prior-knowledge             | HTTP/2
| --http3                             | [HTTP/3](http-http3.md)
