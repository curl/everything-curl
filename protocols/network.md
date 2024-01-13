# Networking simplified

Networking means communicating between two endpoints on the Internet. The
Internet is just a bunch of interconnected machines (computers really), each
using its own individual addresses (called [IP
addresses](https://en.wikipedia.org/wiki/IP_address)). The addresses each
machine has can be of different types and machines can even have temporary
addresses. These computers are also called hosts.

## Client and server

The computer, tablet or phone you sit in front of is usually called *the
client* and the machine out there somewhere that you want to exchange data
with is called *the server*. The main difference between the client and the
server is in the roles they play. There is nothing that prevents the roles
from being reversed in a subsequent operation.

A transfer initiative is always taken by the client, as the server cannot
contact the client but the client can contact the server.

## Which machine

When we as a client want to initiate a transfer from or to one of the machines
out there (a server), we usually do not know its IP addresses but instead we
usually know its name. The name of the machine to communicate with is
typically embedded in the URL that we work with when we use tools like curl or
a browser.

We might use a URL like `http://example.com/index.html`, which means the
client connects to and communicates with the host named example.com.

## Hostname resolving

Once the client knows the hostname, it needs to figure out which IP addresses
the host with that name has so that it can contact it.

Converting the name to an IP address is called 'name resolving'. The name is
*resolved* to one or a set of addresses. This is usually done by a *DNS
server*, DNS being like a big lookup table that can convert names to
addresses—all the names on the Internet, really. The computer normally already
knows the address of a computer that runs the DNS server as that is part of
setting up the network.

The network client therefore asks the DNS server, *Hello, please give me all
the addresses for `example.com`*. The DNS server responds with a list of
addresses back. Or in case of spelling errors, it can answer back that the
name does not exist.

## Establish a connection

With one or more IP addresses for the host the client wants to contact, it
sends a *connect request*. The connection it wants to establish is called a
TCP ([Transmission Control
Protocol](https://en.wikipedia.org/wiki/Transmission_Control_Protocol)) or
[QUIC](https://en.wikipedia.org/wiki/QUIC) connection, which is like
connecting an invisible string between two computers. Once established, the
string can be used to send a stream of data in both directions.

If the client has received more than one address for the host, it traverses
that list of addresses when connecting, and if one address fails it tries to
connect to the next one, repeating until either one address works or they have
all failed.

## Connect to port numbers

When connecting with TCP or QUIC to a remote server, a client selects which
port number to do that on. A port number is just a dedicated place for a
particular service, which allows that same server to listen to other services
on other port numbers at the same time.

Most common protocols have default port numbers that clients and servers
use. For example, when using the `http://example.com/index.html` URL, that URL
specifies a *scheme* called `HTTP` which tells the client that it should try
TCP port number 80 on the server by default. If the URL uses `HTTPS` instead,
the default port number is 443.

The URL can include a custom port number. If a port number is not specified,
the client uses the default port for the scheme used in the URL.

## Security

After a TCP connection has been established, many transfers require that both
sides negotiate a better security level before continuing (if for example
`HTTPS` is used), which is done with TLS ([Transport Layer
Security](https://en.wikipedia.org/wiki/Transport_Layer_Security)). If so, the
client and server do a TLS handshake first, and continue further only if that
succeeds.

If the connection is done using QUIC, the TLS handshake is done automatically
in the connect phase.

## Transfer data

When the connected metaphorical *string* is attached to the remote computer,
there is a *connection* established between the two machines. This connection
can then be used to exchange data. This exchange is done using a *protocol*,
as discussed in the following chapter.

Traditionally, a *download* is when data is transferred from a server to a
client; conversely, an *upload* is when data is sent from the client to the
server. The client is *down here*; the server is *up there*.

## Disconnect

When a single transfer is completed, the connection may have served its purpose. It
can then either be reused for further transfers, or it can be disconnected and
closed.
