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
| --http2                             | [HTTP/2](http2.md)
| --http2-prior-knowledge             | [HTTP/2](http2.md)
| --http3                             | [HTTP/3](http3.md)

## Accepting HTTP/0.9

The HTTP version used before HTTP/1.0 was made available is often referred to
as HTTP/0.9. Back in those days, HTTP responses had no headers as they would
only return a response body and then immediately close the connection.

curl can be told to support such responses but will by default not recognize
them, for security reasons. Almost anything bad will look like an HTTP/0.9
response to curl so the option needs to be used with caution.

The HTTP/0.9 option to curl is different than the other HTTP command line
options for HTTP versions mentioned above as this controls what response to
accept, while the others are about what HTTP protocol version to try to use.

Tell curl to accept an HTTP/0.9 response like this:

    curl --http0.9 https://example.com/
