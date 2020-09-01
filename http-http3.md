# HTTP/3

(This feature is marked **experimental** as of this time and needs to be
explicitly enabled in the build.)

## Drafts, not standard

As of September 2020, **the HTTP/3 protocol has not yet been finalized**.
Everything and everyone that speaks HTTP/3 at this point does it with the
knowledge and awareness that it might change going forward.

## QUIC

HTTP/3 is the HTTP version that is designed to communicate over QUIC. QUIC can
in all practicular purposes to be considered as a TCP+TLS replacement.

All requests that do HTTP/3 will therefore not use TCP. They will use QUIC.
QUIC is a reliable transport protocol built over UDP. HTTP/3 implies use of
QUIC.

## HTTPS only

HTTP/3 is performed over QUIC which is always using TLS, so HTTP/3 is by
defintion always encrypted and secure. Therefore, curl only uses HTTP/3 for
`HTTPS://` URLs.

## Enable

As a shortcut straight to HTTP/3, to make curl attempt a QUIC connect directly
to the given host name and port number, use `--http3`. Like this:

    curl --http3 https://example.com/

Normally, a `HTTPS://` URL implies that a client needs to connect to it using
TC + TLS.

## Alt-svc:

The [alt-svc](http-altsvc.md) method of changing to HTTP/3 is the official way
to bootstrap into HTTP/3 for a server.

Note that you need that feature built-in and that it doesn't switch to HTTP/3
for the *current* request unless the alt-svc cache is already populated, but
it will rather store the info for use in the *next* request to the host.

## When QUIC is denied

A certain amount of QUIC connection attempts will fail, partly because many
networks and hosts block or throttle the traffic.

Currently, curl features no fall-back logic but if a HTTP/3 (or QUIC rather)
connection fails it will be reported as, yes, a failure.

Web browsers will upgrade to HTTP/3 in the background and only switch over
once they know it works, which is a smoother way that doesn't break things for
users as much.

Future curl versions will likely offer better fall-back and error handling for
this.
