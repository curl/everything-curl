# Request target

When given an input URL such as `http://example.com/file`, the path section of
the URL gets extracted and is turned into `/file` in the HTTP request line.
That item in the protocol is called the *request target* in HTTP. That is the
resource this request interacts with. Normally this request target is
extracted from the URL and then used in the request and as a user you do not
need to think about it.

In some rare circumstances, user may want to go creative and change this
request target in ways that the URL does not really allow. For example, the
HTTP OPTIONS method has a specially define request target for magic that
concerns *the server* and not a specific path, and it uses `*` for that. Yes,
a single asterisk. There is no way to specify a URL for this, so if you want to
pass a single asterisk in the request target to a server, like for OPTIONS,
you have to do it like this:

    curl -X OPTIONS --request-target "*" http://example.com/

That example command line makes the first line of the outgoing HTTP request to
look like this:

    OPTIONS * HTTP/1.1

## --path-as-is

The path part of the URL is the part that starts with the first slash after
the hostname and ends either at the end of the URL or at a '?' or '#'
(roughly speaking).

If you include substrings including `/../` or `/./` in the path, curl
automatically squashes them before the path is sent to the server, as is
dictated by standards and how such strings tend to work in local file
systems. The `/../` sequence removes the previous section so that
`/hello/sir/../` ends up just `/hello/` and `/./` is simply removed so that
`/hello/./sir/` becomes `/hello/sir/`.

To *prevent* curl from squashing those magic sequences before they are sent to
the server and thus allow them through, the `--path-as-is` option exists.

Lame attempt to trick the server to deliver its `/etc/passwd` file:

    curl --path-as-is https://example.com/../../etc/passwd
