# TLS back-ends

When curl is built, it gets told to use a specific TLS library. That TLS
library is the engine that provides curl with the powers to speak TLS over the
wire. We often refer to them as different "back-ends" as they can be seen as
different pluggable pieces into the curl machine. curl can be built to be able
to use one or more of these back-ends.

Sometimes features and behaviors differ slightly when curl is built with
different TLS back-ends, but the developers work hard on making those
differences as small and unnoticeable as possible.

Showing the curl version information with [curl --version](../version.md) will
always include the TLS library and version in the first line of output.

## Multiple TLS back-ends

When curl is built with *multiple* TLS back-ends, it can be told which one to
use each time it is started. It is always built to use a specific one by
default unless one is asked for.

If you invoke `curl --version` for a curl with multiple back-ends it will
mention `MultiSSL` as a feature in the last line. The first line will then
include all the supported TLS back-ends with the non-default ones within
parentheses.

To set a specific one to get used, set the environment variable
`CURL_SSL_BACKEND` to its name.
