# Connections

Most of the protocols you use with curl speaks TCP. With TCP, a client such as
curl must first figure out the IP address(es) of the host you want to
communicate with, then connect to it. "Connecting to it" means performing a
TCP protocol handshake.

For your typical command line that operates on a URL those are details that
are taken care of under the hood and you can mostly ignore them. But at times
you might find yourself wanting to tweak the specifics...

## Name resolve tricks

### Edit the hosts file

Maybe you have your command line `curl http://example.com` and just want that
to instead connect to your local server instead of the actual live server.

You can normally and easily do that by editing your `hosts` file (`/etc/hosts`
on linux and unix systems) and adding for example `127.0.0.1 example.com` to
redirect the host to your localhost. But this edit requires admin access, it
has the downside that it affects all other applications at the same time and
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
HTTPS there's a separate extention field in the TLS protocol called SNI
(Server Name Indication) that lets the client tell the server the name of the
server it wants to talk to. curl will only extract the SNI name to send, from
the given URL.

### Provide a custom IP for a name

Doing virtually the hosts edit operation but directly with the curl command
line without having to edit any system files, you can force feed curl what IP
address it should use for a given name. You know better than the name resolver
where curl should go? Then you can! If you want to redirect the plain port 80
access for `example.com` to instead reach your localhost:

    curl --resolve example.com:80:127.0.0.1 http://example.com/

You can even specify multiple `--resolve` switches to provide multiple
redirects of this sort, which can be handy if the URL you work with uses HTTP
redirects or if you just want to have your command line work with multiple
URLs.

`--resolve` inserts the address into curl's DNS cache, so it will effectively
make curl believe that's the address it got when it resolved the name.

When talking HTTPS, this will send SNI for the name in the URL and curl will
verify the server to make sure it serves for the name in the URL...

### Provide a replacement name

As a close relative to the `--resolve` option, the `--connect-to` option
provides a minor variation. It allows you to specify a replacement name and
port number for curl to use under the hood when a specific name and port
number is used to connect to.

For example, if you have a single site called `www.example.com` that in turn
is actually served by three different individual HTTP servers: load1, load2
and load3 for load balancing purposes. In a typical normal procedure curl
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

--dns-*

TBD

## Connection timeouts

TBD

## Specify network interface

TBD

## Local port number

--local-port

TBD

## Keep alive

TBD

## SSH and TLS connections

TBD
