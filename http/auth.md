# Authentication

Each HTTP request can be made authenticated. If a server or a proxy want the
user to provide proof that they have the correct credentials to access a URL
or perform an action, it can send an HTTP response code that informs the client
that it needs to provide a correct HTTP authentication header in the request
to be allowed.

A server that requires authentication sends back a 401 response code and an
associated `WWW-Authenticate:` header that lists all the authentication
methods that the server supports.

An HTTP proxy that requires authentication sends back a 407 response code and
an associated `Proxy-Authenticate:` header that lists all the authentication
methods that the proxy supports.

It might be worth to note that most websites of today do not require HTTP
authentication for login etc, but they instead ask users to login on webpages
and then the browser issues a POST with the user and password etc, and then
subsequently maintain cookies for the session.

To tell curl to do an authenticated HTTP request, you use the `-u, --user`
option to provide username and password (separated with a colon). Like this:

    curl --user daniel:secret http://example.com/

This makes curl use the default *Basic* HTTP authentication method. Yes, it is
actually called Basic and it is truly basic. To explicitly ask for the basic
method, use `--basic`.

The Basic authentication method sends the username and password in clear text
over the network (base64 encoded) and should be avoided for HTTP transport.

When asking to do an HTTP transfer using a single (specified or implied),
authentication method, curl inserts the authentication header already in the
first request on the wire.

If you would rather have curl first *test* if the authentication is really
required, you can ask curl to figure that out and then automatically use the
most safe method it knows about with `--anyauth`. This makes curl try the
request unauthenticated, and then switch over to authentication if necessary:

    curl --anyauth --user daniel:secret http://example.com/

and the same concept works for HTTP operations that may require
authentication:

    curl --proxy-anyauth --proxy-user daniel:secret http://example.com/ \
         --proxy http://proxy.example.com:80/

curl typically (a little depending on how it was built) speaks several other
authentication methods as well, including Digest, Negotiate and NTLM. You can
ask for those methods too specifically:

    curl --digest --user daniel:secret http://example.com/
    curl --negotiate --user daniel:secret http://example.com/
    curl --ntlm --user daniel:secret http://example.com/
