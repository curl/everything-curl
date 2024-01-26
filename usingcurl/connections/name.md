# Name resolve tricks

curl offers many ways to make it use another host than the one it normally would
connect to.

## Edit the hosts file

Maybe you want the command `curl http://example.com` to connect to your local
server instead of the actual server.

You can normally and easily do that by editing your `hosts` file (`/etc/hosts`
on Linux and Unix-like systems) and adding, for example, `127.0.0.1 example.com` to
redirect the host to your localhost. However this edit requires admin access and
it has the downside that it affects all other applications at the same time.

## Change the Host: header

The `Host:` header is the normal way an HTTP client tells the HTTP server which
server it speaks to, as typically an HTTP server serves many different names
using the same software instance.

So, by passing in a custom modified `Host:` header you can have the
server respond with the contents of the site even when you did not actually
connect to that hostname.

For example, you run a test instance of your main site `www.example.com` on
your local machine and you want to have curl ask for the index html:

    curl -H "Host: www.example.com" http://localhost/

When setting a custom `Host:` header and using cookies, curl extracts the
custom name and uses that as host when matching cookies to send off.

The `Host:` header is not enough when communicating with an HTTPS server. With
HTTPS there is a separate extension field in the TLS protocol called SNI
(Server Name Indication) that lets the client tell the server the name of the
server it wants to talk to. curl only extracts the SNI name to send from the
given URL.

## Provide a custom IP address for a name

Do you know better than the name resolver where curl should go? Then you can
give an IP address to curl yourself. If you want to redirect port 80 access
for `example.com` to instead reach your localhost:

    curl --resolve example.com:80:127.0.0.1 http://example.com/

You can even specify multiple `--resolve` switches to provide multiple
redirects of this sort, which can be handy if the URL you work with uses HTTP
redirects or if you just want to have your command line work with multiple
URLs.

`--resolve` inserts the address into curl's DNS cache, so it effectively makes
curl believe that is the address it got when it resolved the name.

When talking HTTPS, this sends SNI for the name in the URL and curl verifies
the server's response to make sure it serves for the name in the URL.

The pattern you specify in the option needs to be a hostname and its
corresponding port number and only if that exact pair is used in the URL is
the address substituted. For example, if you want to replace a hostname in an
HTTPS URL on its default port number, you need to tell curl it is for port
443, like:

    curl --resolve example.com:443:192.168.0.1 https://example.com/

## Provide a replacement name

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

    curl --connect-to www.example.com:80:load1.example.com:80 \
      http://www.example.com

It redirects from a SOURCE NAME + SOURCE PORT to a DESTINATION NAME +
DESTINATION PORT. curl then resolves the `load1.example.com` name and
connects, but in all other ways still assumes it is talking to
`www.example.com`.

## Name resolve tricks with c-ares

As should be detailed elsewhere in this book, curl may be built with several
different name resolving backends. One of those backends is powered by the
c-ares library and when curl is built to use c-ares, it gets a few extra
superpowers that curl built to use other name resolve backends do not get.
Namely, it gains the ability to more specifically instruct what DNS servers to
use and how that DNS traffic is using the network.

With `--dns-servers`, you can specify exactly which DNS server curl should use
instead of the default one. This lets you run your own experimental server that
answers differently, or use a backup one if your regular one is unreliable or dead.

With `--dns-ipv4-addr` and `--dns-ipv6-addr` you ask curl to "bind" its local
end of the DNS communication to a specific IP address and with
`--dns-interface` you can instruct curl to use a specific network interface to
use for its DNS requests.

These `--dns-*` options are advanced and are only meant for people who know
what they are doing and understand what these options do. But they offer
customizable DNS name resolution operations.

