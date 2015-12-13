## Proxies

A proxy is a machine or software that does something on behalf of you, the
client.

We can also see it as a middle man that sits between you and the server you
want to work with. A middle man that you connect to instead of the actual
remote server and ask the proxy to perform your desired operation and then
it'll run off and do that and then return back the data to you.

There are several different types of proxies and we shall list and discuss
them further down in this section.

### Discover your proxy

Some networks are setup to require a proxy in order for you to reach the
Internet or perhaps that special network you're interested in. The use of
proxies are introduced on your network by the people and management that run
your network for policy or technical reasons.

In the networking space there are a few ways for automatic detection of
proxies and how to connect to them, but neither of those methods are truly
univeral and curl supports none of them. Further, when you communicate to the
outside world through a proxy that often means that you have to put a lot of
trust on the proxy as it will be able to see and modify all the non-secure
network traffic you send or get through it. That trust is not easy to assume
automatically.

If you check your browser's network settings, sometimes under an advanced
settings tab, you can learn what proxy or proxies your browser is configured
to use. Chances are very big that you should use the same one or ones when you
fire off your curl commanda lines.

TBD: screenshots of how to find proxy in Firefox and Chrome?

### PAC

Some network environment provides several different proxies that should be
used in different situations, and a very customizable way to handle that is
supported by the browsers. This is called "proxy auto-config", or PAC.

A PAC file contains a javascript functions that deems which proxy a given
network connection should use, or even if it should not use a proxy. Browsers
most typically read the PAC file off a URL on the local network.

Since curl has no javascript capabilities, curl doesn't support PAC files. If
your browser and network use PAC files, the easiest route forward is usually
to read the PAC file manually and figure out the proxy you need to specify to
run your curl command line successfully.

### Captive portals

(these aren't proxies but in the way)

TBD

### HTTP

A HTTP proxy is a proxy that the client speaks HTTP with to get the things
done. curl will by default assume that a host you point out with `-x` is a
HTTP proxy, and unless you also specify a port number it will default to port
3128 (and the reason for that particular port number is purely historical).

If you want to request the example.com web page using a proxy on 192.168.0.1
port 8080, a command line could look like:

    curl -x 192.168.0.1:8080 http:/example.com/

Recall that the proxy is receiving your request, forwards it to the real
server, then reads the response from the server and then hand that back to the
client.

If you enable verbose mode with `-v` when talking to a proxy, you will see
that curl connects to the proxy instead of the remote server, and you will see
that it uses a slightly different request line.

### HTTPS and proxy

HTTPS was designed to allow and provide secure and safe end to end privacy
from the client to the server (and back). In order to provide that when
speaking to a HTTP proxy, the HTTP protocol has a special request that curl
uses to setup tunnel through the proxy that it then can encrypt and
verify. This HTTP method is known as `CONNECT`.

When the proxy tunnels through encrypted data to the remote server after a
CONNECT method set it up, the proxy cannot see nor modify the traffic without
breaking it.

### mitm-proxies

TBD

### Non-HTTP protocols over HTTP proxy

TBD

### SOCKS

socks types

TBD

### Transparent proxies

TBD

### Proxy authentication

TBD

### HTTPS to proxy

TBD
