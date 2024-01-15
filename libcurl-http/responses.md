# Responses

Every HTTP request includes an HTTP response. An HTTP response is a set of
metadata and a response body, where the body can occasionally be zero bytes
and thus nonexistent. An HTTP response however always has response headers.

## Response body

The response body is passed to the [write callback](../transfers/callbacks/write.md)
and the response headers to the [header callback](../transfers/callbacks/header.md).

Virtually all libcurl-using applications need to set at least one of those
callbacks instructing libcurl what to do with received headers and data.

## Response meta-data

libcurl offers the `curl_easy_getinfo()` function that allows an application
to query libcurl for information from the previously performed transfer.

Sometimes an application just want to know the size of the data. The size of
a response *as told by the server headers* can be extracted with
`curl_easy_getinfo()` like this:

    curl_off_t size;
    curl_easy_getinfo(curl, CURLINFO_CONTENT_LENGTH_DOWNLOAD_T, &size);

If you can wait until after the transfer is already done, which also is a more
reliable way since not all URLs provide the size up front (like for example
for servers that generate content on demand) you can instead ask for the
amount of downloaded data in the most recent transfer.

    curl_off_t size;
    curl_easy_getinfo(curl, CURLINFO_SIZE_DOWNLOAD_T, &size);

## HTTP response code

Every HTTP response starts off with a single line that contains the HTTP
response code. It is a three digit number that contains the server's idea of
the status for the request. The numbers are detailed in the HTTP standard
specifications but they are divided into ranges that work like this:

| Code | Meaning                               |
|------|---------------------------------------|
|1xx   | Transient code, a new one follows     |
|2xx   | Things are OK                         |
|3xx   | The content is somewhere else         |
|4xx   | Failed because of a client problem    |
|5xx   | Failed because of a server problem    |

You can extract the response code after a transfer like this

    long code;
    curl_easy_getinfo(curl, CURLINFO_RESPONSE_CODE, &code);

## About HTTP response code "errors"

While the response code numbers can include numbers (in the 4xx and 5xx
ranges) which the server uses to signal that there was an error processing the
request, it is important to realize that this does not make libcurl return an
error.

When libcurl is asked to perform an HTTP transfer it returns an error if that
HTTP transfer fails. However, getting an HTTP 404 or the like back is not a
problem for libcurl. It is not an HTTP transfer error. A user might be writing
a client for testing a server's HTTP responses.

If you insist on curl treating HTTP response codes from 400 and up as errors,
libcurl offers the `CURLOPT_FAILONERROR` option that if set instructs curl to
return `CURLE_HTTP_RETURNED_ERROR` in this case. It then returns error as soon
as possible and does not deliver the response body.
