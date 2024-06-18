# New cookie session

A cookie as set by the server can be a *session cookie*, that is meant to be
kept around only for as long as the *session* lasts. curl has no idea how long
a session is or when it ends.

Instead of telling curl when a session ends, curl features an option that lets
the user decide when a new session *begins*.

A new cookie session means that all the old session cookies are be thrown
away. It is the equivalent of closing a browser and starting it up again.

Tell curl a new cookie session starts by using `-j, --junk-session-cookies`:

    curl -j -b cookies.txt http://example.com/
