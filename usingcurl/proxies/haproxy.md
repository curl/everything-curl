# haproxy

The haproxy protocol, while still having proxy in its name, is different than
other proxy options and does not work with proxies in the same way the other
proxy options do.

This is a way for a client to pass its IP address to the server in spite of
how the traffic reaches it: tunnels, TCP proxies, load balancers, transparent
proxies and what not. Services that somehow change what source IP address that
is being used when the traffic ends up in the server, making it impossible for
the server to figure out the IP address of the client by itself.

The haproxy protocol is simple. It needs to be supported by the server,
meaning a user cannot just decide to use it with an unwilling or uncooperative
server. If it *does* support it, you can tell curl to use it to pass on its
own IP address to the server.

## curl and haproxy

curl only supports the haproxy protocol v1.

To pass on the actual IP address of the connection that is being used right
now, simply add the boolean flag like this:

    curl --haproxy-protocol https://example.com/

If such a command line for some reason does not provide the IP address you
think it should pass on, you can specify the exact address yourself, using
either an IPv4 or an IPv6 numerical address:

    curl --haproxy-clientip 10.0.0.1 https://example.com/
    curl --haproxy-clientip fe80::fea3:8a22 https://example.com/
