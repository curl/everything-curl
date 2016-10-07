# -d vs -F

Previous chapters talk about [regular POST](http-post.md) and [multipart
formpost](http-multipart.md), and in your typical command lines you do them
with `-d` or `-F`.

But when do you use which of them?

As described in these chapters mentioned above, both these options send the
specified data to the server. The difference is really in how the data is
formatted over the wire. Most of the times, the receiving end is written to
expect a specific format and it expects that the sender formats and sends the
data correctly. A client cannot just pick a format on its own choice.

## HTML web forms

When we're talking browsers and HTML, the standard way is to offer a form to
the user that sends off data when the form has been filled in. The `<form>`
tag is that makes one of those appear on the web page. The tag instructs the
browser how to form its POST. If the form tag includes
`enctype=multipart/form-data`, it tells the browser to send the data as a
[multipart formpost](http-multipart.md) - which you make with curl's `-F`
option. This method is typically used when the form includes a `<input
type=file>` tag, for file uploads.

The default `enctype` used by forms, that is rarely spelled out in HTML since
it is default, is `application/x-www-form-urlencoded`. It makes the browser
"URL encode" the input as name=value pairs with the data encoded to avoid
unsafe character. We often refer to that as a [regular POST](http-post.md),
and you do with curl's `-d` and friends.

## POST outside of HTML

POST is a regular HTTP method and there's really no requirement it was
triggered or originated by HTML or ever involving a browser. Lots of
services, APIs and similar these days allow you to pass in data to get things
done.

If these services expect plain "raw" data or perhaps data formatted as JSON or
similar, you want the [regular POST](http-post.md) approach. curl's `-d`
option won't alter or encode the data at all but will just send exactly what
you tell it to. Just pay attention to -d's default Content-Type as that might
not be what you want.
