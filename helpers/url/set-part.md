# Set URL parts

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
    rc = curl_url_set(urlp, CURLUPART_ZONEID, "25", 0);

The API always expects a null-terminated `char *` string in the third
argument, or NULL to clear the field. Note that the port number is also
provided as a string this way.

Set parts are not URL encoded unless the user asks for it with the
`CURLU_URLENCODE` flag in the forth argument.

## Update parts

By setting an individual part, you can for example first set a full URL, then
update a single component of that URL and then extract the updated version of
that URL.

For example, let's say we have this URL

    const char *url="http://joe:7Hbz@example.com:8080/images?id=5445#footer";

and we want change the host in that URL to instead become `example.net`, it
could be done like this:

    CURLU *h = curl_url();
    rc = curl_url_set(h, CURLUPART_URL, url, 0);

Then change the hostname part:

    rc = curl_url_set(h, CURLUPART_HOST, "example.net", 0);

and this then now holds this URL:

    http://joe:7Hbz@example.net:8080/images?id=5445#footer

If you then continue and change the path part to `/foo` like this:

    rc = curl_url_set(h, CURLUPART_PATH, "/foo", 0);

and the URL handle now holds this URL:

    http://joe:7Hbz@example.net:8080/foo?id=5445#footer

etc...
