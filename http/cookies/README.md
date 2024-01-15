# Cookies

HTTP cookies are key/value pairs that a client stores on the behalf of a
server. They are sent back in subsequent requests to
allow clients to keep state between requests. Remember that the HTTP protocol
itself has no state but instead the client has to resend all data in subsequent
requests that it wants the server to be aware of.

Cookies are set by the server with the `Set-Cookie:` header and with each
cookie the server sends a bunch of extra properties that need to match for the
client to send the cookie back. Like domain name and path and perhaps most
important for how long the cookie should live on.

The expiry of a cookie is either set to a fixed time in the future (or to live
a number of seconds) or it gets no expiry at all. A cookie without an expire
time is called a session cookie and is meant to live during the *session* but
not longer. A session in this aspect is typically thought to be the life time
of the browser used to view a site. When you close the browser, you end your
session. Doing HTTP operations with a command-line client that supports
cookies begs the question of when a session really ends…

## Cookie engine

The general concept of curl only doing the bare minimum unless you tell it
differently makes it not acknowledge cookies by default. You need to switch on
the cookie engine to make curl keep track of cookies it receives and then
subsequently send them out on requests that have matching cookies.

You enable the cookie engine by asking curl to read or write cookies. If you
tell curl to read cookies from blank named file, you only switch on the engine
but start off with an empty internal cookie store:

    curl -b "" http://example.com

Just switching on the cookie engine, getting a single resource and then
quitting would be pointless as curl would have no chance to actually send any
cookies it received. Assuming the site in this example would set cookies and
then do a redirect we would do:

    curl -L -b "" http://example.com

## Reading cookies from file

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

## Writing cookies to file

The place where cookies are stored is sometimes referred to as the cookie
jar. When you enable the cookie engine in curl and it has received cookies,
you can instruct curl to write down all its known cookies to a file, the
cookie jar, before it exits. It is important to remember that curl only
updates the output cookie jar on exit and not during its lifetime, no matter
how long the handling of the given input takes.

You point out the cookie jar output with `-c`:

    curl -c cookie-jar.txt http://example.com

`-c` is the instruction to *write* cookies to a file, `-b` is the instruction
to *read* cookies from a file. Oftentimes you want both.

When curl writes cookies to this file, it saves all known cookies including
those that are session cookies (without a given lifetime). curl itself has no
notion of a session and it does not know when a session ends so it does not
flush session cookies unless you tell it to.

## New cookie session

Instead of telling curl when a session ends, curl features an option that lets
the user decide when a new session *begins*.

A new cookie session means that all the old session cookies are be thrown
away. It is the equivalent of closing a browser and starting it up again.

Tell curl a new cookie session starts by using `-j, --junk-session-cookies`:

    curl -j -b cookies.txt http://example.com/

* [Cookie file format](fileformat.md)
