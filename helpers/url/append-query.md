# Append to the query

An application can append a string to the right end of the existing query part
with the `CURLU_APPENDQUERY` flag.

Consider a handle that holds the URL `https://example.com/?shoes=2`. An
application can then add the string `hat=1` to the query part like this:

    rc = curl_url_set(urlp, CURLUPART_QUERY, "hat=1", CURLU_APPENDQUERY);

It even notices the lack of an ampersand (`&`) separator so it injects one
too, and the handle's full URL would then equal
`https://example.com/?shoes=2&hat=1`.

The appended string can of course also get URL encoded on add, and if asked,
the encoding skips the `=` character. For example, append `candy=M&M` to what
we already have, and URL encode it to deal with the ampersand in the data:

    rc = curl_url_set(urlp, CURLUPART_QUERY, "candy=M&M",
                      CURLU_APPENDQUERY | CURLU_URLENCODE);

Now the URL looks like `https://example.com/?shoes=2&hat=1&candy=M%26M`.
