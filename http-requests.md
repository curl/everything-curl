## Modify the HTTP request

As described earlier, each HTTP transfer starts with curl sending a HTTP
request. That request consists of a request line and a number of request
headers, and this chapter details how you can modify all of those.

### Request method

The first line of the request includes the *method*. When doing a simple GET
request as this command line would do:

    curl http://example.com/file

…that initial request line would look like this:

    GET /file HTTP/1.1

You can tell curl to change the method into something else by using the `-X`
or `--request` command-line options followed by the actual method name. You
can, for example, send a DELETE instead like this:

    curl http://example.com/file -X DELETE

This command-line option only changes the text in the outgoing request, it
does not change any behavior. This is particularly important if you, for
example, ask curl to send a HEAD with -X, as HEAD is specified to send all the
headers a GET response would get but *never* send a response body, even if
the headers otherwise imply that one would come. So, adding `-X HEAD` to a
command line that would otherwise do a GET will cause curl to hang, waiting
for a response body that won't come.

### Customize headers

TBD

### Referer

TBD

### User-agent

TBD

### --time-cond

TBD
