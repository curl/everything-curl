# HTTP with libcurl

HTTP is by far the most commonly used protocol by libcurl users and libcurl
offers countless ways of modifying such transfers. See the [HTTP protocol
basics](http-basics.md) for some basics on how the HTTP protocol works.

## HTTP responses

Every HTTP request includes a HTTP response. A HTTP response is a set of
meta-data and a response body, where the body can occastionally be zero bytes
and thus non-existant. A HTTP response will however always have response
headers.

The response body will be passed to the [write callback](callback-write.md)
and the response headers to the [header callback](callback-header.md), but
sometimes an application just want to know the size of the data.

The size of a response *as told by the server headers* can be extracted with
`curl_easy_getinfo()` like this:

    double size;
    curl_easy_getinfo(curl, CURLINFO_CONTENT_LENGTH_DOWNLOAD, &size);

but if you can wait until after the transfer is already done, which also is a
more reliable way since not all URLs will provide the size up front (like for
example for servers that generate content on demand) you can instead ask for
the amount of downloaded data in the most recent transfer.

    double size;
    curl_easy_getinfo(curl, CURLINFO_SIZE_DOWNLOAD, &size);

### HTTP response code

Every HTTP response starts off with a single line that contains the HTTP
response code. It is a threee digit number that contains the server's idea of
the status for the request. The numbers are detailed in the HTTP standard
specifications but they are divided into ranges that basically work like this:

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

### About HTTP response code "errors"

While the response code numbers can include numbers using which the server
signals that there was some sort of error (in the 4xx and 5xx ranges) while
proceessing the request, it is important to understand that libcurl will not
return an error because of that.

when libcurl is asked to perform a HTTP transfer it will return error if that
HTTP transfer fails in any way, and getting for example a 404 back is not a
problem for libcurl. It is not a HTTP transfer error. A user can very well be
writing a client for trying out a servers way to return HTTP responses or
similar.

If you insist on wanting to treating HTTP response codes from 400 and up to be
errors, libcurl offers the `CURLOPT_FAILONERROR` option that if set instructs
curl to return `CURLE_HTTP_RETURNED_ERROR` then. It will then return error as
soon as possible and not deliver the response body.

## HTTP Requests

A HTTP request is what curl sends to the server when it tells the server what
to do. When it wants to get data or send data. All transfers involving HTTP
starts with a HTTP request.

A HTTP request contains a method, a path, HTTP version and a set of request
headers. And of course a libcurl using application can tweak all those fields.

### Request method

TBD

### Customize HTTP request headers

TBD

## Referer

and autoreferer

TBD

## HTTP/2

TBD

## HTTP versions

TBD

## HTTPS

TBD

## HTTP proxy

TBD
