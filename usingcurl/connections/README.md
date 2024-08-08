# Connections

Most of the URLs you use with curl have a hostname and involve communication
over IP. curl must first figure out the IP address(es) of the host you want to
communicate with, then connect to it. "Connecting to it" means performing a
protocol handshake.

For ordinary command line usage, operating on a URL, these are details which
are taken care of under the hood, and which you can mostly ignore. But at times
you might find yourself wanting to tweak the specifics…

* [Name resolve tricks](name.md)
* [Connection timeout](timeout.md)
* [Happy Eyeballs](happy.md)
* [Network interface](interface.md)
* [Local port number](local-port.md)
* [Keep alive](keepalive.md)
