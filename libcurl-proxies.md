# Proxies

A proxy in a network context is a sort of middle man, a server in between you
as a client and the remote server you want to communicate with. The client
contacts the middle man which then goes on to contact the remote server for
you.

This sort of proxy use is sometimes used by companies and organizations, in
which case you are usually required to use them to reach the target server.

There are several different kinds of proxies and different protocols to use
when communicating with a proxy, and libcurl supports a few of the most
common proxy protocols. It is important to realize that the protocol used to
the proxy isn't necessarily the same protocol used to the remote server.

When setting up a transfer with libcurl you need to point out the server name
and port number of the proxy. You may find that your favorite browsers can do
this in slightly more advanced ways than libcurl can, and we will get into
such details in later sections.

## Proxy types

libcurl supports the two major proxy types: SOCKS and HTTP proxies. More
specifically, it supports both SOCKS4 and SOCKS5 with or without remote name
lookup, as well as both HTTP and HTTPS to the local proxy.

The easiest way to specify which kind of proxy you are talking to is to set
the scheme part of the proxy host name string (`CURLOPT_PROXY`) to match it:

    socks4://proxy.example.com:12345/
    socks4a://proxy.example.com:12345/
    socks5://proxy.example.com:12345/
    socks5h://proxy.example.com:12345/
    http://proxy.example.com:12345/
    https://proxy.example.com:12345/

`socks4` - means SOCKS4 with local name resolving

`socks4a` - means SOCKS4 with proxy's name resolving

`socks5` - means SOCKS5 with local name resolving

`socks5h` - means SOCKS5 with proxy's name resolving

`http` - means HTTP, which always lets the proxy resolve names

`https` - means HTTPS **to the proxy**, which always lets the proxy resolve
names (Note that HTTPS proxy support was added recently, in curl 7.52.0, and
it still only works with a subset of the TLS libraries: OpenSSL, GnuTLS and
NSS.)

You can also opt to set the type of the proxy with a separate option if you
prefer to only set the host name, using `CURLOPT_PROXYTYPE`. Similarly, you
can set the proxy port number to use with `CURLOPT_PROXYPORT`.

## Local or proxy name lookup

In a section above you can see that different proxy setups allow the name
resolving to be done by different parties involved in the transfer. You can in
several cases either have the client resolve the server host name and pass on
the IP address to the proxy to connect to - which of course assumes that the
name lookup works accurately on the client system - or you can hand
over the name to the proxy to have the proxy resolve the name; converting it to
an IP address to connect to.

When you are using an HTTP or HTTPS proxy, you always give the name to
the proxy to resolve.

## Which proxy?

TBD

## Using proxies for various protocols

TBD

## HTTP proxy

TBD

## HTTPS proxy

TBD

## Proxy authentication

TBD
