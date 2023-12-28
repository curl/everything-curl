# HTTPS proxy

All the other mentioned protocols to speak with the proxy are clear text
protocols, HTTP and the SOCKS versions. Using those methods could allow
someone to eavesdrop on your traffic the local network where you or the proxy
reside. Because over the connection between curl and the proxy, the data is
sent in the clear.

One solution for that is to use an HTTPS proxy, speaking HTTPS to the proxy,
which then establishes a secure and encrypted connection that is safe from
easy surveillance.

When an HTTPS proxy is specified, the default port used on that host is 443.

In most other ways, HTTPS proxies work like [HTTP proxies](http.md).

## HTTP/2

When curl speaks with an HTTPS proxy, you have the option to use
`--proxy-http2` to a ask curl to try using HTTP/2 with the proxy.

By default, curl speaks HTTP/1.1 with HTTPS proxies, but if this option is
used curl attempts to negotiate and use HTTP/2 instead.
