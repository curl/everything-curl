# Proxies

A proxy in a network context is a middle man, a server in between you as a
client and the remote server you want to communicate with. The client contacts
the middle man which then goes on to contact the remote server for you.

This style of proxy use is sometimes used by companies and organizations, in
which case you are usually required to use them to reach the target server.

There are several different kinds of proxies and different protocols to use
when communicating with a proxy, and libcurl supports a few of the most
common proxy protocols. It is important to realize that the protocol used to
the proxy is not necessarily the same protocol used to the remote server.

When setting up a transfer with libcurl you need to point out the server name
and port number of the proxy. You may find that your favorite browsers can do
this in slightly more advanced ways than libcurl can, and we get into such
details in later sections.

## Proxy types

libcurl supports the two major proxy types: SOCKS and HTTP proxies. More
specifically, it supports both SOCKS4 and SOCKS5 with or without remote name
lookup, as well as both HTTP and HTTPS to the local proxy.

The easiest way to specify which kind of proxy you are talking to is to set
the scheme part of the proxy hostname string (`CURLOPT_PROXY`) to match it:

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
names.

You can also opt to set the type of the proxy with a separate option if you
prefer to only set the hostname, using `CURLOPT_PROXYTYPE`. Similarly, you
can set the proxy port number to use with `CURLOPT_PROXYPORT`.

## Local or proxy name lookup

In a section above you can see that different proxy setups allow the name
resolving to be done by different parties involved in the transfer. You can in
several cases either have the client resolve the server hostname and pass on
the IP address to the proxy to connect to - which of course assumes that the
name lookup works accurately on the client system - or you can hand
over the name to the proxy to have the proxy resolve the name; converting it to
an IP address to connect to.

When you are using an HTTP or HTTPS proxy, you always give the name to
the proxy to resolve.

## Which proxy?

If your network connection requires the use of a proxy to reach the
destination, you must figure this out and tell libcurl to use the correct
proxy. There is no support in libcurl to make it automatically figure out or
detect a proxy.

When using a browser, it is popular to provide the proxy with a PAC script or
other means but none of those are recognized by libcurl.

### Proxy environment variables

If no proxy option has been set, libcurl checks for the existence of specially
named environment variables before it performs its transfer to see if a proxy
is requested to get used.

You can specify the proxy by setting a variable named `[scheme]_proxy` to hold
the proxy hostname (the same way you would specify the host with `-x`). If
you want to tell curl to use a proxy when accessing an HTTP server, you set
the `http_proxy` environment variable. Like this:

    http_proxy=http://proxy.example.com:80

The proxy example above is for HTTP, but can of course also set `ftp_proxy`,
`https_proxy`, and so on for the specific protocols you want to proxy. All
these proxy environment variable names except http_proxy can also be specified
in uppercase, like `HTTPS_PROXY`.

To set a single variable that controls *all* protocols, the `ALL_PROXY`
exists. If a specific protocol variable one exists, such a one takes
precedence.

When using environment variables to set a proxy, you could easily end up in a
situation where one or a few hostnames should be excluded from going through
the proxy. This can be done with the `NO_PROXY` variable - or the
corresponding `CURLOPT_NOPROXY` libcurl option. Set that to a comma-separated
list of hostnames that should not use a proxy when being accessed. You can set
NO_PROXY to be a single asterisk ('\*') to match all hosts.

## HTTP proxy

The HTTP protocol details exactly how an HTTP proxy should be used. Instead of
sending the request to the actual remote server, the client (libcurl) instead
asks the proxy for the specific resource. The connection to the HTTP proxy is
made using plain unencrypted HTTP.

If an HTTPS resource is requested, libcurl instead issues a `CONNECT` request
to the proxy. Such a request opens a tunnel through the proxy, where it passes
data through without understanding it. This way, libcurl can establish a
secure end-to-end TLS connection even when an HTTP proxy is present.

You *can* proxy non-HTTP protocols over an HTTP proxy, but since this is
mostly done by the CONNECT method to tunnel data through it requires that the
proxy is configured to allow the client to connect to those other particular
remote port numbers. Many HTTP proxies are setup to inhibit connections to
other port numbers than 80 and 443.

## HTTPS proxy

An HTTPS proxy is similar to an HTTP proxy but allows the client to connect to
it using a secure HTTPS connection. Since the proxy connection is separate
from the connection to the remote site even in this situation, as HTTPS to the
remote site is tunneled through the HTTPS connection to the proxy, libcurl
provides a whole set of TLS options for the proxy connection that are separate
from the connection to the remote host.

For example, `CURLOPT_PROXY_CAINFO` is the same functionality for the HTTPS
proxy as `CURLOPT_CAINFO` is for the remote
host. `CURLOPT_PROXY_SSL_VERIFYPEER` is the proxy version of
`CURLOPT_SSL_VERIFYPEER` and so on.

HTTPS proxies are still today fairly unusual in organizations and companies.

## Proxy authentication

Authentication with a proxy means that you need to provide valid credentials
in the handshake negotiation with the proxy itself. The proxy authentication
is then in addition to and separate of the possible authentication or lack of
authentication with the remote host.

libcurl supports authentication with HTTP, HTTPS and SOCKS5 proxies. The key
option is then `CURLOPT_PROXYUSERPWD` which sets the username and password to
use - unless you set it within the `CURLOPT_PROXY` string.

## HTTP Proxy headers

With an HTTP or HTTP proxy, libcurl issues a request to the proxy that
includes a set of headers. An application can of course modify the headers,
just like for requests sent to servers.

libcurl offers the `CURLOPT_PROXYHEADER` for controlling the headers that are
sent to a proxy **when there is a separate request sent to the server**. This
typically means the initial `CONNECT` request sent to a proxy for setting up a
tunnel through the proxy.
