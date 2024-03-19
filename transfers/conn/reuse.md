# Connection reuse

libcurl keeps a pool of old connections alive. When one transfer has completed
it keeps N connections alive in a connection pool (sometimes also called
connection cache) so that a subsequent transfer that happens to be able to
reuse one of the existing connections can use it instead of creating a new
one. Reusing a connection instead of creating a new one offers significant
benefits in speed and required resources.

When libcurl is about to make a new connection for the purposes of doing a
transfer, it first checks to see if there is an existing connection in the
pool that it can reuse instead. The connection re-use check is done before any
DNS or other name resolving mechanism is used, so it is purely hostname
based. If there is an existing live connection to the right hostname, a lot of
other properties (port number, protocol, etc) are also checked to see that it
can be used.

## Easy API pool

When you are using the easy API, or, more specifically, `curl_easy_perform()`,
libcurl keeps the pool associated with the specific easy handle. Then reusing
the same easy handle ensures libcurl can reuse its connection.

## Multi API pool

When you are using the multi API, the connection pool is instead kept
associated with the multi handle. This allows you to cleanup and re-create
easy handles freely without risking losing the connection pool, and it allows
the connection used by one easy handle to get reused by a separate one in a
later transfer. Just reuse the multi handle.

## Sharing the connection cache

Since libcurl 7.57.0, applications can use the
[share interface](../../helpers/sharing.md)
to have otherwise independent transfers share the same connection pool.

## When connections are not reused as you want

libcurl will automatically and always try to reuse connections unless
explicitly told not to. There are however several reasons why a connection is
*not* used for a subsequent transfer.

 - The server signals that the connection will be closed after this transfer.
   For example by using the `Connection: close` HTTP response header or a
   HTTP/2 or HTTP/3 "go away" frame.

 - The HTTP/1 response of a transfer is sent in such a way that a connection
   close is the only way to detect the end of the body. Or just an HTTP/1
   receive error that makes curl deem that it cannot safely reuse the
   connection anymore.

 - The connection is deemed "dead" when libcurl tries to reuse it. It might
   happen when the server side has closed the connection after the previous
   transfer was completed. It can also happen if a stateful firewall/NAT or
   something in the network path drops the connection or if there is HTTP/2 or
   HTTP/3 traffic (like PING frames) over the connection when unattended.

 - The previous transfer is deemed too old to reuse. If
   `CURLOPT_MAXLIFETIME_CONN` is set, libcurl will not reuse a connection that
   is older than the set value in seconds.

 - The previous transfer is deemed having idled for too long. By default
   libcurl never attempts to reuse a connection that has been idle for more
   than 118 seconds. This time can be changed with `CURLOPT_MAXAGE_CONN`.

 - If the connection pool is full when a transfer ends and a new connection is
   about to get stored there, the oldest idle connection in the pool is closed
   and discarded and therefore cannot be reused anymore. Increase the
   connection pool size with `CURLMOPT_MAXCONNECTS` or `CURLOPT_MAXCONNECTS`,
   depending on which API you are using.

 - When using the multi interface, if the previous transfer has not ended when
   the next transfer is started, and the previous connection cannot be used
   for multiplexing.

Etc. Usually you can learn about the reason by enabling `CURLOPT_VERBOSE` and
inspecting what libcurl informs the application.
