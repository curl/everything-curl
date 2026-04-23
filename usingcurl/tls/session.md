# TLS sessions and early data

TLS sessions are a performance-boosting shortcut that allows a client and
server to bypass the computationally expensive "full handshake" by remembering
their previous connection. During an initial exchange, the server issues a
Session Ticket (in TLS 1.3) or a Session ID (in older TLS versions) that
functions as a cryptographic proof of their shared state. When the client
returns, it presents this token to "resume" the session, allowing both parties
to immediately derive encryption keys from their previous secrets without
re-verifying certificates or performing a full key exchange. This process
drastically cuts down on latency and CPU usage for repeat visitors, though it
technically creates a "fingerprint" that allows the server to identify the
returning device at the transport layer.

## TLS session cache

In curl 8.20.0 and earlier, the `--ssl-sessions` option is still considered
experimental and therefore not enabled by default. Without this feature
enabled, curl only supports an in-memory TLS session cache.

Using a TLS session cache on disk increases the chances of successful early
data use.

The `--ssl-sessions` option provides a way to persist TLS session data between
separate curl command invocations. This flag functions similarly to curl’s
cookie handling (--cookie-jar), allowing you to save session tickets to a file
and reload them later.

To use it, you provide a filename where curl should read and write the session
data. If the file exists, curl will attempt to "resume" a previous session
with the server using the tickets stored in that file. If the file does not
exist, curl performs a full handshake and then saves the resulting session
ticket to the file for future use.

Example:

    ### First run: Performs a full handshake and saves the session
    curl --ssl-sessions tls-cache.txt https://example.com

    # Second run: Uses the saved session for a faster handshake
    curl --ssl-sessions tls-cache.txt https://example.com

The main benefit of `--ssl-sessions` is a reduction in Time To First Byte
(TTFB). In a resumed session, the server does not need to re-send its entire
certificate chain, which can often be several kilobytes of data. Furthermore,
session resumption often requires fewer round-trips than a full handshake.
When combined with `--tls-earlydata` (0-RTT), curl can even send the HTTP
request in the first packet of the connection.

## Early data

The `--tls-earlydata` option is the switch that enables **TLS 1.3 0-RTT (Zero
Round Trip Time)**. In a standard TLS handshake, even with version 1.3, there
is a back-and-forth exchange before the client can send its actual request
(like an HTTP GET). 0-RTT allows a client that has connected to a server
previously to "resume" that session and send data—the "early data"—immediately
along with its first handshake message. This effectively eliminates the
latency penalty of the handshake for repeat visitors.

## How to use early data

Using the feature is straightforward in terms of syntax, but it relies on a
successful previous connection to the same server to function. You append the
flag to your command:

    curl --tls-earlydata https://example.com

Combined with a session cache:

    curl --tls-earlydata --ssl-sessions tls-cache.txt https://example.com

When this flag is active, curl will attempt to use a saved TLS session ticket
(if one exists in its cache) to send the request headers immediately. If the
server accepts the early data, the response returns much faster. If the server
rejects it (which is a standard security fallback), curl will automatically
retry the request using a normal handshake, so there is no risk of the
connection failing entirely because you used the flag.

## Security and idempotency

Because 0-RTT data is sent before the full handshake is finalized, it is
technically vulnerable to **replay attacks**. An attacker could capture the
early data packet and resend it to the server. For this reason, curl (and
most responsible clients) should only use early data for **idempotent**
requests—those that do not change state on the server, like `GET` or `HEAD`.
You should avoid using `--tls-earlydata` with `POST` or `DELETE` requests unless
you are absolutely certain the server has specific protections (like unique
tokens or strict replay windows) in place.

## Session tracking

While TLS 1.3 session reuse and early data provide significant performance
benefits, it introduces a notable privacy trade-off: it allows a server to
track a client across different connections. This tracking occurs because
0-RTT with curl relies on **Session Tickets** that the server issues to the
client during its initial handshake. When curl returns and attempts to
continue a previous session, it presents this specific ticket to the server to
prove it has a previous relationship. Because this ticket is unique to that
specific session, the server can instantly correlate the new connection with
the previous one, effectively functioning as a transport-layer tracking
cookie.

This tracking mechanism is particularly powerful because it happens before any
application-layer data—such as HTTP cookies or login credentials—is even
processed. Even if the curl command line otherwise does not use cookies or
similar, if the underlying TLS implementation maintains a session cache and
sends an early data ticket, the server can identify the returning client. To
mitigate this, privacy-focused clients often "partition" these session tickets
so they cannot be used to track users across different websites, or they may
disable 0-RTT entirely when high levels of anonymity are required.

## Requirements

To see the benefits of `--tls-earlydata`, several stars must align:

* **TLS 1.3**: The server and client must both support and negotiate TLS 1.3.

* **Session Resumption**: You typically need to be using a session cache or
  have a previous connection in the same curl process so curl has a
  session ticket to "resume."

* **Library Support**: Your curl build must be linked against a TLS library
  that supports 0-RTT, such as **OpenSSL**, **BoringSSL**, or **wolfSSL**. You
  can verify your version’s capabilities by checking `curl -V` for the
  `EarlyData` feature.
