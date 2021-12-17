## SOCKS proxy

SOCKS is a protocol used for proxies and curl supports it. curl supports both
SOCKS version 4 as well as version 5, and both versions come in two flavors.

You can select the specific SOCKS version to use by using the correct scheme
part for the given proxy host with `-x`, or you can specify it with a separate
option instead of `-x`.

SOCKS4 is for the version 4 and SOCKS4a is for the version 4 without resolving
the host name locally:

    curl -x socks4://proxy.example.com http://www.example.com/

    curl --socks4 proxy.example.com http://www.example.com/

The SOCKS4a versions:

    curl -x socks4a://proxy.example.com http://www.example.com/

    curl --socks4a proxy.example.com http://www.example.com/

SOCKS5 is for the version 5 and SOCKS5-hostname is for the version 5 without
resolving the host name locally:

    curl -x socks5://proxy.example.com http://www.example.com/

    curl --socks5 proxy.example.com http://www.example.com/

The SOCKS5-hostname versions. This sends the host name to the server so
there is no name resolving done locally:

    curl -x socks5h://proxy.example.com http://www.example.com/

    curl --socks5-hostname proxy.example.com http://www.example.com/
