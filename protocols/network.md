# Networking simplified

Networking means communicating between two endpoints on the Internet. The
Internet is just a bunch of interconnected machines (computers really), each
using its own individual addresses (called [IP
addresses](https://en.wikipedia.org/wiki/IP_address)). The addresses each
machine has can be of different types and machines can even have temporary
addresses. These computers are often called hosts.

## Client and server

The computer, tablet or phone you sit in front of is usually called "the
client" and the machine out there somewhere that you want to exchange data
with is called "the server". The main difference between the client and the
server is in the roles they play here. There is nothing that prevents the
roles from being reversed in a subsequent operation.

A transfer initiative is always taken by the client, as the server cannot
contact the client but the client can contact the server.

## Which machine

When we as a client want to initiate a transfer from or to one of the machines
out there (a server), we usually do not know its IP addresses but instead we
usually know its name. The name of the machine you will talk to is embedded in
the URL that we work with when we use tools like curl or a browser.

We might use a URL like `http://example.com/index.html`, which means the
client will connect to and communicate with the host named example.com.

## Host name resolving

Once the client knows the host name, it needs to figure out which IP addresses
the host with that name has so that it can contact it.

Converting the name to an IP address is often called 'name resolving'. The
name is "resolved" to one or a set of addresses. This is usually done by a
"DNS server", DNS being like a big lookup table that can convert names to
addresses—all the names on the Internet, really. The computer normally already
knows the address of a computer that runs the DNS server as that is part of
setting up the network.

The network client will therefore ask the DNS server: "Hello, please give me
all the addresses for example.com", and the server responds with a list of
them. Or in case of spelling errors, it can answer back that the name does not
exist.

## Establish a connection

With one or more IP addresses for the host the client wants to contact, it
sends a "connect request". The connection it wants to establish is called a
TCP ([Transmission Control
Protocol](https://en.wikipedia.org/wiki/Transmission_Control_Protocol)) or
[QUIC](https://en.wikipedia.org/wiki/QUIC) connection and they work similar to
connecting an invisible string between two computers. Once established, the
string can be used to send a stream of data in both directions.

If the client has received more than one address for the host, it will
traverse that list of addresses when connecting and in case one of fails it
will try to connect to the next one until either one connect works or they all
fail.

## Connects to port numbers

When connecting with TCP or QUIC to a remote server, a client selects which
port number to do that on. A port number is just a dedicated place for a
particular service, which allows that same server to listen to other services
on other port numbers at the same time.

Most common protocols have default port numbers that clients and servers
use. For example, when using the `http://example.com/index.html` URL, that URL
specifies a *scheme* called `HTTP` which tells the client that it should try
TCP port number 80 on the server by default. If the URL uses `HTTPS` instead,
the default port number is 443.

The URL can optionally provide another, custom, port number but if nothing
special is specified, it will use the default port for the scheme used in the
URL.

## Security

After a TCP connection has been established, many transfers will require that
both sides negotiate a better security level before continuing (if for example
`HTTPS` is used), done with TLS; [Transport Layer
Security](https://en.wikipedia.org/wiki/Transport_Layer_Security). If that is
used, the client and server will do a TLS handshake first and only continue
further if that succeeds.

If the connection is done using QUIC, the TLS handshake is done automatically
in connect phase.

## Transfer data

When the connected metaphorical "string" is attached to the remote computer,
there is an established *connection* between the two machines and this
connection can then be used to exchange data. That communication is done using
a "protocol", as discussed in the following chapter.

Traditionally, what is called a *download* is when data is transferred from a
server to a client and inversely an *upload* is when data is transferred from
the client to the server. The client is down here. The server is up there.

## Disconnect

When a single transfer is done, the connection may have served its purpose. It
can then either be reused for further transfers, or it can be disconnected and
closed down.
