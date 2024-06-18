# Alternative Services

[RFC 7838](https://www.rfc-editor.org/rfc/rfc7838.txt) defines an HTTP header
which lets a server tell a client that there is one or more *alternatives* for
that server at another place with the use of the `Alt-Svc:` response header.

The *alternatives* the server suggests can include a server running on another
port on the same host, on another completely different hostname and it can
even perhaps offer the service over another protocol.

## Enable

To make curl consider offered alternatives, tell curl to use a specific
alt-svc cache file like this:

    curl --alt-svc altcache.txt https://example.com/

then curl loads existing alternative service entries from the file at start-up
and consider those when doing HTTP requests, and if the servers sends new or
updated `Alt-Svc:` headers, curl stores those in the cache at exit.

## The alt-svc cache

The alt-svc cache is similar to a cookie jar. It is a text based file that
stores one alternative per line and each entry also has an expiry time for
which duration that particular alternative is valid.

## HTTPS only

`Alt-Svc:` is only trusted and parsed from servers when connected to over
HTTPS.

## HTTP/3

The use of `Alt-Svc:` headers is as of August 2019 the only defined way to
bootstrap a client and server into using HTTP/3. The server then hints to the
client over HTTP/1 or HTTP/2 that it also is available over HTTP/3 and then
curl can connect to it using HTTP/3 in the subsequent request if the alt-svc
cache says so.
