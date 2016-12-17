# Connections

Most of the protocols you use with curl speak TCP. With TCP, a client such as
curl must first figure out the IP address(es) of the host you want to
communicate with, then connect to it. "Connecting to it" means performing a
TCP protocol handshake.

For the typical command line that operates on a URL those are details that
are taken care of under the hood which you can mostly ignore. But at times
you might find yourself wanting to tweak the specifics…

## Name resolve tricks

### Edit the hosts file

Maybe you have your command line `curl http://example.com` and just want that
to instead connect to your local server instead of the actual live server.

You can normally and easily do that by editing your `hosts` file (`/etc/hosts`
on Linux and Unix systems) and adding, for example, `127.0.0.1 example.com` to
redirect the host to your localhost. But this edit requires admin access and it
has the downside that it affects all other applications at the same time, and
more.

### Change the Host: header

The `Host:` header is the normal way an HTTP client tells the HTTP server which
server it speaks to, as typically an HTTP server serves many different names
using the same software instance.

So, by passing in a custom modified `Host:` header you can usually have the
server respond with the contents of the site even when you didn't actually
connect to that host name.

For example, you run a test instance of your main site `www.example.com` on
your local machine and you want to have curl ask for the index html:

    curl -H "Host: www.example.com" http://localhost/

When setting a custom `Host:` header and using cookies, curl will extract the
custom name and use that as host when matching cookies to send off.

The `Host:` header is not enough when communicating with an HTTPS server. With
HTTPS there's a separate extension field in the TLS protocol called SNI
(Server Name Indication) that lets the client tell the server the name of the
server it wants to talk to. curl will only extract the SNI name to send from
the given URL.

### Provide a custom IP address for a name

Doing the hosts edit operation virtually, but directly with the curl command
line without having to edit any system files, you can force feed curl what IP
address it should use for a given name. Do you know better than the name resolver
where curl should go? Then you can! If you want to redirect port 80
access for `example.com` to instead reach your localhost:

    curl --resolve example.com:80:127.0.0.1 http://example.com/

You can even specify multiple `--resolve` switches to provide multiple
redirects of this sort, which can be handy if the URL you work with uses HTTP
redirects or if you just want to have your command line work with multiple
URLs.

`--resolve` inserts the address into curl's DNS cache, so it will effectively
make curl believe that's the address it got when it resolved the name.

When talking HTTPS, this will send SNI for the name in the URL and curl will
verify the server to make sure it serves for the name in the URL.

### Provide a replacement name

As a close relative to the `--resolve` option, the `--connect-to` option
provides a minor variation. It allows you to specify a replacement name and
port number for curl to use under the hood when a specific name and port
number is used to connect.

For example, suppose you have a single site called `www.example.com` that in turn
is actually served by three different individual HTTP servers: load1, load2
and load3, for load balancing purposes. In a typical normal procedure, curl
resolves the main site and gets to speak to one of the load balanced servers
(as it gets a list back and just picks one of them) and all is well. If you
want to send a test request to one specific server out of the load balanced
set (`load1.example.com` for example) you can instruct curl to do that.

You *can* still use `--resolve` to accomplish this if you know the specific IP
address of load1. But without having to first resolve and fix the IP address
separately, you can tell curl:

    curl --connect-to www.example.com:80:load1.example.com:80 http://www.example.com

It redirects from a SOURCE NAME + SOURCE PORT to a DESTINATION NAME +
DESTINATION PORT. curl will then resolve the `load1.example.com` name and
connect, but in all other ways still assume it is talking to
`www.example.com`.

### Name resolve tricks with c-ares

As should be detailed elsewhere in this book, curl can get built with several
different name resolving backends. One of those backends is powered by the
c-ares library and when curl is built to use c-ares, it gets a few extra super
powers that curl built to use other name resolve backends don't get. Namely
the ability to more specificly instruct what DNS servers to use and how that
DNS traffic is using the network.

With `--dns-servers`, you can specify exactly which DNS server curl should use
instead of the default one. This lets you run your own experiental server that
answers differently, or just use a backup one if your regular one seems
unreliable or dead.

With `--dns-ipv4-addr` and `--dns-ipv6-addr` you ask curl to "bind" its local
end of the DNS communication to a specific IP address and with
`--dns-interface` you can instruct curl to use a specific network interface to
send its DNS requests over.

These `--dns-*` options are of course very specific and are only meant for
those of you very aware of what you want and what these options do. But then
they offer very customizable DNS name resolve operations.

## Connection timeout

curl typically makes a TCP connection to the specific host as an initial part
of its network transfer. This TCP connection can of course fail or sometimes
be very slow depending on all sorts of shaky network conditions or perhaps
even faulty remote servers.

To reduce the impact on your scripts or other use, you can set a maximum time
to curl for which it will allow the connect attempt to go on. With
`--connnect-timeout` you simply tell curl the maximum time to allow for this,
and if curl hasn't made it connect in that time it returns a failure.

The connection timeout is only limiting the time curl is allowed to spend up
until the moment it connects, so once the TCP connection has been established
it can then again take longer time. See the [Timeouts](usingcurl-timeouts.md)
section for more on generic curl timeouts.

## Specify network interface

TBD

## Local port number

--local-port

TBD

## Keep alive

TBD

## SSH and TLS connections

TBD
