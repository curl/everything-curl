# Set individual URL parts

The API allows the application to set individual parts of a URL held in the
`CURLU` handle, either after having parsed a full URL or instead of parsing
such.

    rc = curl_url_set(urlp, CURLUPART_HOST, "www.example.com", 0);
    rc = curl_url_set(urlp, CURLUPART_SCHEME, "https", 0);
    rc = curl_url_set(urlp, CURLUPART_USER, "john", 0);
    rc = curl_url_set(urlp, CURLUPART_PASSWORD, "doe", 0);
    rc = curl_url_set(urlp, CURLUPART_PORT, "443", 0);
    rc = curl_url_set(urlp, CURLUPART_PATH, "/index.html", 0);
    rc = curl_url_set(urlp, CURLUPART_QUERY, "name=john", 0);
    rc = curl_url_set(urlp, CURLUPART_FRAGMENT, "anchor", 0);

The API always expects a null-terminated `char *` string in the third
argument, or NULL to clear the field. Note that the port number is also
provided as a string this way.

Set parts are not URL encoded unless the user asks for it with the
`CURLU_URLENCODE` flag in the forth argument.
