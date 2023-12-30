# HSTS

HSTS is short for HTTP Strict-Transport-Security. It is a defined way for a
server to tell a client that the client should prefer to use HTTPS with that
site for a specified period of time into the future.

Here is how you use HSTS with libcurl.

## In-memory cache

libcurl primarily features an in-memory cache for HSTS hosts, so that
subsequent HTTP-only requests to a hostname present in the cache gets
internally "redirected" to the HTTPS version. Assuming you have this feature
enabled.

## Enable HSTS for a handle

HSTS is enabled by setting the correct bitmask using the `CURLOPT_HSTS_CTRL`
option with `curl_easy_setopt()`. The bitmask has two separate flags that can
be used, but `CURLHSTS_ENABLE` is the primary one. If that is set, then this
easy handle how has HSTS support enabled.

The second flag available for this option is `CURLHSTS_READONLYFILE`, which if
set, tells libcurl that the filename you specify for it to use as a HSTS
cache is only to be read from, and not write anything back to.

## Set a HSTS cache file

If you want to persist the HSTS cache on disk, then set a filename with the
`CURLOPT_HSTS` option. libcurl reads from this file at start of a transfer and
writes to it (unless it was set read-only) when the easy handle is closed.
