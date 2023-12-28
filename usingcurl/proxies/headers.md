# Proxy headers

When you want to add HTTP headers meant specifically for an HTTP or HTTPS
proxy, and not for the remote server, the `--header` option falls short.

For example, if you issue an HTTPS request through an HTTP proxy, it is done
by first issuing a `CONNECT` to the proxy that establishes a tunnel to the
remote server and then it sends the request to that server. That first
`CONNECT` is only issued to the proxy and you may want to make sure only that
receives your special header, and send another set of custom headers to the
remote server.

Set a specific different `User-Agent:` only to the proxy:

    curl --proxy-header "User-Agent: magic/3000" -x proxy https://example.com/
