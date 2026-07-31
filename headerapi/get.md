# Get a header

    CURLHcode curl_easy_header(CURL *easy,
                               const char *name,
                               size_t index,
                               unsigned int origin,
                               int request,
                               struct curl_header **hout);

This function returns information about a field with a specific **name**, and
you ask the function to search for it in one or more **origins**.

The **index** argument is when you want to ask for the nth occurrence of a
header; when there are more than one available. Setting **index** to 0 returns
the first instance - in many cases that is the only one.

The **request** argument tells libcurl from which request you want headers
from.

An application needs to pass in a pointer to a `struct curl_header *` in the
last argument, as a pointer is returned there when an error is not
returned. See [Header struct](struct.md) for details on the **out** result of
a successful call.

If the given name does not match any received header in the given origin, the
function returns `CURLHE_MISSING` or if no headers *at all* have been received
yet it returns `CURLHE_NOHEADERS`.
