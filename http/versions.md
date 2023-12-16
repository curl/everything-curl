# HTTP versions

As any other Internet protocol, the HTTP protocol has kept evolving over the
years and now there are clients and servers distributed over the world and
over time that speak different versions with varying levels of success. So in
order to get libcurl to work with the URLs you pass in libcurl offers ways for
you to specify which HTTP version that request and transfer should
use. libcurl is designed in a way so that it tries to use the most common, the
most sensible if you want, default values first but sometimes that is not
enough and then you may need to instruct libcurl on what to do.

curl defaults to HTTP/1.1 for HTTP servers but if you connect to HTTPS and you
have a curl that has HTTP/2 abilities built-in, it attempts to negotiate
HTTP/2 automatically or falls back to 1.1 in case the negotiation failed.
Non-HTTP/2 capable curls get 1.1 over HTTPS by default.

| Option                              | Description |
|-------------------------------------|-------------|
| --http1.0                           | HTTP/1.0
| --http1.1                           | HTTP/1.1
| --http2                             | HTTP/2
| --http2-prior-knowledge             | HTTP/2
| --http3                             | HTTP/3

* [HTTP/0.9](versions/http09.md)
* [HTTP/2](versions/http2.md)
* [HTTP/3](versions/http2.md)
