# User-agent

The User-Agent is a header that each client can set in the request to inform
the server which user-agent it is. Sometimes servers look at this header and
determine how to act based on its contents.

The default header value is 'curl/[version]', as in `User-Agent: curl/7.54.1`
for curl version 7.54.1.

You can set any value you like, using the option `-A` or `--user-agent` plus
the string to use or, as it is just a header, `-H "User-Agent: foobar/2000"`.

As comparison, a test version of Firefox on a Linux machine once sent this
User-Agent header:

`User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:58.0) Gecko/20100101 Firefox/58.0`
