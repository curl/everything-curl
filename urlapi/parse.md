# Parse a URL

You parse a full URL by *setting* the `CURLUPART_URL` part in the handle:

    CURLU *h = curl_url();
    rc = curl_url_set(h, CURLUPART_URL,
                      "https://example.com:449/foo/bar?name=moo", 0);

If successful, `rc` contains `CURLUE_OK` and the different URL components are
held in the handle. It means that the URL was valid as far as libcurl
concerns.

The function call's forth argument is a bitmask. Set none, one or more bits in
that to alter the parser's behavior:

## `CURLU_NON_SUPPORT_SCHEME`

Makes `curl_url_set()` accept a non-supported scheme. If not set, the only
acceptable schemes are for the protocols libcurl knows and have built-in
support for.

## `CURLU_URLENCODE`

Makes the function URL encode the path part if any bytes in it would benefit
from that: like spaces or "control characters".

## `CURLU_DEFAULT_SCHEME`

If the passed in string does not use a scheme, assume that the default one was
intended. The default scheme is HTTPS. If this is not set, a URL without a
scheme part is not accepted as valid. Overrides the `CURLU_GUESS_SCHEME`
option if both are set.

## `CURLU_GUESS_SCHEME`

Makes libcurl allow the URL to be set without a scheme and it instead
"guesses" which scheme that was intended based on the hostname. If the
outermost sub-domain name matches DICT, FTP, IMAP, LDAP, POP3 or SMTP then
that scheme is used, otherwise it picks HTTP. Conflicts with the
`CURLU_DEFAULT_SCHEME` option which takes precedence if both are set.

## `CURLU_NO_AUTHORITY`

Skips authority checks. The RFC allows individual schemes to omit the host
part (normally the only mandatory part of the authority), but libcurl cannot
know whether this is permitted for custom schemes. Specifying the flag permits
empty authority sections, similar to how the file scheme is handled. Really
only usable in combination with `CURLU_NON_SUPPORT_SCHEME`.

## `CURLU_PATH_AS_IS`

Makes libcurl skip the normalization of the path. That is the procedure where
curl otherwise removes sequences of dot-slash and dot-dot etc. The same option
used for transfers is called `CURLOPT_PATH_AS_IS`.

## `CURLU_ALLOW_SPACE`

Makes the URL parser allow space (ASCII 32) where possible. The URL syntax
does normally not allow spaces anywhere, but they should be encoded as `%20`
or `+`. When spaces are allowed, they are still not allowed in the
scheme. When space is used and allowed in a URL, it is stored as-is unless
`CURLU_URLENCODE` is also set, which then makes libcurl URL-encode the space
before stored. This affects how the URL is constructed when `curl_url_get()`
is subsequently used to extract the full URL or individual parts.
