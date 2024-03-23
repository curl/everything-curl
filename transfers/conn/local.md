# Local address and port number

In almost all situations you want to let the system pick the default source IP
address and local port number when setting up a connection.

For the rare instances when that is not good enough, libcurl features
overrides.

## Local address

A connection created by libcurl needs to have a source IP that routes back to
this host. An application can not just randomly pick whatever IP address it
wants to use and expect that to work. A network interface in the machine needs
to have the IP address assigned.

You can ask libcurl to use a non-default IP address with `CURLOPT_INTERFACE`.
As the name hints, it is designed to get a named network interface as input
and it will then attempt to use that interface's IP address for outgoing
traffic.

The name can however instead be an IP address or a hostname, even though **we
do not recommend using those versions**.

To prevent libcurl from guessing what kind of input that is provided, prefix
the interface name with "if!", to make sure the name is not mistaken for a
hostname.

Similarly, you prefix the provided name with "host!" to insist the address is
a hostname or IP number.

## Local port number

By default, 16 bit random source local port numbers are used for connections,
from the so called *ephemeral port* range. An application can ask for a
specific port range to be used with the `CURLOPT_LOCALPORT` and
`CURLOPT_LOCALPORTRANGE` options. Since port numbers are finite resources,
narrowing the selection of ports to select from will increase the risk that
the connection cannot be setup if none of the attempted port numbers are
currently available to be used.
