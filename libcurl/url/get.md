# Get a URL

The `CURLU *` handle represents a single URL and you can easily extract that
full URL or its individual parts with `curl_url_get`:

    char *url;
    rc = curl_url_get(h, CURLUPART_URL, &url, CURLU_NO_DEFAULT_PORT);
    curl_free(url);

If the handle does not have enough information to return the part that is
being asked for, it returns error.

A returned string must be freed with `curl_free()` after you are done with it.

# Flags

When retrieving a URL part using `curl_url_get()`, the API offers a few
different toggles to better specify exactly how that content should be
returned. They are set in the `flags` bitmask parameter, which is the
function's fourth argument. You can set zero, one or more bits.

## `CURLU_DEFAULT_PORT`

If the URL handle has no port number stored, this option will make
`curl_url_get()` return the default port for the used scheme.

## `CURLU_DEFAULT_SCHEME`

If the handle has no scheme stored, this option will make `curl_url_get()`
return the default scheme instead of error.

## `CURLU_NO_DEFAULT_PORT`

Instructs `curl_url_get()` to *not* use a port number in the generated URL if
that port number matches the default port used for the scheme. For example, if
port number 443 is set and the scheme is `https`, the extracted URL will not
include the port number.

## `CURLU_URLENCODE`

If set, will make `curl_url_get()` URL encode the host name part when a full
URL is retrieved. If not set (default), libcurl returns the URL with the host
name "raw" to support IDN names to appear as-is. IDN host names are typically
using non-ASCII bytes that otherwise will be percent-encoded.

Note that even when not asking for URL encoding, the `%` (byte 37) will be URL
encoded in host names to make sure the host name remains valid.

## `CURLU_PUNYCODE`

If set and `CURLU_URLENCODE` is not set, and asked to retrieve the
`CURLUPART_HOST` or `CURLUPART_URL` parts, libcurl returns the host name in
its punycode version if it contains any non-ASCII octets (and is an IDN
name). If libcurl is built without IDN capabilities, using this bit will make
`curl_url_get()` return `CURLUE_LACKS_IDN` if the host name contains anything
outside the ASCII range.
