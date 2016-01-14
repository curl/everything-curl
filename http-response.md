### HTTP responses

When an HTTP client talks HTTP to a server, the server *will* respond with an
HTTP response message or curl will consider it an error and returns 52 with
the error message "Empty reply from server".

#### Size of an HTTP response

An HTTP response has a certain size and curl needs to figure it out. There are
several different ways to signal the end of an HTTP response but the most
basic way is to use the `Content-Length:` header in the response and with that
specify the exact number of bytes in the response body.

Some early HTTP server implementations had problems with file sizes greater
than 2GB, and wrongly managed to send Content-Length: headers with negative
sizes or otherwise just plain wrong data. curl can be told to ignore the
Content-Length: header completely with `--ignore-content-length`. Doing so may
have some other negative side-effects but should at least let you get the
data.

### HTTP response codes

An HTTP transfer gets a 3 digit response code back in the first response line.
The response code is the server's way of giving the client a hint about how
the request was handled.

It is important to note that curl does not consider it an error even if the
response code would indicate that the requested documented couldn't be
delivered or similar. curl considers a successful sending and receiving of
HTTP to be good.

The first digit of the HTTP response code is a kind of "error class":

 - 1xx: transient response, more is coming
 - 2xx: success
 - 3xx: a redirect
 - 4xx: the client asked for something the server couldn't/wouldn't deliver
 - 5xx: there's problem in the server

Remember that you can use curl's `--write-out` option to extract the response
code. See the [--write-out](usingcurl-verbose.md#--writeout) section.

### CONNECT response codes

Since there can be a HTTP request and a separate CONNECT request in the same
curl transfer, we often separate the CONNECT response (from the proxy) from
the remote server's HTTP response.

The CONNECT is also an HTTP request so it gets response codes in the same
numeric range and you can use `--write-out` to extract that code as well.

### Chunked transfer encoding

TBD

### Gzipped transfers

TBD

### Transfer encoding

TBD
