# Reading cookies from file

Starting off with a blank cookie store may not be desirable. Why not start off
with cookies you stored in a previous fetch or that you otherwise acquired?
The file format curl uses for cookies is called the Netscape cookie format
because it was once the file format used by browsers and then you could easily
tell curl to use the browser's cookies.

As a convenience, curl also supports a cookie file being a set of HTTP headers
that set cookies. It is an inferior format but may be the only thing you have.

Tell curl which file to read the initial cookies from:

    curl -L -b cookies.txt http://example.com

Remember that this only *reads* from the file. If the server would update the
cookies in its response, curl would update that cookie in its in-memory store
but then eventually throw them all away when it exits and a subsequent invocation
of the same input file would use the original cookie contents again.
