## Networking simplified

Internetworking means communicating between two endpoints on the Internet. The
Internet is just a bunch of interconnected machines (computers really), all
using their own private addresses (called IP addresses). The addresses each
machine have can be of different types and machines can even have temporary
addresses. These computers are often called hosts.

The computer, tablet or phone you sit in front of, is usually called "the
client" and the machine out there somewhere that you want to exchange data
with is called "the server". The main difference between the client and the
server is in the roles they play here. There's nothing that prevents the roles
from being reversed in a subsequent operation.

### Which machine

When you want to initiate a transfer to one of the machines out there (a
server), you usually don't know their IP addresses but instead you usually
know its name. The name of the machine you will talk to is embedded in the URL
that you work with when you use curl.

You might use a URL like "http://example.com/index.html", which means you will
connect to and communicate the host named example.com.

### Host name resolving

Once we know the host name, we need to figure out which IP addresses that host
has, so that we can contact it.

Converting the name to IP addresses is often called 'name resolving'. The name
is "resolved" to a set of addresses. This is usually done by a "DNS
server". DNS being like the big lookup-table that can convert names to
addresses - all the names on the Internet really. Your computer normally
already knows the address of a computer that runs the DNS server as that is
part of setting up the network.

curl will therefore ask the DNS server: "hello, please give me all the
addresses for example.com", and the server responds with a list of them. Or in
the case you spell the name wrong, it can answer back that the name doesn't
exist.

### Establish a connection

With a list of IP addresses for the host curl wants to contact, curl sends out
a "connect request". The connection curl wants to establish is called TCP and
it works sort of like connecting an invisible string between two
computers. Once established, it can be used to send a stream of data in both
directions.

As curl gets a list of addresses for the host, it will actually traverse that
list of addresses when connecting and in case one fails it'll try to connect
to the next one until either one works or they all failed.

### Transfer data

When the "string" we call TCP is attached to the remote computer, there's an
established connection between the two machines and that connection can then
be used to exchange data.
