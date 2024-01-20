# Verbose

If your curl command does not execute or return what you expected it to, your
first gut reaction should always be to run the command with the `-v /
--verbose` option to get more information.

When verbose mode is enabled, curl gets more talkative and explains and shows
a lot more of its doings. It adds informational tests and prefix them with
'\*'. For example, let's see what curl might say when trying a simple HTTP
example (saving the downloaded data in the file called 'saved'):

    $ curl -v http://example.com -o saved
    * Rebuilt URL to: http://example.com/

Ok so we invoked curl with a URL that it considers incomplete so it helps us
and it adds a trailing slash before it moves on.

    *   Trying 93.184.216.34...

This tells us curl now tries to connect to this IP address. It means the name
'example.com' has been resolved to one or more addresses and this is the first
(and possibly only) address curl tries to connect to.

    * Connected to example.com (93.184.216.34) port 80 (#0)

It worked. curl connected to the site and here it explains how the name maps
to the IP address and on which port it has connected to. The '(#0)' part is
which internal number curl has given this connection. If you try multiple URLs
in the same command line you can see it use more connections or reuse
connections, so the connection counter may increase or not increase depending
on what curl decides it needs to do.

If we use an `HTTPS://` URL instead of an HTTP one, there are also a whole
bunch of lines explaining how curl uses CA certs to verify the server's
certificate and some details from the server's certificate, etc. Including
which ciphers were selected and more TLS details.

In addition to the added information given from curl internals, the `-v`
verbose mode also makes curl show all headers it sends and receives. For
protocols without headers (like FTP, SMTP, POP3 and so on), we can consider
commands and responses as headers and they thus also are shown with `-v`.

If we then continue the output seen from the command above (but ignore the
actual HTML response), curl shows:

    > GET / HTTP/1.1
    > Host: example.com
    > User-Agent: curl/7.45.0
    > Accept: */*
    >

This is the full HTTP request to the site. This request is how it looks in a
default curl 7.45.0 installation and it may, of course, differ slightly
between different releases and in particular it changes if you add command
line options.

The last line of the HTTP request headers looks empty, and it is. It
signals the separation between the headers and the body, and in this request
there is no "body" to send.

Moving on and assuming everything goes according to plan, the sent request
gets a corresponding response from the server and that HTTP response starts
with a set of headers before the response body:

    < HTTP/1.1 200 OK
    < Accept-Ranges: bytes
    < Cache-Control: max-age=604800
    < Content-Type: text/html
    < Date: Sat, 19 Dec 2015 22:01:03 GMT
    < Etag: "359670651"
    < Expires: Sat, 26 Dec 2015 22:01:03 GMT
    < Last-Modified: Fri, 09 Aug 2013 23:54:35 GMT
    < Server: ECS (ewr/15BD)
    < Vary: Accept-Encoding
    < X-Cache: HIT
    < x-ec-custom-error: 1
    < Content-Length: 1270
    <

This may look mostly like mumbo jumbo to you, but this is a normal set of HTTP
headers—metadata—about the response. The first line's "200" might be the
most important piece of information in there and means "everything is fine".

The last line of the received headers is, as you can see, empty, and that is the
marker used for the HTTP protocol to signal the end of the headers.

After the headers comes the actual response body, the data payload. The
regular -v verbose mode does not show that data but only displays

    { [1270 bytes data]

That 1270 bytes should then be in the 'saved' file. You can also see that
there was a header named Content-Length: in the response that contained the
exact file length (though it may not always be present in responses).

## HTTP/2 and HTTP/3

When doing file transfers using version two or three of the HTTP protocol,
curl sends and receives **compressed** headers. To display outgoing and
incoming HTTP/2 and HTTP/3 headers in a readable and understandable way, curl
shows the uncompressed versions in a style similar to how they appear with
HTTP/1.1.

## Silence

The opposite of verbose is, of course, to make curl more silent. With the `-s`
(or `--silent`) option you make curl switch off the progress meter and not
output any error messages for when errors occur. It gets mute. It still
outputs the downloaded data you ask it to.

With silence activated, you can ask for it to still output the error message on
failures by adding `-S` or `--show-error`.

 * [Trace options](trace.md)
 * [Write out](writeout.md)
