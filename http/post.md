## HTTP POST

POST is the HTTP method that was invented to send data to a receiving web
application, and it is how most common HTML forms on the web
works. It usually sends a chunk of relatively small amounts of data to the
receiver.

When the data is sent by a browser after data have been filled in a form, it
will send it URL encoded, as a serialized name=value pairs separated with
ampersand symbols (`&`). You send such data with curl's `-d` or `--data`
option like this:

    curl -d 'name=admin&shoesize=12' http://example.com/

When specifying multiple `-d` options on the command line, curl will
concatenate them and insert ampersands in between, so the above example could
also be made like this:

    curl -d name=admin -d shoesize=12 http://example.com/

If the amount of data to send is not really fit to put in a mere string on the
command line, you can also read it off a file name in standard curl style:

    curl -d @filename http://example.com

### Content-Type

POSTing with curl's -d option will make it include a default header that looks
like `Content-Type: application/x-www-form-urlencoded`. That's what your
typical browser will use for a plain POST.

Many receivers of POST data do not care about or check the Content-Type
header.

If that header is not good enough for you, you should, of course, replace that
and instead provide the correct one. Such as if you POST JSON to a server and
want to more accurately tell the server about what the content is:

    curl -d '{json}' -H 'Content-Type: application/json' https://example.com

### POSTing binary

When reading from a file, `-d` will strip out carriage return and
newlines. Use `--data-binary` if you want curl to read and use the given file
in binary exactly as given:

    curl --data-binary @filename http://example.com/

### URL encoding

Percent-encoding, also known as URL encoding, is technically a mechanism for
encoding data so that it can appear in URLs. This encoding is typically used
when sending POSTs with the `application/x-www-form-urlencoded` content type,
such as the ones curl sends with `--data` and `--data-binary` etc.

The command-line options mentioned above all require that you provide properly
encoded data, data you need to make sure already exists in the right format.
While that gives you a lot of freedom, it is also a bit inconvenient at times.

To help you send data you have not already encoded, curl offers the
`--data-urlencode` option. This option offers several different ways to URL
encode the data you give it.

You use it like `--data-urlencode data` in the same style as the other --data
options. To be CGI-compliant, the **data** part should begin with a name
followed by a separator and a content specification. The **data** part can be
passed to curl using one of the following syntaxes:

 - `content`: This will make curl URL encode the content and pass that
   on. Just be careful so that the content does not contain any = or @ symbols,
   as that will then make the syntax match one of the other cases below!

 - `=content`: This will make curl URL encode the content and pass that
   on. The initial '=' symbol is not included in the data.

 - `name=content`: This will make curl URL encode the content part and pass
   that on. Note that the name part is expected to be URL encoded already.

 - `@filename`: This will make curl load data from the given file (including
   any newlines), URL encode that data and pass it on in the POST.

 - `name@filename`: This will make curl load data from the given file
   (including any newlines), URL encode that data and pass it on in the POST.
   The name part gets an equal sign appended, resulting in
   name=urlencoded-file-content. Note that the name is expected to be URL
   encoded already.

As an example, you could POST a name to have it encoded by curl:

    curl --data-urlencode "name=John Doe (Junior)" http://example.com

…which would send the following data in the actual request body:

    name=John%20Doe%20%28Junior%29

If you store the string `John Doe (Junior)` in a file named `contents.txt`,
you can tell curl to send that contents URL encoded using the field name
'user' like this:

    curl --data-urlencode user@contents.txt http://example.com

In both these examples above, the field name is not URL encoded but is passed
on as-is. If you want to URL encode the field name as well, like if you want
to pass on a field name called `user name`, you can ask curl to encode the
entire string by prefixing it with an equals sign (that will not get sent):

    curl --data-urlencode "=user name=John Doe (Junior)" http://example.com

### Convert that to a GET

A little convenience feature that could be suitable to mention in this context
is the `-G` or `--get` option, which
takes all data you have specified with the different `-d` variants and appends
that data to the inputted URL e.g. ```http://example.com``` separated with a '?' and then makes curl
send a GET instead.

This option makes it easy to switch between POSTing and GETing a form, for
example.

### Expect 100-continue

HTTP has no proper way to stop an ongoing transfer (in any direction) and
still maintain the connection. So, if we figure out that the transfer had better
stop after the transfer has started, there are only two ways to proceed: cut the
connection and pay the price of reestablishing the connection again for the next
request, or keep the transfer going and waste bandwidth but be able to reuse
the connection next time.

One example of when this can happen is when you send a large file over HTTP,
only to discover that the server requires authentication and immediately sends
back a 401 response code.

The mitigation that exists to make this scenario less frequent is to have
curl pass on an extra header, `Expect: 100-continue`, which gives the server a
chance to deny the request before a lot of data is sent off. curl sends this
Expect: header by default if the POST it will do is known or suspected to be
larger than just minuscule. curl also does this for PUT requests.

When a server gets a request with an 100-continue and deems the request fine,
it will respond with a 100 response that makes the client continue. If the
server does not like the request, it sends back response code for the error it
thinks it is.

Unfortunately, lots of servers in the world do not properly support the
Expect: header or do not handle it correctly, so curl will only wait 1000
milliseconds for that first response before it will continue anyway.

Those are 1000 wasted milliseconds. You can then remove the use of Expect:
from the request and avoid the waiting with `-H`:

    curl -H Expect: -d "payload to send" http://example.com

In some situations, curl will inhibit the use of the Expect header if the
content it is about to send is small (like below one kilobyte), as having to
waste such a small chunk of data is not considered much of a problem.

### Chunked encoded POSTs

When talking to a HTTP 1.1 server, you can tell curl to send the request body
without a `Content-Length:` header upfront that specifies exactly how big the
POST is. By insisting on curl using chunked Transfer-Encoding, curl will send
the POST chunked piece by piece in a special style that also sends the size
for each such chunk as it goes along.

You send a chunked POST with curl like this:

    curl -H "Transfer-Encoding: chunked" -d "payload to send" http://example.com

### Hidden form fields

This chapter has explained how sending a post with `-d` is the equivalent of
what a browser does when an HTML form is filled in and submitted.

Submitting such forms is a common operation with curl; effectively, to have
curl fill in a web form in an automated fashion.

If you want to submit a form with curl and make it look as if it has been done
with a browser, it is important to provide all the input fields from the
form. A common method for web pages is to set a few hidden input fields to the
form and have them assigned values directly in the HTML. A successful form
submission, of course, also includes those fields and in order to do that
automatically you may be forced to first download the HTML page that holds the
form, parse it, and extract the hidden field values so that you can send them
off with curl.

### Figure out what a browser sends

A common shortcut is to simply fill in the form with your browser and submit
it and check in the browser's network development tools exactly what it sent.

A slightly different way is to save the HTML page containing the form, and
then edit that HTML page to redirect the 'action=' part of the form to your
own server or a test server that just outputs exactly what it gets. Completing
that form submission will then show you exactly how a browser sends it.

A third option is, of course, to use a network capture tool such as Wireshark to
check exactly what is sent over the wire. If you are working with HTTPS, you
cannot see form submissions in clear text on the wire but instead you need to
make sure you can have Wireshark extract your TLS private key from your
browser. See the Wireshark documentation for details on doing that.

### JavaScript and forms

A common mitigation against automated agents or scripts using curl is to have
the page with the HTML form use JavaScript to set values of some input fields,
usually one of the hidden ones. Often, there's some JavaScript code that
executes on page load or when the submit button is pressed which sets a magic
value that the server then can verify before it considers the submission to be
valid.

You can usually work around that by just reading the JavaScript code and
redoing that logic in your script. Using the above mentioned tricks to check
exactly what a browser sends is then also a good help.
