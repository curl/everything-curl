# HTTP/2

curl supports HTTP/2 for both HTTP:// and HTTPS:// URLs assuming that curl was
built with the proper prerequisites. It even defaults to using HTTP/2 when
given an HTTPS URL since doing so implies no penalty and when curl is used
with sites that do not support HTTP/2 the request instead negotiates HTTP/1.1.

With HTTP:// URLs however, the upgrade to HTTP/2 is done with an `Upgrade:`
header that may cause an extra round-trip and perhaps even more troublesome, a
sizable share of old servers returns a 400 response when seeing such a header.

It should also be noted that some (most?) servers that support HTTP/2 for
`HTTP://` (which in itself is not all servers) do not acknowledge the
`Upgrade:` header on POST, for example.

To ask a server to use HTTP/2, just:

    curl --http2 http://example.com/

If your curl does not support HTTP/2, that command line tool returns an error
saying so. Running `curl -V` shows if your version of curl supports it.

If you by some chance already know that your server speaks HTTP/2 (for
example, within your own controlled environment where you know exactly what
runs in your machines) you can shortcut the HTTP/2 negotiation with
`--http2-prior-knowledge`.

## Multiplexing

A primary feature in the HTTP/2 protocol, is the ability to multiplex several
logical streams over the same physical connection. The curl command-line tool
can take advantage of this feature when
[doing parallel transfers](../../cmdline/urls/parallel.md).
