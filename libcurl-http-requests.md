# HTTP Requests

A HTTP request is what curl sends to the server when it tells the server what
to do. When it wants to get data or send data. All transfers involving HTTP
starts with a HTTP request.

A HTTP request contains a method, a path, HTTP version and a set of request
headers. And of course a libcurl using application can tweak all those fields.

## Request method

Every HTTP request contains a "method", sometimes referred to as a "verb". It
is usually something like GET, HEAD, POST or PUT but there are also more
esoteric ones like DELETE, PATCH and OPTIONS.

Usually when you use libcurl to set up and perform a transfer the specific
request method is implied by the options you use. If you just ask for a URL,
it means the method will be `GET` while if you set for example
`CURLOPT_POSTFIELDS` that will make libcurl use the `POST` method. If you set
`CURLOPT_UPLOAD` to true, libcurl will send a `PUT` method in its HTTP request
and so on. Asking for `CURLOPT_NOBODY` will make libcurl use `HEAD`.

However, sometimes those default HTTP methods are not good enough or simply
not the ones you want your transfer to use. Then you can instruct libcurl to
use the specific method you like with `CURLOPT_CUSTOMREQUEST`. For example,
you want to send a `DELETE` method to the URL of your choice:

    curl_easy_setupt(curl, CURLOPT_CUSTOMREQUEST, "DELETE");
    curl_easy_setupt(curl, CURLOPT_URL, "https://example.com/file.txt");

The CURLOPT_CUSTOMREQUEST setting should only be the single keyword to use as
method in the HTTP request line. If you want to change or add additional HTTP
reuqest headers, see the following section.

## Customize HTTP request headers

When libcurl issues HTTP requests as part of performing the data transfers
you've asked it to, it will of course send them off with a set of HTTP headers
that are suitable for fulfilling the task given to it.

If just given the URL "http://localhost/file1.txt", libcurl 7.51.0 would send
the following request to the server:

    GET /file1.txt HTTP/1.1
    Host: localhost
    Accept: */*

If you would instead instruct your application to also set
`CURLOPT_POSTFIELDS` to the string "foobar" (6 letters, the quotes only used
for visual delimiters here), it would send the following headers:

    POST /file1.txt HTTP/1.1
    Host: localhost
    Accept: */*
    Content-Length: 6
    Content-Type: application/x-www-form-urlencoded

If you're not pleased with the default set of headers libcurl sends, the
application has the power to add, change or remove headers in the HTTP
request.

### Add a header

To add a header that wouldn't otherwise be in the request, add it with
`CURLOPT_HTTPHEADER`. Suppose you want a header called `Name:` that contains
`Mr. Smith`:

    struct curl_slist *list = NULL;
    list = curl_slist_append(list, "Name: Mr Smith");
    curl_easy_setopt(curl, CURLOPT_HTTPHEADER, list);
    curl_easy_perform(curl);
    curl_slist_free_all(list); /* free the list again */

### Change a header

If one of those default headers aren't to your satisfaction you can alter
them. Like if you think the default `Host:` header is wrong (even though it is
derived from the URL you give libcurl), you can tell libcurl your own:

    struct curl_slist *list = NULL;
    list = curl_slist_append(list, "Host: Alternative");
    curl_easy_setopt(curl, CURLOPT_HTTPHEADER, list);
    curl_easy_perform(curl);
    curl_slist_free_all(list); /* free the list again */

### Remove a header

As you may then have noticed in the above sections, if you try to add a header
with no contents on the right side of the colon, it will be treated as a
removal instruction and it will instead completely inhibit that header from
being sent. If you instead *truly* want to send a header with zero contents on
the right side, you need to use a special marker. You must provide the header
with a semicolon instead of a proper colon. Like `Header;`. So if you want to
add a header to the outgoing HTTP request that is just `Moo:` with nothing
following the colon, you could write it like:

    struct curl_slist *list = NULL;
    list = curl_slist_append(list, "Moo;");
    curl_easy_setopt(curl, CURLOPT_HTTPHEADER, list);
    curl_easy_perform(curl);
    curl_slist_free_all(list); /* free the list again */

### Provide a header without contents

When you think libcurl has added and uses a header you really think it
shouldn't, you can easily tell it to just remove it from requests. Like if you
want to take away the `Accept:` header. Just provide the header name with
nothing to the right sight of the colon:

    struct curl_slist *list = NULL;
    list = curl_slist_append(list, "Accept:");
    curl_easy_setopt(curl, CURLOPT_HTTPHEADER, list);
    curl_easy_perform(curl);
    curl_slist_free_all(list); /* free the list again */

## Referrer

and autoreferrer

TBD
