# Caches

libcurl caches different information in order to help subsequent transfers to
perform faster. There are three key caches: DNS, connections and TLS sessions.

When the multi interface is used, these caches are by default shared among all
the easy handles that are added to that single multi handle, and when the easy
interface is used they are kept within that handle.

You can instruct libcurl to share some of the caches with the [share
interface](sharing.md).

## DNS cache

When libcurl resolves a host name to one or more IP addresses, that is stored
in the DNS cache so that subsequent transfers in the near term will not have
to redo the same resolve again. A name resolve easily take several hundred
milliseconds and sometimes even much longer.

By default, each such host name is stored in the cache for 60 seconds
(changeable with `CURLOPT_DNS_CACHE_TIMEOUT`).

libcurl does in fact not usually know what the TTL (Time To Live) value is for
DNS entries, as that is generally not exposed in the system function calls it
uses for this purpose, so increasing this value come with a risk that libcurl
keeps using stale addresses longer periods than necessary.

## Connection cache

Also sometimes refered to as the connection pool. This is a collection of
previously used connections that instead of being closed after use, are kept
around alive so that subsequent transfers that are targeting the same host
name and have several other checks also matching, can use them instead of
creating a new connection.

A reused connection usually saves having to a DNS lookup, setting up a TCP
connection, do a TLS handshake and more.

Connections are only reused if the name is identical. Even if two different
host names resolve to the same IP addresses, they will still always use two
separate connections with libcurl.

Since the connection reuse is based on the host name and the DNS resolve phase
is entirely skipped when a connection is reused for a transfer, libcurl will
not know the current state of the host name in DNS as it can in fact change IP
over time while the connection might survive and continue to get reused over
the original IP address.

The size of the connection cache - the number of live connections to keep
there - can be set with `CURLOPT_MAXCONNECTS` (default is 5) for easy handles
and `CURLMOPT_MAXCONNECTS` for multi handles. The default size for multi
handles is 4 times the number of easy handles added.

## TLS session cache

TLS session IDs and tickets are special TLS mechanisms that a client can pass
to a server to shortcut subsequent TLS handshakes to a server it previously
established a connection to.

libcurl caches session IDs and tickets associated with host names and port
numbers, so if a subsequent connection attempt is made to a host for which
libcurl has a cached ID or ticket, using that can greatly decrease the TLS
handshake process and therefore the time needed until completion.
