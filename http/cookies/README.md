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

 * [Cookie engine](engine.md)
 * [Reading cookies from file](reading.md)
 * [Writing cookies to file](writing.md)
 * [New cookie session](newsession.md)
 * [Cookie file format](fileformat.md)
