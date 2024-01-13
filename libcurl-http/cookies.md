# Cookies

By default and by design, libcurl makes transfers as basic as possible and
features need to be enabled to get used. One such feature is HTTP cookies,
more known as just plain and simply cookies.

Cookies are name/value pairs sent by the server (using a `Set-Cookie:` header)
to be stored in the client, and are then supposed to get sent back again in
requests that matches the host and path requirements that were specified along
with the cookie when it came from the server (using the `Cookie:` header). On
the modern web of today, sites are known to sometimes use large numbers
of cookies.

## Cookie engine

When you enable the cookie engine for a specific easy handle, it means that it
records incoming cookies, stores them in the in-memory cookie store that is
associated with the easy handle and subsequently sends the proper ones back if
an HTTP request is made that matches.

There are two ways to switch on the cookie engine:

### Enable cookie engine with reading

Ask libcurl to import cookies into the easy handle from a given filename with
the `CURLOPT_COOKIEFILE` option:

    curl_easy_setopt(easy, CURLOPT_COOKIEFILE, "cookies.txt");

A common trick is to just specify a non-existing filename or plain `""` to
have it just activate the cookie engine with a blank cookie store to start
with.

This option can be set multiple times and then each of the given files are
read.

### Enable cookie engine with writing

Ask for received cookies to get stored in a file with the `CURLOPT_COOKIEJAR`
option:

    curl_easy_setopt(easy, CURLOPT_COOKIEJAR, "cookies.txt");

when the easy handle is closed later with `curl_easy_cleanup()`, all known
cookies are stored in the given file. The file format is the well-known
Netscape cookie file format that browsers also once used.

## Setting custom cookies

A simpler and more direct way to just pass on a set of specific cookies in a
request that does not add any cookies to the cookie store and does not even
activate the cookie engine, is to set the set with `CURLOPT_COOKIE`:

    curl_easy_setopt(easy, CURLOPT_COOKIE, "name=daniel; present=yes;");

The string you set there is the raw string that would be sent in the HTTP request
and should be in the format of repeated sequences of `NAME=VALUE;` - including
the semicolon separator.

## Import export

The cookie in-memory store can hold a bunch of cookies, and libcurl offers
very powerful ways for an application to play with them. You can set new
cookies, you can replace an existing cookie and you can extract existing
cookies.

### Add a cookie to the cookie store

Add a new cookie to the cookie store by simply passing it into curl with
`CURLOPT_COOKIELIST` with a new cookie. The format of the input is a single
line in the cookie file format, or formatted as a `Set-Cookie:` response
header, but we recommend the cookie file style:

    #define SEP  "\t"  /* Tab separates the fields */

    char *my_cookie =
      "example.com"    /* Hostname */
      SEP "FALSE"      /* Include subdomains */
      SEP "/"          /* Path */
      SEP "FALSE"      /* Secure */
      SEP "0"          /* Expiry in epoch time format. 0 == Session */
      SEP "foo"        /* Name */
      SEP "bar";       /* Value */

    curl_easy_setopt(curl, CURLOPT_COOKIELIST, my_cookie);

If that given cookie would match an already existing cookie (with the same
domain and path, etc.), it would overwrite the old one with the new contents.

### Get all cookies from the cookie store

Sometimes writing the cookie file when you close the handle is not enough and
then your application can opt to extract all the currently known cookies from
the store like this:

    struct curl_slist *cookies
    curl_easy_getinfo(easy, CURLINFO_COOKIELIST, &cookies);

This returns a pointer to a linked list of cookies, and each cookie is (again)
specified as a single line of the cookie file format. The list is allocated
for you, so do not forget to call `curl_slist_free_all` when the application
is done with the information.

### Cookie store commands

If setting and extracting cookies is not enough, you can also interfere with
the cookie store in more ways:

Wipe the entire in-memory storage clean with:

    curl_easy_setopt(curl, CURLOPT_COOKIELIST, "ALL");

Erase all session cookies (cookies without expiry date) from memory:

    curl_easy_setopt(curl, CURLOPT_COOKIELIST, "SESS");

Force a write of all cookies to the filename previously specified with
`CURLOPT_COOKIEJAR`:

    curl_easy_setopt(curl, CURLOPT_COOKIELIST, "FLUSH");

Force a reload of cookies from the filename previously specified with
`CURLOPT_COOKIEFILE`:

    curl_easy_setopt(curl, CURLOPT_COOKIELIST, "RELOAD");

## Cookie file format

The cookie file format is text based and stores one cookie per line. Lines
that start with `#` are treated as comments.

Each line that each specifies a single cookie consists of seven text fields
separated with TAB characters.

| Field | Example     | Meaning                                       |
|-------|-------------|-----------------------------------------------|
| 0     | example.com | Domain name                                   |
| 1     | FALSE       | Include subdomains boolean                    |
| 2     | /foobar/    | Path                                          |
| 3     | FALSE       | Set over a secure transport                   |
| 4     | 1462299217  | Expires at – seconds since Jan 1st 1970, or 0 |
| 5     | person      | Name of the cookie                            |
| 6     | daniel      | Value of the cookie                           |

