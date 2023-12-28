# Requests

An HTTP request is what curl sends to the server when it tells the server what
to do. When it wants to get data or send data. All transfers involving HTTP
start with an HTTP request.

An HTTP request contains a method, a path, HTTP version and a set of request
headers. A libcurl-using application can tweak all those fields.

## Request method

Every HTTP request contains a "method", sometimes referred to as a "verb". It
is usually something like GET, HEAD, POST or PUT but there are also more
esoteric ones like DELETE, PATCH and OPTIONS.

Usually when you use libcurl to set up and perform a transfer the specific
request method is implied by the options you use. If you just ask for a URL,
it means the method is `GET` while if you set for example `CURLOPT_POSTFIELDS`
that makes libcurl use the `POST` method. If you set `CURLOPT_UPLOAD` to true,
libcurl sends a `PUT` method in its HTTP request and so on. Asking for
`CURLOPT_NOBODY` makes libcurl use `HEAD`.

However, sometimes those default HTTP methods are not good enough or simply
not the ones you want your transfer to use. Then you can instruct libcurl to
use the specific method you like with `CURLOPT_CUSTOMREQUEST`. For example,
you want to send a `DELETE` method to the URL of your choice:

    curl_easy_setopt(curl, CURLOPT_CUSTOMREQUEST, "DELETE");
    curl_easy_setopt(curl, CURLOPT_URL, "https://example.com/file.txt");

The CURLOPT_CUSTOMREQUEST setting should only be the single keyword to use as
method in the HTTP request line. If you want to change or add additional HTTP
request headers, see the following section.

## Customize HTTP request headers

When libcurl issues HTTP requests as part of performing the data transfers you
have asked it to, it sends them off with a set of HTTP headers that are
suitable for fulfilling the task given to it.

If just given the URL `http://localhost/file1.txt`, libcurl sends the
following request to the server:

    GET /file1.txt HTTP/1.1
    Host: localhost
    Accept: */*

If you instruct your application to also set `CURLOPT_POSTFIELDS` to the
string "foobar" (6 letters, the quotes only used for visual delimiters here),
it would send the following headers:

    POST /file1.txt HTTP/1.1
    Host: localhost
    Accept: */*
    Content-Length: 6
    Content-Type: application/x-www-form-urlencoded

If you are not pleased with the default set of headers libcurl sends, the
application has the power to add, change or remove headers in the HTTP
request.

### Add a header

To add a header that would not otherwise be in the request, add it with
`CURLOPT_HTTPHEADER`. Suppose you want a header called `Name:` that contains
`Mr. Smith`:

    struct curl_slist *list = NULL;
    list = curl_slist_append(list, "Name: Mr Smith");
    curl_easy_setopt(curl, CURLOPT_HTTPHEADER, list);
    curl_easy_perform(curl);
    curl_slist_free_all(list); /* free the list again */

### Change a header

If one of those default headers are not to your satisfaction you can alter
them. Like if you think the default `Host:` header is wrong (even though it is
derived from the URL you give libcurl), you can tell libcurl your own:

    struct curl_slist *list = NULL;
    list = curl_slist_append(list, "Host: Alternative");
    curl_easy_setopt(curl, CURLOPT_HTTPHEADER, list);
    curl_easy_perform(curl);
    curl_slist_free_all(list); /* free the list again */

### Remove a header

When you think libcurl uses a header in a request that you really think it
should not, you can easily tell it to just remove it from the request. Like if
you want to take away the `Accept:` header. Just provide the header name with
nothing to the right sight of the colon:

    struct curl_slist *list = NULL;
    list = curl_slist_append(list, "Accept:");
    curl_easy_setopt(curl, CURLOPT_HTTPHEADER, list);
    curl_easy_perform(curl);
    curl_slist_free_all(list); /* free the list again */

### Provide a header without contents

As you may then have noticed in the above sections, if you try to add a header
with no contents on the right side of the colon, it is treated as a removal
instruction and it instead completely inhibits that header from being sent. If
you instead *truly* want to send a header with zero contents on the right
side, you need to use a special marker. You must provide the header with a
semicolon instead of a proper colon. Like `Header;`. If you want to add a
header to the outgoing HTTP request that is just `Moo:` with nothing following
the colon, you could write it like:

    struct curl_slist *list = NULL;
    list = curl_slist_append(list, "Moo;");
    curl_easy_setopt(curl, CURLOPT_HTTPHEADER, list);
    curl_easy_perform(curl);
    curl_slist_free_all(list); /* free the list again */

## Referrer

The `Referer:` header (yes, it is misspelled) is a standard HTTP header that
tells the server from which URL the user-agent was directed from when it
arrived at the URL it now requests. It is a normal header so you can set it
yourself with the `CURLOPT_HEADER` approach as shown above, or you can use the
shortcut known as `CURLOPT_REFERER`. Like this:

    curl_easy_setopt(curl, CURLOPT_REFERER, "https://example.com/fromhere/");
    curl_easy_perform(curl);

### Automatic referrer

When libcurl is asked to follow redirects itself with the
`CURLOPT_FOLLOWLOCATION` option, and you still want to have the `Referer:`
header set to the correct previous URL from where it did the redirect, you can
ask libcurl to set that by itself:

    curl_easy_setopt(curl, CURLOPT_FOLLOWLOCATION, 1L);
    curl_easy_setopt(curl, CURLOPT_AUTOREFERER, 1L);
    curl_easy_setopt(curl, CURLOPT_URL, "https://example.com/redirected.cgi");
    curl_easy_perform(curl);
