## Connection reuse

libcurl keeps a pool of old connections alive. When one transfer has completed
it will keep N connections alive in a "connection pool" so that a subsequent
transfer that happens to be able to reuse one of the existing connections can
use that one instead of creating a new. Reusing a connection instead of
creating a new offers significant benefits in speed and requiredresources.

### Easy API pool

When you're using the easy API, or more specifically curl_easy_perform(),
libcurl will keep the pool associated with the specific easy handle. Then
reusing the same easy handle will make sure it can reuse connections.

### Multi API pool

When you're using the multi API, the connection pool is instead kept
associated with the multi handle. This allows you to cleanup and re-create
easy handles freely without risking to lose the connection pool, and it allows
the connection used by one easy handle to get reused by a separate one in a
later transfer. Just reuse the multi handle!
