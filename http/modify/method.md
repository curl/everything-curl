# Request method

The first line of an HTTP request includes the *method* - sometimes also
referred to as the verb. When doing a simple GET request as this command line
would do:

    curl http://example.com/file

…the initial request line looks like this:

    GET /file HTTP/1.1

You can tell curl to change the method into something else by using the `-X`
or `--request` command-line options followed by the actual method name. You
can, for example, send a `DELETE` instead of `GET` like this:

    curl http://example.com/file -X DELETE

This command-line option only changes the text in the outgoing request, it
does not change any behavior. This is particularly important if you, for
example, ask curl to send a HEAD with `-X`, as HEAD is specified to send all
the headers a GET response would get but *never* send a response body, even if
the headers otherwise imply that one would come. So, adding `-X HEAD` to a
command line that would otherwise do a GET causes curl to hang, waiting for a
response body that does not come.

When asking curl to perform HTTP transfers, it picks the correct method based
on the option so you should only rarely have to explicitly ask for it with
`-X`. It should also be noted that when curl follows redirects like asked to
with `-L`, the request method set with `-X` is sent even on the subsequent
redirects.

