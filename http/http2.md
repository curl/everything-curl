## HTTP/2

curl supports HTTP/2 for both HTTP:// and HTTPS:// URLs assuming that curl was
built with the proper prerequisites. It will even default to using HTTP/2 when
given a HTTPS URL since doing so implies no penalty and when curl is used with
sites that do not support HTTP/2 the request will instead negotiate HTTP/1.1.

With HTTP:// URLs however, the upgrade to HTTP/2 is done with an `Upgrade:`
header that may cause an extra round-trip and perhaps even more troublesome, a
sizable share of old servers will return a 400 response when seeing such a
header.

It should also be noted that some (most?) servers that support HTTP/2 for
HTTP:// (which in itself is not all servers) will not acknowledge the
`Upgrade:` header on POST, for example.

To ask a server to use HTTP/2, just:

    curl --http2 http://example.com/

If your curl does not support HTTP/2, that command line will return an error
saying so. Running `curl -V` will show if your version of curl supports it.

If you by some chance already know that your server speaks HTTP/2 (for example,
within your own controlled environment where you know exactly what runs in
your machines) you can shortcut the HTTP/2 "negotiation" with
`--http2-prior-knowledge`.

### Multiplexing

One of the primary features in the HTTP/2 protocol is the ability to multiplex
several logical stream over the same physical connection. When using the curl
command-line tool, you cannot take advantage of that cool feature since curl
is doing all its network requests in a strictly serial manner, one after the
next, with the second only ever starting once the previous one has ended.

Preferably, a future curl version will be enhanced to allow the use of this
feature.
