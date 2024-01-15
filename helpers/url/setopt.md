# CURLOPT\_CURLU

As a convenience to applications, they can pass in an already parsed URL to
libcurl to work with, as an alternative to `CURLOPT_URL`.

You pass in a `CURLU` handle instead of a URL string with the `CURLOPT_CURLU`
option.

Example:

    CURLU *h = curl_url();
    rc = curl_url_set(h, CURLUPART_URL, "https://example.com/", 0);

    CURL *easy = curl_easy_init();
    curl_easy_setopt(easy, CURLOPT_CURLU, h);
