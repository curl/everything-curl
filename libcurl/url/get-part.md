# Get individual URL parts

The `CURLU` handle stores the individual parts of a URL and the application
can extract those pieces individually from the handle at any time. If they are
set.

The second argument to `curl_url_get()` specifies which part you want
extracted. They are all extracted as null-terminated `char *` data, so you
pass a pointer to such a variable.

    char *host;
    rc = curl_url_get(h, CURLUPART_HOST, &host, 0);
    
    char *scheme;
    rc = curl_url_get(h, CURLUPART_SCHEME, &scheme, 0);
    
    char *user;
    rc = curl_url_get(h, CURLUPART_USER, &user, 0);
    
    char *password;
    rc = curl_url_get(h, CURLUPART_PASSWORD, &password, 0);
    
    char *port;
    rc = curl_url_get(h, CURLUPART_PORT, &port, 0);
    
    char *path;
    rc = curl_url_get(h, CURLUPART_PATH, &path, 0);
    
    char *query;
    rc = curl_url_get(h, CURLUPART_QUERY, &query, 0);
    
    char *fragment;
    rc = curl_url_get(h, CURLUPART_FRAGMENT, &fragment, 0);

    char *zoneid;
    rc = curl_url_get(h, CURLUPART_ZONEID, &zoneid, 0);

Remember to free the returned string with `curl_free` when you are done with
it!

Extracted parts are not URL decoded unless the user asks for it with the
`CURLU_URLDECODE` flag.

## URL parts

The different parts are named from their roles in the URL. Imagine a URL that
looks like this:

    http://joe:7Hbz@example.com:8080/images?id=5445#footer

When this URL is parsed by curl, it will store the different components like
this:

| text          | part                 |
|---------------|----------------------|
| `http`        | `CURLUPART_SCHEME`   |
| `joe`         | `CURLUPART_USER`     |
| `7Hbz`        | `CURLUPART_PASSWORD` |
| `example.com` | `CURLUPART_HOST`     |
| `8080`        | `CURLUPART_PORT `    |
| `/images`     | `CURLUPART_PATH`     |
| `id=5445`     | `CURLUPART_QUERY`    |
| `footer`      | `CURLUPART_FRAGMENT` |

## Zone ID

The one thing that might stick out a little is the Zone id. It is an extra
qualifier that can be used for IPv6 numerical addresses, and only for such
addresses. It is used like this, where it is set to `eth0`:

    http://[2a04:4e42:e00::347%25eth0]/

For this URL, curl extracts:

| text                 | part               |
|----------------------|--------------------|
| `http`               | `CURLUPART_SCHEME` |
| `2a04:4e42:e00::347` | `CURLUPART_HOST`   |
| `eth0`               | `CURLUPART_ZONEID` |
| `/`                  | `CURLUPART_PATH`   |

... and asking for any other component will then return non-zero as they are
missing.

# Flags

When retrieving a URL part using this function, the API offers a few different
toggles to better specify exactly how that content should be returned. They
are set in the `flags` bitmask parameter, which is the function's fourth
argument. You can set zero, one or more bits.

- `CURLU_DEFAULT_PORT`. If the handle has no port number stored, this option
will make `curl_url_get()` return the default port number for the used scheme.

- `CURLU_DEFAULT_SCHEME`. If the handle has no scheme stored, this option will
make `curl_url_get()` return the default scheme instead of error.

- `CURLU_NO_DEFAULT_PORT`. Instructs `curl_url_get()` to not return a port
number if it matches the default port for the scheme.

- `CURLU_URLDECODE`. Tells `curl_url_get()` to URL decode the contents before
returning it. It will not attempt to decode the scheme, the port number or the
full URL.  The query component will also get plus-to-space conversion as a
bonus when this bit is set. Note that this URL decoding is charset unaware and
you will get a zero terminated string back with data that could be intended
for a particular encoding. If there are any byte values lower than 32 in the
decoded string, the get operation will return an error instead.

- `CURLU_URLENCODE`. If set, will make `curl_url_get()` URL encode the host
name part when a full URL is retrieved. If not set (default), libcurl returns
the URL with the host name "raw" to support IDN names to appear as-is. IDN
host names are typically using non-ASCII bytes that otherwise will be
percent-encoded. Note that even when not asking for URL encoding, the '%'
character (byte 37) will be URL encoded to make sure the host name remains
valid.

- `CURLU_PUNYCODE`. If set and `CURLU_URLENCODE` is not set, and asked to
retrieve the `CURLUPART_HOST` or `CURLUPART_URL` parts, libcurl returns the
host name in its punycode version if it contains any non-ASCII octets (and is
an IDN name). If libcurl is built without IDN capabilities, using this bit
will make `curl_url_get()` return `CURLUE_LACKS_IDN` if the host name contains
anything outside the ASCII range.
