# TLS backends

When curl is built, it gets told to use a specific TLS library. That TLS
library is the engine that provides curl with the powers to speak TLS over the
wire. We often refer to them as different "backends" as they can be seen as
different pluggable pieces into the curl machine. curl can be built to be able
to use one or more of these backends.

Sometimes features and behaviors differ slightly when curl is built with
different TLS backends, but the developers work hard on making those
differences as small and unnoticeable as possible.

Showing the curl version information with [curl --version](../../cmdline/curlver.md)
includes the TLS library and version in the first line of output.

## Multiple TLS backends

When curl is built with *multiple* TLS backends, it can be told which one to
use each time it is started. It is always built to use a specific one by
default unless one is asked for.

If you invoke `curl --version` for a curl with multiple backends it mentions
`MultiSSL` as a feature in the last line. The first line includes all the
supported TLS backends with the non-default ones within parentheses.

To set a specific one to get used, set the environment variable
`CURL_SSL_BACKEND` to its name.
