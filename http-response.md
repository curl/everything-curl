### HTTP responses

When a HTTP client talks HTTP to a server, the server *will* respond with a
HTTP response message or curl will consider it an error and returns 52 with
the error message "Empty reply from server".

#### Size of an HTTP response

A HTTP response has a certain size and a client needs to figure it out. There
are several different ways to signal the end of a HTTP response but the most
basic way is to use the `Content-Length:` header in the response and with that
specify the exact number of bytes in the response body.

Some early HTTP server implementations had problems with file sizes greater
than 2GB, and wrongly managed to send Content-Length: headers with negative
sizes or otherwise just plain wrong data. curl can be told to ignore the
Content-Length: header completely with `--ignore-content-length`. Doing so may
have some other negative side-effects but should at least let you get the
data.

### HTTP response codes

... and how they're not errors to curl

TBD

### Chunked transfer encoding

TBD

### Gzipped transfers

TBD

### Transfer encoding

TBD
