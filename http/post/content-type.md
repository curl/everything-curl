# Content-Type

POSTing with curl's `-d` option makes it include a default header that looks
like `Content-Type: application/x-www-form-urlencoded`. That is what your
typical browser uses for a plain POST.

Many receivers of POST data do not care about or check the Content-Type
header.

If that header is not good enough for you, you should, of course, replace that
and instead provide the correct one. Such as if you POST JSON to a server and
want to more accurately tell the server about what the content is:

    curl -d '{json}' -H 'Content-Type: application/json' https://example.com
