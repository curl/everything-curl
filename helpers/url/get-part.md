# Get URL parts

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

When this URL is parsed by curl, it stores the different components like this:

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

Asking for any other component returns non-zero as they are missing.
