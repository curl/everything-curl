# HTTP/3

HTTP/3 is different than its predecessors in several ways. Maybe most
noticeably, HTTP/3 cannot be negotiated on the same connection like HTTP/2
can. Due to HTTP/3 using a different transport protocol, it has to set up and
negotiate a dedicated connection for it.

## QUIC

HTTP/3 is the HTTP version that is designed to communicate over QUIC. QUIC can
for most particular purposes be considered a TCP+TLS replacement.

All transfers that use HTTP/3 therefore do not use TCP. They use QUIC. QUIC is
a reliable transport protocol built over UDP. HTTP/3 implies use of QUIC.

## HTTPS only

HTTP/3 is performed over QUIC which is always using TLS, so HTTP/3 is by
definition always encrypted and secure. Therefore, curl only uses HTTP/3 for
`HTTPS://` URLs.

## Enable

As a shortcut straight to HTTP/3, to make curl attempt a QUIC connect directly
to the given hostname and port number, use `--http3`. Like this:

    curl --http3 https://example.com/

Normally, without the `--http3` option, an `HTTPS://` URL implies that a
client needs to connect to it using TCP (and TLS).

## Multiplexing

A primary feature in the HTTP/3 protocol, is the ability to multiplex several
logical streams over the same physical connection. The curl command-line tool
can take advantage of this feature when
[doing parallel transfers](../../cmdline/urls/parallel.md).

## Alt-svc:

The [alt-svc](../altsvc.md) method of changing to HTTP/3 is the official way to
bootstrap into HTTP/3 for a server.

Note that you need that feature built-in and that it does not switch to HTTP/3
for the *current* request unless the alt-svc cache is already populated, but
it rather stores the info for use in the *next* request to the host.

## When QUIC is denied

A certain amount of QUIC connection attempts fail, partly because many
networks and hosts block or throttle the traffic.

When `--http3` is used, curl starts a second transfer attempt a few hundred
milliseconds after the QUIC connection is initiated which is using HTTP/2 or
HTTP/1, so that if the connection attempt over QUIC fails or turns out to be
unbearably slow, the connection using an older HTTP version can still succeed
and perform the transfer. This allows users to use `--http3` with some amount
of confidence that the operation works.

`--http3-only` is provided to explicitly *not* try any older version in
parallel, but thus makes the transfer fail immediately if no QUIC connection
can be established.
