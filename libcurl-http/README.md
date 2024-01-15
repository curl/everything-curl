# libcurl HTTP

HTTP is by far the most commonly used protocol by libcurl users and libcurl
offers countless ways of modifying such transfers. See the
[HTTP protocol basics](../protocols/http.md) for some basics on how the HTTP protocol
works.

## HTTPS

Doing HTTPS is typically done the same way as for HTTP as the extra security
layer and server verification etc is done automatically and transparently by
default. Just use the `https://` scheme in the URL.

HTTPS is HTTP with TLS on top. See also the
[TLS transfer options](../transfers/options/tls.md) section.

## HTTP proxy

See [using Proxies with libcurl](../transfers/conn/proxies.md)

## Sections

  * [HTTP responses](responses.md)
  * [HTTP requests](requests.md)
  * [HTTP versions](versions.md)
  * [HTTP ranges](ranges.md)
  * [HTTP authentication](auth.md)
  * [Cookies with libcurl](cookies.md)
  * [Download](download.md)
  * [Upload](upload.md)
  * [Multiplexing](multiplexing.md)
  * [HSTS](hsts.md)
  * [alt-svc](alt-svc.md)
