# HTTP basics
 
HTTP is a protocol that is easy to learn the basics of. A client connects to a
server—and it is always the client that takes the initiative—sends a
request and receives a response. Both the request and the response consist of
headers and a body. There can be little or a lot of information going in both
directions.

An HTTP request sent by a client starts with a request line, followed by
headers and then optionally a body. The most common HTTP request is probably
the GET request which asks the server to return a specific resource, and this
request does not contain a body.

When a client connects to 'example.com' and asks for the '/' resource, it
sends a GET without a request body:

    GET / HTTP/1.1
    User-agent: curl/2000
    Host: example.com

…the server could respond with something like below, with response headers
and a response body ('hello'). The first line in the response also contains
the response code and the specific version the server supports:

    HTTP/1.1 200 OK
    Server: example-server/1.1
    Content-Length: 5
    Content-Type: plain/text

    hello

If the client would instead send a request with a small request body
('hello'), it could look like this:

    POST / HTTP/1.1
    Host: example.com
    User-agent: curl/2000
    Content-Length: 5

    hello

A server always responds to an HTTP request unless something is wrong.

## The URL converted to a request

So when an HTTP client is given a URL to operate on, that URL is then used,
picked apart and those parts are used in various places in the outgoing
request to the server. Let's take an example URL:

    https://www.example.com/path/to/file

 - **https** means that curl uses TLS to the remote port 443 (which is the
   default port number when no specified is used in the URL).

 - **www.example.com** is the hostname that curl resolves to one or more IP
   addresses to connect to. This hostname is also used in the HTTP request in
   the `Host:` header.

 - **/path/to/file** is used in the HTTP request to tell the server which exact
   document/resources curl wants to fetch
