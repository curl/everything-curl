# Chunked encoded POSTs

When talking to an HTTP 1.1 server, you can tell curl to send the request body
without a `Content-Length:` header upfront that specifies exactly how big the
POST is. By insisting on curl using chunked Transfer-Encoding, curl sends the
POST chunked piece by piece in a special style that also sends the size for
each such chunk as it goes along.

You send a chunked POST with curl like this:

    curl -H "Transfer-Encoding: chunked" -d @file http://example.com

## Caveats

This assumes that you know you do this against an HTTP/1.1 server. Before 1.1,
there was no chunked encoding, and after version 1.1 chunked encoding has been
deprecated.
