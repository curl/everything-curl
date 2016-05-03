## Cookies with libcurl

By default and by design, libcurl makes transfers as basic as possible and
features need to be enabled to get used. One such feature is HTTP cookies,
more known as just plain and simply "cookies".

Cookies are name/value pair sent by the server (using a `Set-Cookie:` header)
to be stored in the client, and are then supposed to get sent back again in
requests that matches the host and path requirements that were set together
with the cookie when it came from the server (using the `Cookie:` header). On
the modern web of today, sites are known to sometimes use very large amounts
of cookies.

### Cookie engine

When you enable the "cookie engine" for a specific easy handle, it means that
it will record incoming cookies, store them in the in-memory "cookie store"
that is associated with the easy handle and subsequently send the proper ones
back if an HTTP request is made that matches.

There are two ways to switch on the cookie engine:

1. Ask libcurl to import cookies into the easy handle from a given file name
with the `CURLOPT_COOKIEFILE` option:

    curl_easy_setopt(easy, CURLOPT_COOKIEFILE, "cookies.txt");

A common trick is to just specify a non-existing file name or plain "" to have
it just activate the cookie engine with a blank cookie store to start with.

This option can be set multiple times and then each of the given files will be
read.

2. Ask for received cookies to get stored in a file with the
`CURLOPT_COOKIEJAR` option:

    curl_easy_setopt(easy, CURLOPT_COOKIEJAR, "cookies.txt");

when the easy handle is closed later with `curl_easy_cleanup()`, all known
cookies will be written to the given file. The file format is the well-known
"netscape cookie file" format that browsers also once used.

### Setting custom cookies

A simpler and more direct way to just pass on a set of specific cookies in a
request, that doesn't add any cookies to the cookie store and doesn't even
activate the cookie engine, is to set the set with `CURLOPT_COOKIE:':

    curl_easy_setopt(easy, CURLOPT_COOKIE, "name=daniel; present=yes;");

The string you set there is the raw string that is sent in the HTTP request
and should be in the format of repeated sequences of `NAME=VALUE;` - including
the semicolon separator.

### Import Export

TBD

### Cookie file format

TBD

