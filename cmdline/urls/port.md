# Port number

Each protocol has a default port number that curl uses, unless a specified
port number is given. The optional port number can be provided within the URL
after the hostname part, as a colon and the port number written in
decimal. For example, asking for an HTTP document on port 8080:

    curl http://example.com:8080/

With the name specified as an IPv4 address:

    curl http://127.0.0.1:8080/

With the name given as an IPv6 address:

    curl http://[fdea::1]:8080/

The port number is an unsigned 16 bit number, so it has to be within the range
0 to 65535.

## TCP vs UDP

The given port number is used when setting up the connection to the server
specified in the URL. The port is either a TCP port number or a UDP port
number depending on which actual underlying transport protocol that is
used. TCP is the most common one, but TFTP and HTTP/3 use UDP.

URLs using the `file://` scheme cannot have a port number.
