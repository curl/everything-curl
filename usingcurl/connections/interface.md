# Network interface

On machines with multiple network interfaces that are connected to multiple
networks, there are situations where you can decide which network interface
you would prefer the outgoing network traffic to use. Or which originating IP
address (out of the multiple ones you have) to use in the communication.

Tell curl which network interface, which IP address or even hostname that you
would like to "bind" your local end of the communication to, with the
`--interface` option:

    curl --interface eth1 https://www.example.com/

    curl --interface 192.168.0.2 https://www.example.com/

    curl --interface machine2 https://www.example.com/

We discourage use of a hostname in there, because how that forces curl to do a
name resolve to figure out an IP address. If you cannot specify an interface
name, consider using a fixed IP address.

In addition, you can ask to explicitly use and IP address or interface name to
prevent curl from having to guess. Do this by prefix the string with `if!` for
interface name or `host!` for an IP address. Like this:

    curl --interface "host!192.168.0.2" https://www.example.com/

    curl --interface "if!eth1" https://www.example.com/

You can even specify a specific IP and on a specific interface by providing
both like this:

    curl --interface "if!eith1!192.168.0.2" https://www.example.com/
