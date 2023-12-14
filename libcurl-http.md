# HTTP with libcurl

HTTP is by far the most commonly used protocol by libcurl users and libcurl
offers countless ways of modifying such transfers. See the
[HTTP protocol basics](http/basics.md) for some basics on how the HTTP protocol
works.

## HTTPS

Doing HTTPS is typically done the same way as for HTTP as the extra security
layer and server verification etc is done automatically and transparently by
default. Just use the `https://` scheme in the URL.

HTTPS is HTTP with TLS on top. See also the [TLS options](libcurl/options/tls.md)
section.

## HTTP proxy

See [using Proxies with libcurl](libcurl/proxies.md)

## Sections

  * [HTTP responses](libcurl-http/responses.md)
  * [HTTP requests](libcurl-http/requests.md)
  * [HTTP versions](libcurl-http/versions.md)
  * [HTTP ranges](libcurl-http/ranges.md)
  * [HTTP authentication](libcurl-http/auth.md)
  * [Cookies with libcurl](libcurl-http/cookies.md)
  * [Download](libcurl-http/download.md)
  * [Upload](libcurl-http/upload.md)
  * [Multiplexing](libcurl-http/multiplexing.md)
  * [HSTS](libcurl-http/hsts.md)
