# Caches and state

When libcurl is used for Internet transfers, it stores data in caches and
state storage in order to do subsequent transfers faster and better.

The caches are kept associated with the `CURL` or `CURLM` handles, depending
on which libcurl API is used, easy or multi.

## DNS cache

When libcurl resolves the IP addresses of a hostname it stores the result in
its DNS cache (with a default life-time of 60 seconds), so that subsequent
lookups can use the cached data immediately instead of doing the (potentially
slow) resolve operation again. This cache exists in memory only.

## connection cache

Also known as the connection pool. This is where curl puts live connections
after a transfer is complete so that a subsequent transfer might be able to
use an already existing connection instead of having to set a new one up. When
a connection is reused, curl avoids name lookups, TLS handshakes and more.
This cache exists in memory only.

## TLS session-ID cache

When curl uses TLS, it saves the *session-ID* in a cache. When a subsequent
transfer needs to redo the TLS handshake with a host for which it has a cached
session-ID, the handshake can complete faster. This cache exists in memory
only.

## CA store cache

When curl creates a new connection and performs a TLS handshake, it needs to
load and parse a *CA store* to use for verifying the certificate presented by
the remote server. The CA store cache keeps the parsed CA store in memory for
a period of time (default is 24 hours) so that subsequent handshakes are done
much faster by avoiding having to re-parse this potentially large data
amount. This cache exists in memory only. Added in 7.87.0.

## HSTS

HSTS is HTTP Strict Transport Security. HTTPS servers can inform clients that
they want the client to connect to its hostname using only HTTPS going forward
and not HTTP, even when `HTTP://` URLs are used. curl keeps this connection
upgrade information in memory and can be told to load it from and save it to
disk as well.

## Alt-Svc

`Alt-Svc:` is an HTTP response header that informs the client about
alternative hostnames, port numbers and protocol versions where the same
service is also available. curl keeps this alternative service information in
memory and can be told to load it from and save it to disk as well.

## Cookies

Cookies are name value pairs sent from an HTTP server to the client, meant to
be sent back in subsequent requests that match the conditions. curl keeps all
cookies in memory and can be told to load them from and save them to disk as
well.
