# Include files

You include `<curl/curl.h>` in your code when you want to use the URL API.

    #include <curl/curl.h>

    CURLU *h = curl_url();
    rc = curl_url_set(h, CURLUPART_URL, "ftp://example.com/no/where", 0);
