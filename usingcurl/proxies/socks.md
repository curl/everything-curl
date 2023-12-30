# SOCKS proxy

SOCKS is a protocol used for proxies and curl supports it. curl supports both
SOCKS version 4 as well as version 5, and both versions come in two flavors.

You can select the specific SOCKS version to use by using the correct scheme
part for the given proxy host with `-x`, or you can specify it with a separate
option instead of `-x`.

SOCKS4 is for the version 4 but curl resolves the name:

    curl -x socks4://proxy.example.com http://www.example.com/

    curl --socks4 proxy.example.com http://www.example.com/

SOCKS4a is for the version 4 with resolving done by the proxy:

    curl -x socks4a://proxy.example.com http://www.example.com/

    curl --socks4a proxy.example.com http://www.example.com/

SOCKS5 is for the version 5 and SOCKS5-hostname is for the version 5 without
resolving the hostname locally:

    curl -x socks5://proxy.example.com http://www.example.com/

    curl --socks5 proxy.example.com http://www.example.com/

The SOCKS5-hostname versions. This sends the hostname to the proxy so there
is no name resolving done by curl locally:

    curl -x socks5h://proxy.example.com http://www.example.com/

    curl --socks5-hostname proxy.example.com http://www.example.com/

Helpful table to figure how which side that resolves the name for which socks
version:

| SOCKS | who resolves the name | works with IPv6 |
|-------|-----------------------|-----------------|
| 4     | curl                  | no              |
| 4a    | proxy                 | no              |
| 5     | curl                  | yes             |
| 5h    | proxy                 | yes             |
