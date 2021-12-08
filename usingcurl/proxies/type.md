# Proxy type

curl supports several different types of proxies.

The default proxy type is HTTP so if you specify a proxy host name (or IP
address) without a scheme part (the part that is often written as "http://")
curl goes with assuming it's an HTTP proxy.

curl provides a number of options to set the proxy type instead of using the
scheme prefix. See the [SOCKS](socks.md) section.
