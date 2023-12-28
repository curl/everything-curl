# Local port number

A TCP connection is created between an IP address and a port number in the
local end and an IP address and a port number in the remote end. The remote
port number can be specified in the URL and usually helps identify which
service you are targeting.

The local port number is usually randomly assigned to your TCP connection by
the network stack and you normally do not have to think about it much further.
However, in some circumstances you find yourself behind network equipment,
firewalls or similar setups that put restrictions on what source port numbers
that can be allowed to set up the outgoing connections.

For situations like this, you can specify which local ports curl should bind
the connection to. You can specify a single port number to use, or a range of
ports. We recommend using a range because ports are scarce resources and the
exact one you want may already be in use. If you ask for a local port number
(or range) that curl cannot obtain for you, it exits with a failure.

Also, on most operating systems you cannot bind to port numbers below 1024
without having a higher privilege level (root) and we generally advise
against running curl as root if you can avoid it.

Ask curl to use a local port number between 4000 and 4200 when getting this
HTTPS page:

    curl --local-port 4000-4200 https://example.com/
