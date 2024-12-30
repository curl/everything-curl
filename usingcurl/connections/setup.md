# Setup

There are several options that let the user control different aspects of how
connections are setup.

## VLAN

With the `--vlan-priority` command line option you set a priority value
between 0 and 7 that is set in the Ethernet header. It is thus limited to your
local network only and will not be used across any routers.

VLAN priority as defined in IEEE 802.1Q.

Example:

    curl --vlan-priority 4 https://example.com

## Type of Service

The IPv4 protocol header has a "Type of Service (TOS)" field. It is called
"Traffic Class" in IPv6. A user can set the value using the `--ip-tos` option
to either a numerical value between zero and 255, or by using one of the
recognized names:

    CS0, CS1, CS2, CS3, CS4, CS5, CS6, CS7, AF11, AF12, AF13,
    AF21, AF22, AF23, AF31, AF32, AF33, AF41, AF42, AF43, EF,
    VOICE-ADMIT, ECT1, ECT0, CE, LE, LOWCOST, LOWDELAY,
    THROUGHPUT, RELIABILITY, MINCOST

Example:

    curl --ip-tos CS5 https://example.com

## Multipath TCP

Multipath TCP is a way for a TCP connection to use multiple concurrent network
paths to maximize throughput and increase redundancy, compared to the normal
single path that ordinary TCP uses.

You can ask curl to use Multipath TCP with the `--mptcp` option. It only works
on Linux and it requires Linux 5.6 or later. It has no effect on QUIC or UDP
connections.

The server curl connects to must also support MPTCP. If not, the connection
seamlessly falls back to "normal" TCP.

Example:

    curl --mptcp https://example.com
