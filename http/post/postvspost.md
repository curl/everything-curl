# -d vs -F

Previous chapters talked about [regular POST](simple.md) and
[multipart formpost](multipart.md), and in your typical command lines you do
them with `-d` or `-F`.

When do you use which of them?

As described in the chapters mentioned above, both these options send the
specified data to the server. The difference is in how the data is
formatted over the wire. Most of the time, the receiving end is written to
expect a specific format and it expects that the sender formats and sends the
data correctly. A client cannot just pick a format of its own choice.

## HTML web forms

When we are talking browsers and HTML, the standard way is to offer a form to
the user that sends off data when the form has been filled in. The `<form>`
tag is what makes one of those appear on the webpage. The tag instructs the
browser how to format its POST. If the form tag includes
`enctype=multipart/form-data`, it tells the browser to send the data as a
[multipart formpost](multipart.md) which you make with curl's `-F`
option. This method is typically used when the form includes a `<input
type=file>` tag, for file uploads.

The default `enctype` used by forms, which is rarely spelled out in HTML since
it is default, is `application/x-www-form-urlencoded`. It makes the browser
URL encode the input as name=value pairs with the data encoded to avoid unsafe
characters. We often refer to that as a [regular POST](simple.md), and you
perform one with curl's `-d` and friends.

## POST outside of HTML

POST is a regular HTTP method and there is no requirement that it be triggered
by HTML or involve a browser. Lots of services, APIs and other systems allow
you to pass in data these days in order to get things done.

If these services expect plain raw data or perhaps data formatted as JSON or
similar, you want the [regular POST](simple.md) approach. curl's `-d` option
does not alter or encode the data at all but just sends exactly what you tell
it to. Just pay attention that `-d` sets a default `Content-Type:` that might
not be what you want.
