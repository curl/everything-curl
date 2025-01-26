# Happy Eyeballs

When curl is about to connect to a given host, it has a list of addresses to
try. The address list is separated into two lists: one list with IPv4
addresses and one list with IPv6 addresses.

curl starts by initiating a connect attempt to the first address in the IPv6
list. If the connect attempt fails, it moves on to the next address in the
list iterating through them all one by one until one works.

If, after two hundred milliseconds curl still tries to connect to IPv6, it
starts a second series of attempts over IPv4 in parallel. In the same style it
iterates over the list of IPv4 addresses on connect errors. A connection race
if you will.

The first connect that works wins, and all the other attempts are then
discarded.

## HTTP/3 racing

When asked to attempt HTTP/3 (with `--http3`), curl ups the connection racing
game one level.

curl first starts the Happy Eyeballs connect attempt for QUIC as described
above. First it tries IPv6 QUIC and then IPv4 QUIC after a timeout. If there
is no successful QUIC connection within the first two hundred milliseconds (or
no UDP package received at all within half the timeout window, one hundred
milliseconds by default), curl starts a *second* Happy Eyeballs scenario for
TCP - first IPv6 TCP and then IPv4 TCP after the timeout.

The first connect attempt that succeeds out of the up to four parallel ones
that are running, wins. The "losers" are then simply discarded.

## Tweak

The two hundred milliseconds may delay your connects longer than you might
want. For example when TCP packets over IPv6 are never getting any response on
a certain network path or server.

Or vice versa, you may need to communicate to a server with high latency, in
which case the default timeout would strike too early.

For moments and scenarios like these, curl provides the
`--happy-eyeballs-timeout-ms` command line option. It changes the default two
hundred milliseconds to whatever you specify. Setting it to zero makes curl
start the connection attempts at exactly the same time.
