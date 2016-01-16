## HTTP POST

POST is the HTTP method that was invented to send data to a receving web
application, and it is for example how most common HTML forms on the web
works. It usually sends a chunk of relatively small amounts of data to the
receiver.

When the data is sent by a browser after data have been filled in a form, it
will send it "URL encoded", as a serialized name=value pairs separated with
ampersand symbols ('&'). You send such data with curl's `-d` or `--data`
option like this:

    curl -d name=admin&shoesize=12 http://example.com/

When specifying multiple `-d` options on the command line, curl will
concatenate them and insert ampersands in between, so the above example could
also be made like this:

    curl -d name=admin -d shoesize=12 http://example.com/

If the amount of data to send isn't really fit to put in a mere string on the
command line, you can also read it off a file name in standard curl style:

    curl -d @filename http://example.com

### POSTing binary

When reading from a file, `-d` will strip out carriage return and
newlines. Use `--data-binary` if you want curl to read and use the given file
in binary exactly as given:

    curl --data-binary @filename http://example.com/

### URL encoding

Ok, so the command line options above all require that you provide properly
encoded data. Data you need to make sure is in the right format. While that
gives you a lot of freedom, it is also a bit inconvenient at times.

To help you send data you haven't already encoded, curl offers the
`--data-urlencode` option. This option offers several different ways to URL
encode the data you give it.

You use it like `--data-urlencode data` in the same style as the other --data
options. To be CGI-compliant, the **data** part should begin with a name
followed by a separator and a content specification. The **data** part can be
passed to curl using one of the following syntaxes:

 - "content": This will make curl URL encode the content and pass that
   on. Just be careful so that the content doesn't contain any = or @ symbols,
   as that will then make the syntax match one of the other cases below!

 - "=content": This will make curl URL encode the content and pass that
   on. The initial '=' symbol is not included in the data.

 - "name=content": This will make curl URL encode the content part and pass
   that on. Note that the name part is expected to be URL encoded already.

 - "@filename": This will make curl load data from the given file (including
   any newlines), URL encode that data and pass it on in the POST.

 - "name@filename": This will make curl load data from the given file
   (including any newlines), URL encode that data and pass it on in the POST.
   The name part gets an equal sign appended, resulting in
   name=urlencoded-file-content. Note that the name is expected to be URL
   encoded already.

As an example, you could POST a name to have it encoded by curl:

    curl --data-urlencode "name=John Doe (Junior)" http://example.com

... which would send the following data in the actual request body:

    name=John%20Doe%20%28Junior%29

### Convert that to a GET

A little convenience feature that could be suitable to mention in this context
(even though it isn't for POSTing), is the `-G` or `--get` option, which takes
all data you've specified with the different `-d` variants and appends that
data on the right end of the URL separated with a '?' and then makes curl send
a GET instead.

This option makes it easy to switch between POSTing and GETing a form for
example.

### Expect 100-continue

HTTP has no proper way to stop on ongoing transfer (in any direction) and stil
maintain the connection. So if we figure out that the transfer better top once
the transfer has started, there are only two ways to proceed: cut the
connection pay the price of reestablishing the connection again for next
request, or keep the transfer going and waste bandwidth but be able to reuse
the connection.

One example of when this can happen is when you send a large file over HTTP,
only to discover that the server requires authentication and immediately sends
back a 401 response code.

The mitigation that exists to make this scenario less frequent, is to have
curl pass on an extra header, `Expect: 100-continue`, which gives the server a
chance to deny the request before a lot of data is sent of. curl sends this
Expect: header by default if the POST it will do is known or suspect to be
larger than just minuscule. curl also does this for PUT requests.

When a server gets a request with an 100-continue and deems the request fine,
it will respond with a 100 response that makes the client continue. If the
server doesn't like the request, it sends back response code for the error it
thinks it is.

Unfortunately, lots of servers in the world don't properly support the Expect:
header or don't handle it correctly, so curl will only wait 1000 milliseconds
for that first response before it will continue anyway.

Those are 1000 wasted milliseconds. You can then remove the use of Expect:
from the request and avoid the waiting with `-H`:

    curl -H Expect: -d "payload to send" http://example.com

### Chunked encoded POSTs

When talking to a HTTP 1.1 server, you can tell curl to send the request body
without a `Content-Length:` header upfront that specifies exactly how big the
POST is. By insisting on curl using chunked Tranfer-Encoding, curl will send
the POST "chunked" piece by piece in a special style that also sends the size
for each such chunk as it goes along.

You send a chunked POST with curl like this:

    curl -H "Transfer-Encoding: chunked" -d "payload to send" http://example.com

### Converting an HTML form

TBD

### Hidden fields

TBD

### Javascript and forms

TBD
