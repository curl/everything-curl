# Connection reuse

libcurl keeps a pool of old connections alive. When one transfer has completed
it will keep N connections alive in a "connection pool" (sometimes also called
connection cache) so that a subsequent transfer that happens to be able to
reuse one of the existing connections can use it instead of creating a new
one. Reusing a connection instead of creating a new one offers significant
benefits in speed and required resources.

When libcurl is about to make a new connection for the purposes of doing a
transfer, it will first check to see if there's an existing connection in the
pool that it can reuse instead. The connection re-use check is done before any
DNS or other name resolving mechanism is used, so it is purely host name
based. If there's an existing live connection to the right host name, a lot of
other properties (port number, protocol, etc) are also checked to see that it
can be used.

## Easy API pool

When you are using the easy API, or, more specifically, `curl_easy_perform()`,
libcurl will keep the pool associated with the specific easy handle. Then
reusing the same easy handle will ensure it can reuse its connection.

## Multi API pool

When you are using the multi API, the connection pool is instead kept
associated with the multi handle. This allows you to cleanup and re-create
easy handles freely without risking losing the connection pool, and it allows
the connection used by one easy handle to get reused by a separate one in a
later transfer. Just reuse the multi handle!

## Sharing the "connection cache"

Since libcurl 7.57.0, applications can use the [share
interface](libcurl-sharing.md) to have otherwise independent transfers share
the same connection pool.
