# Proxy authentication

HTTP and SOCKS proxies can require authentication, so curl then needs to
provide the proper credentials to the proxy to be allowed to use it, and
failing to do will only make the proxy return HTTP responses using code 407.

Authentication for proxies is similar to "normal" HTTP authentication. It is
separate from the server authentication to allow clients to independently use
both normal host authentication as well as proxy authentication.

With curl, you set the user name and password for the proxy authentication
with the `-U user:password` or `--proxy-user user:password` option:

    curl -U daniel:secr3t -x myproxy:80 http://example.com

This example will default to using the Basic authentication scheme. Some
proxies will require another authentication scheme (and the headers that are
returned when you get a 407 response will tell you which) and then you can ask
for a specific method with `--proxy-digest`, `--proxy-negotiate`,
`--proxy-ntlm`. The above example command again, but asking for NTLM auth with
the proxy:

    curl -U daniel:secr3t -x myproxy:80 http://example.com --proxy-ntlm

There is also the option that asks curl to figure out which method the proxy
wants and supports and then go with that (with the possible expense of extra
roundtrips) using `--proxy-anyauth`. Asking curl to use any method the proxy
wants is then like this:

    curl -U daniel:secr3t -x myproxy:80 http://example.com --proxy-anyauth

