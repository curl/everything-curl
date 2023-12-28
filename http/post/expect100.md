# Expect 100-continue

HTTP/1 has no proper way to stop an ongoing transfer (in any direction) and
still maintain the connection. So, if we figure out that the transfer had
better stop after the transfer has started, there are only two ways to
proceed: cut the connection and pay the price of reestablishing the connection
again for the next request, or keep the transfer going and waste bandwidth but
be able to reuse the connection next time.

One example of when this can happen is when you send a large file over HTTP,
only to discover that the server requires authentication and immediately sends
back a 401 response code.

The mitigation that exists to make this scenario less frequent is to have curl
pass on an extra header, `Expect: 100-continue`, which gives the server a
chance to deny the request before a lot of data is sent off. curl sends this
`Expect:` header by default if the POST it does is known or suspected to be
larger than one megabyte. curl also does this for PUT requests.

When a server gets a request with an 100-continue and deems the request fine,
it responds with a 100 response that makes the client continue. If the server
does not like the request, it sends back response code for the error it thinks
it is.

Unfortunately, lots of servers in the world do not properly support the
Expect: header or do not handle it correctly, so curl only waits 1000
milliseconds for that first response before it continues anyway.

You can change the amount of time curl waits for a response to Expect by using
`--expect100-timeout <seconds>`. You can avoid the wait entirely by using
`-H Expect:` to remove the header:

    curl -H Expect: -d "payload to send" http://example.com

In some situations, curl inhibits the use of the `Expect` header if the
content it is about to send is small (below one megabyte), as having to waste
such a small chunk of data is not considered much of a problem.

## HTTP/2 and later

HTTP/2 and later versions of HTTP can stop an ongoing transfer without
shutting down the connection, which makes `Expect:` pointless.
