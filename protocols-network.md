## Networking simplified

Networking means communicating between two endpoints on the Internet. The
Internet is just a bunch of interconnected machines (computers really), each
using their own private addresses (called [IP addresses](https://en.wikipedia.org/wiki/IP_address)). The addresses each
machine have can be of different types and machines can even have temporary
addresses. These computers are often called hosts.

The computer, tablet or phone you sit in front of is usually called "the
client" and the machine out there somewhere that you want to exchange data
with is called "the server". The main difference between the client and the
server is in the roles they play here. There's nothing that prevents the roles
from being reversed in a subsequent operation.

### Which machine

When you want to initiate a transfer to one of the machines out there (a
server), you usually do not know its IP addresses but instead you usually
know its name. The name of the machine you will talk to is embedded in the URL
that you work with when you use curl.

You might use a URL like "http://example.com/index.html", which means you will
connect to and communicate with the host named example.com.

### Host name resolving

Once we know the host name, we need to figure out which IP addresses that host
has so that we can contact it.

Converting the name to an IP address is often called 'name resolving'. The name
is "resolved" to a set of addresses. This is usually done by a "DNS
server", DNS being like a big lookup table that can convert names to
addresses—all the names on the Internet, really. Your computer normally
already knows the address of a computer that runs the DNS server as that is
part of setting up the network.

curl will therefore ask the DNS server: "Hello, please give me all the
addresses for example.com", and the server responds with a list of them. Or in
the case you spell the name wrong, it can answer back that the name does not
exist.

### Establish a connection

With a list of IP addresses for the host curl wants to contact, curl sends out
a "connect request". The connection curl wants to establish is called TCP and
it works sort of like connecting an invisible string between two
computers. Once established, it can be used to send a stream of data in both
directions.

As curl gets a list of addresses for the host, it will actually traverse that
list of addresses when connecting and in case one fails it will try to connect
to the next one until either one works or they all fail.

### Connects to "port numbers"

When connecting with TCP to a remote server, a client selects which port
number to do that on. A port number is just a dedicated place for a
particular service, which allows that same server to listen to other services on
other port numbers at the same time.

Most common protocols have default port numbers that clients and servers
use. For example, when using the "http://example.com/index.html" URL, that URL
specifies a scheme called "http" which tells the client that it should try TCP
port number 80 on the server by default. The URL can optionally provide
another, custom, port number but if nothing special is specified, it will use the
default port for the scheme used in the URL.

### TLS

After the TCP connection has been established, many transfers will require
that both sides negotiate a better security level before continuing, and that
is often TLS; Transport Layer Security. If that is used, the client and server
will do a TLS handshake first and only continue further if that succeeds.

### Transfer data

When the connecting "string" we call TCP is attached to the remote computer
(and we have done the possible additional TLS handshake), there's an
established connection between the two machines and that connection can then
be used to exchange data. That communication is done using a "protocol", as
discussed in the following chapter.
