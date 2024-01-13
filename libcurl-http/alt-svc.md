# alt-svc

Alternative Services, aka alt-svc, is an HTTP header that lets a server tell
the client that there is one or more *alternatives* for that server at
another place with the use of the `Alt-Svc:` response header.

The *alternatives* the server suggests can include a server running on another
port on the same host, on another completely different hostname and it can
also offer the service *over another protocol*.

## Enable

To make libcurl consider any offered alternatives by serves, you must first
enable it in the handle. You do this by setting the correct bitmask to the
`CURLOPT_ALTSVC_CTRL` option. The bitmask allows the application to limit what
HTTP versions to allow, and if the cache file on disk should only be used to
read from (not write).

Enable alt-svc and allow it to switch to either HTTP/1 or HTTP/2:

    curl_easy_setopt(curl, CURLOPT_ALTSVC_CTRL, CURLALTSVC_H1|CURLALTSVC_H2);

Tell libcurl to use a specific alt-svc cache file like this:

    curl_easy_setopt(curl, CURLOPT_ALTSVC, "altsvc-cache.txt");

libcurl holds the list of alternatives in a memory-based cache, but loads all
already existing alternative service entries from the alt-svc file at start-up
and consider those when doing its subsequent HTTP requests. If servers
responds with new or updated `Alt-Svc:` headers, libcurl stores those in the
cache file at exit (unless the `CURLALTSVC_READONLYFILE` bit was set).

## The alt-svc cache

The alt-svc cache is similar to a cookie jar. It is a text based file that
stores one alternative per line and each entry also has an expiry time for
which duration that particular alternative is valid.

## HTTPS only

`Alt-Svc:` is only trusted and parsed from servers when connected to over
HTTPS.

## HTTP/3

The use of `Alt-Svc:` headers is as of March 2022 still the only defined way
to bootstrap a client and server into using HTTP/3. The server then hints to
the client over HTTP/1 or HTTP/2 that it also is available over HTTP/3 and
then curl can connect to it using HTTP/3 in the subsequent request if the
alt-svc cache says so.
