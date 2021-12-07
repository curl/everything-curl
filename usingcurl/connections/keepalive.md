# Keep alive

TCP connections can be totally without traffic in either direction when they
are not used. A totally idle connection can therefore not be clearly separated
from a connection that has gone completely stale because of network or server
issues.

At the same time, lots of network equipment such as firewalls or NATs are
keeping track of TCP connections these days, so that they can translate
addresses, block "wrong" incoming packets, etc. These devices often count
completely idle connections as dead after N minutes, where N varies between
device to device but at times is as short as 10 minutes or even less.

One way to help avoid a really slow connection (or an idle one) getting
treated as dead and wrongly killed, is to make sure TCP keep alive is
used. TCP keepalive is a feature in the TCP protocol that makes it send "ping
frames" back and forth when it would otherwise be totally idle. It helps idle
connections to detect breakage even when no traffic is moving over it, and
helps intermediate systems not consider the connection dead.

curl uses TCP keepalive by default for the reasons mentioned here. But there
might be times when you want to *disable* keepalive or you may want to change
the interval between the TCP "pings" (curl defaults to 60 seconds). You can
switch off keepalive with:

    curl --no-keepalive https://example.com/

or change the interval to 5 minutes (300 seconds) with:

    curl --keepalive-time 300 https://example.com/
