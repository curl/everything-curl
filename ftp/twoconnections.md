# Two connections

FTP uses two TCP connections. The first connection is setup by the client when
it connects to an FTP server, and is called the *control connection*. As the
initial connection, it gets to handle authentication and changing to the
correct directory on the remote server, etc. When the client then is ready to
transfer a file, a second TCP connection is established and the data is
transferred over that.

This setting up of a second connection causes nuisances and headaches for
several reasons.

## Active connections

The client can opt to ask the server to connect to the client to set it up, a
so-called *active* connection. This is done with the PORT or EPRT
commands. Allowing a remote host to connect back to a client on a port that
the client opens up requires that there is no firewall or other network
appliance in between that refuses that to go through and that is far from
always the case. You ask for an active transfer using `curl -P [arg]` (also
known as `--ftp-port` in long form) and while the option allows you to specify
exactly which address to use, just setting the same as you come from is almost
always the correct choice and you do that with `-P -`, like this way to ask
for a file:

    curl -P - ftp://example.com/foobar.txt

You can also explicitly ask curl to not use EPRT (which is a slightly newer
command than PORT) with the `--no-eprt` command-line option.

## Passive connections

Curl defaults to asking for a *passive* connection, which means it sends a
PASV or EPSV command to the server and then the server opens up a new port for
the second connection that then curl connects to. Outgoing connections to a
new port are generally easier and less restricted for end users and clients
but requires that the network in the server's end allows it.

Passive connections are enabled by default, but if you have switched on active
before, you can switch back to passive with `--ftp-pasv`.

You can also explicitly ask curl not to use EPSV (which is a slightly newer
command than PASV) with the `--no-epsv` command-line option.

Sometimes the server is running a funky setup so that when curl issues the
PASV command and the server responds with an IP address for curl to connect
to, that address is wrong and then curl fails to setup the data
connection. For this (rare) situation, you can ask curl to ignore the IP
address mentioned in the PASV response (`--ftp-skip-pasv-ip`) and instead use
the same IP address it has for the control connection even for the second
connection.

## Firewall issues

Using either active or passive transfers, any existing firewalls in the
network path pretty much have to have stateful inspection of the FTP traffic
to figure out the new port to open that up and accept it for the second
connection.

