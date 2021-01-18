# HTTP with libcurl

HTTP is by far the most commonly used protocol by libcurl users and libcurl
offers countless ways of modifying such transfers. See the [HTTP protocol
basics](http-basics.md) for some basics on how the HTTP protocol works.

## HTTPS

Doing HTTPS is typically done the same way as for HTTP as the extra security
layer and server verification etc is done automatically and transparently by
default. Just use the `https://` scheme in the URL.

HTTPS is HTTP with TLS on top. See also the [TLS
options](libcurl-tlsoptions.md) section.

## HTTP proxy

See [using Proxies with libcurl](libcurl-proxies.md)
