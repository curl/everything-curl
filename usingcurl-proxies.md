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

TBD

### Non-HTTP protocols over HTTP proxy

TBD

### SOCKS

socks types

TBD

### Proxy authentication

TBD

### HTTPS and proxy

TBD

### HTTPS to proxy

TBD
