# Port number

Each protocol has a "default port" that curl will use for it, unless a
specified port number is given. The optional port number can be provided
within the URL after the host name part, as a colon and the port number
written in decimal. For example, asking for an HTTP document on port 8080:

    curl http://example.com:8080/

With the name specified as an IPv4 address:

    curl http://127.0.0.1:8080/

With the name given as an IPv6 address:

    curl http://[fdea::1]:8080/

The port number is an unsigned 16 bit number, so it has to be within the range
0 to 65535.
