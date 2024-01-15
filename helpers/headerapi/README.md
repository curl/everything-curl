# Headers API

libcurl offers an API for iterating over all received HTTP headers and for
extracting the contents from specific ones.

When returning header content, libcurl trims leading and trailing whitespace
but does not modify or change content in any other way.

This API was made official and is provided for real starting in libcurl
7.84.0.

## Header origins

HTTP headers are key value pairs that are sent from the server in a few
different *origins* during a transfer. libcurl collects all headers and
provides easy access to them for applications.

HTTP headers can arrive as

1. **CURLH_HEADER** - before regular response content.
2. **CURLH_TRAILER** - fields arriving *after* the response content
3. **CURLH_CONNECT** - response headers in the proxy `CONNECT` request that
   might have been done before the actual server request
4. **CURLH_1XX** - headers in the potential 1xx HTTP responses that might have
   preceded the following >= 2xx response code.
5. **CURLH_PSEUDO** - HTTP/2 and HTTP/3 level headers that start with colon
   (`:`)

## Request number

A single HTTP transfer done with libcurl might consist of a series of HTTP
requests and the **request** argument to the header API functions lets you
specify which particular individual request you want the headers from. 0 being
the first request and then the number increases for further redirects or when
multi-state authentication is used. Passing in `-1` is a shortcut to the last
request in the series, independently of the actual amount of requests used.

## Header folding

HTTP/1 headers supports a deprecated format called *folding*, which means that
there is a continuation line after a header, making the line folded.

The headers API supports folded headers and returns such contents unfolded -
where the different parts are separated by a single whitespace character.

## When

The two header API function calls are perfectly possible to call at any time
during a transfer, both from inside and outside of callbacks. It is however
important to remember that the API only returns information about the state of
the headers at the exact moment it is called, which might not be the final
status if you call it while the transfer is still in progress.

 - [Header struct](struct.md)
 - [Get a header](get.md)
 - [Iterate of headers](iterate.md)
