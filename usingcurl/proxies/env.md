# Proxy environment variables

curl checks for the existence of specially named environment variables before
it runs to see if a proxy is requested to get used.

You specify the proxy by setting a variable named `[scheme]_proxy` to hold the
proxy hostname (the same way you would specify the host with `-x`). If you
want to tell curl to use a proxy when access an HTTP server, you set the
`http_proxy` environment variable. Like this:

    http_proxy=http://proxy.example.com:80
    curl -v www.example.com

While the above example shows HTTP, you can, of course, also set `ftp_proxy`,
`https_proxy`, and so on. All these proxy environment variable names except
`http_proxy` can also be specified in uppercase, like `HTTPS_PROXY`.

To set a single variable that controls *all* protocols, the `ALL_PROXY`
exists. If a specific protocol variable one exists, such a one takes
precedence.

## No proxy

You sometimes end up in a situation where one or a few hostnames should be
excluded from going through the proxy that normally would be used. This is
then done with the `NO_PROXY` variable. Set that to a comma- separated list of
hostnames that should not use a proxy when being accessed. You can set
`NO_PROXY` to be a single asterisk ('\*') to match all hosts.

If a name in the exclusion list starts with a dot (`.`), then the name matches
that entire domain. For example `.example.com` matches both `www.example.com`
and `home.example.com` but not `nonexample.com`.

As an alternative to the `NO_PROXY` variable, there is also a `--noproxy`
command line option that serves the same purpose and works the same way.

Since curl 7.86.0, a user can exclude an IP network using the CIDR notation:
append a slash and number of bits to an IP address to specify the bit size of
the network to match. For example, match the entire 16 bit network starting
with `192.168` by providing the pattern `192.168.0.0/16`.

## `http_proxy` in lower case only

The HTTP version of the proxy environment variables is treated differently
than the others. It is only accepted in its lower case version because of the
CGI protocol, which lets users run scripts in a server when invoked by an HTTP
server. When a CGI script is invoked by a server, it automatically creates
environment variables for the script based on the incoming headers in the
request. Those environment variables are prefixed with uppercase `HTTP_`.

An incoming request to an HTTP server using a request header like `Proxy:
yada` therefore creates the environment variable `HTTP_PROXY` set to contain
`yada` before the CGI script is started. If such a CGI script runs curl, it is
important that curl does not treat that as a proxy to use.

Accepting the upper case version of this environment variable has been the
source for many security problems in lots of software through times.

