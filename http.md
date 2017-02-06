# How to HTTP with curl

In all user surveys and during all curl's lifetime, HTTP has been the most
important and most frequently used protocol that curl supports. This chapter
will explain how to do effective HTTP transfers and general fiddling with
curl.

This will mostly work the same way for HTTPS, as they are really the same thing
under the hood, as HTTPS is HTTP with an extra security TLS layer. See also
the specific [HTTPS](#https) section below.

## HTTP ranges

The HTTP protocol allows a client to ask for only a specific data range to get
returned. If the client only wants the first 200 bytes out of a remote
resource or why not 300 bytes somewhere in the middle? It then asks the server
for the specific range with a start offset and an end offset. It can even
combine things and ask for several ranges in the same request by just listing
up a bunch of pieces next to each other. When a server sends back multiple
independent pieces to such a reuest, you will get them separated with mime
boundary strings and it will be up to the user application to handle that
accordingly. libcurl will not split up such a response in any way.

A byte range is however only an ask to the server. It does not have to respect
the ask and in many cases, like when the server automatically genarates the
contents on the fly when it is being asked, it will simply refuse to do it and
it then insteads responds with the full contents anyway. In spite of the
request possibly asking for only a little piece out of it.

You can make libcurl ask for a range with `CURLOPT_RANGE`. Like if you want
the first 200 bytes out of something:

    curl_easy_setopt(curl, CURLOPT_RANGE, "0-199");

Or everything in the file starting from index 200:

    curl_easy_setopt(curl, CURLOPT_RANGE, "200-");

Get 200 bytes from index 0 *and* 200 bytes from index 1000:

    curl_easy_setopt(curl, CURLOPT_RANGE, "0-199,1000-199");

## HTTP versions

As any other Internet protocol, the HTTP protocol has kept evolving over the
years and now there are clients and servers distributed over the world and
over time that speak different versions with varying levels of success. So in
order to get libcurl to work with the URLs you pass in libcurl offers ways for
you to specify which HTTP version that request and transfer should
use. libcurl is designed in a way so that it tries to use the most common, the
most sensible if you want, default values first but sometimes that isn't
enough and then you may need to instruct libcurl what to do.

Since perhaps mid 2016, libcurl will default to use HTTP/1.1 for HTTP
servers. If you connect to HTTPS and you have a libcurl that has HTTP/2
abilities built-in, libcurl will attempt to use HTTP/2 automatically or fall
down to 1.1 in case the negotiation failed. Non-HTTP/2 capable libcurls get
1.1 over HTTPS by default.

If the default isn't good enough for your transfer, the `CURLOPT_HTTP_VERSION`
option is there for you.

| Option                              | Description |
|-------------------------------------|-------------|
| CURL_HTTP_VERSION_NONE              | fill in
| CURL_HTTP_VERSION_1_0               | fill in
| CURL_HTTP_VERSION_1_1               | fill in
| CURL_HTTP_VERSION_2_0               | fill in
| CURL_HTTP_VERSION_2TLS              | fill in
| CURL_HTTP_VERSION_2_PRIOR_KNOWLEDGE | fill in

## HTTP authentication

TBD

## HTTPS

TBD

## Scripting browser-like tasks

TBD

## Cheat sheet

TBD

