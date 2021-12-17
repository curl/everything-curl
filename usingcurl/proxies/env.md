# Proxy environment variables

curl checks for the existence of specially named environment variables before
it runs to see if a proxy is requested to get used.

You specify the proxy by setting a variable named `[scheme]_proxy` to hold the
proxy host name (the same way you would specify the host with `-x`). So if you
want to tell curl to use a proxy when access a HTTP server, you set the
'http_proxy' environment variable. Like this:

    http_proxy=http://proxy.example.com:80
    curl -v www.example.com

While the above example shows HTTP, you can, of course, also set ftp_proxy,
https_proxy, and so on. All these proxy environment variable names except
http_proxy can also be specified in uppercase, like HTTPS_PROXY.

To set a single variable that controls *all* protocols, the ALL_PROXY exists.
If a specific protocol variable one exists, such a one will take precedence.

When using environment variables to set a proxy, you could easily end up in a
situation where one or a few host names should be excluded from going through
the proxy. This is then done with the NO_PROXY variable. Set that to a comma-
separated list of host names that should not use a proxy when being
accessed. You can set NO_PROXY to be a single asterisk ('\*') to match all
hosts.

As an alternative to the NO_PROXY variable, there is also a `--noproxy` command
line option that serves the same purpose and works the same way.

## `http_proxy` in lower case only

The HTTP version of the proxy environment variables is treated differently
than the others. It is only accepted in its lower case version because of the
CGI protocol, which lets users run scripts in a server when invoked by an HTTP
server. When a CGI script is invoked by a server, it automatically creates
environment variables for the script based on the incoming headers in the
request. Those environment variables are prefixed with uppercase `HTTP_`!

An incoming request to a HTTP server using a request header like `Proxy: yada`
will therefore create the environment variable `HTTP_PROXY` set to contain
`yada` before the CGI script is started. If that CGI script runs curl…

Accepting the upper case version of this environment variable has been the
source for many security problems in lots of software through times.

