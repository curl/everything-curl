# Redirect to URL

When the handle already has parsed a URL, setting a second relative URL makes
it "redirect" to adapt to it.

Example, first set the original URL then set the one we "redirect" to:

    CURLU *h = curl_url();
    rc = curl_url_set(h, CURLUPART_URL,
                      "https://example.com/foo/bar?name=moo", 0);

    rc = curl_url_set(h, CURLUPART_URL, "../test?another", 0);
