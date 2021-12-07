## HTTPS proxy

All the other mentioned protocols to speak with the proxy are clear text
protocols, HTTP and the SOCKS versions. Using those methods could allow
someone to eavesdrop on your traffic the local network where you or the proxy
reside. Because over the connection between curl and the proxy, the data is
sent in the clear.

One solution for that is to use a HTTPS proxy, speaking HTTPS to the proxy,
which then establishes a secure and encrypted connection that is safe from
easy surveillance.

When an HTTPS proxy is specified, the default port used on that host will be
443.

In all other ways, HTTPS proxies work like [HTTP proxies](http.md).
