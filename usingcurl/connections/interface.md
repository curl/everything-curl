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

