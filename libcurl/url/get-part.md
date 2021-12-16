# Get individual URL parts

When a URL has been parsed or individual parts have been set in the `CURLU`
handle, you can extract those pieces again from the handle at any time.

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

Remember to free the returned string with `curl_free` when you are done with
it!

Extracted parts are not URL decoded unless the user asks for it with the
`CURLU_URLDECODE` flag.
