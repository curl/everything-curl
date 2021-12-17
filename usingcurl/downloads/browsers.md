# "My browser shows something else"

A common use case is using curl to get a URL that you can get in your browser
when you paste the URL in the browser's address bar.

A browser getting a URL as input does so much more and in so many different
ways than curl that what curl shows in your terminal output is probably not at
all what you see in your browser window.

## Client differences

Curl only gets exactly what you ask it to get and it never parses the actual
content—the data—that the server delivers. A browser gets data and it
activates different parsers depending on what kind of content it thinks it
gets. For example, if the data is HTML it will parse it to display a web page
and possibly download other sub resources such as images, JavaScript and CSS
files. When curl downloads a HTML it will just get that single HTML resource,
even if it, when parsed by a browser, would trigger a whole busload of more
downloads. If you want curl to download any sub-resources as well, you need to
pass those URLs to curl and ask it to get those, just like any other URLs.

Clients also differ in how they send their requests, and some aspects of a
request for a resource include, for example, format preferences, asking for
compressed data, or just telling the server from which previous page we are
"coming from". curl's requests will differ a little or a lot from how your
browser sends its requests.

## Server differences

The server that receives the request and delivers data is often setup to act in
certain ways depending on what kind of client it thinks communicates with it.
Sometimes it is as innocent as trying to deliver the best content for the
client, sometimes it is to hide some content for some clients or even to try
to work around known problems in specific browsers. Then there is also, of
course, various kind of login systems that might rely on HTTP authentication or
cookies or the client being from the pre-validated IP address range.

Sometimes getting the same response from a server using curl as the response
you get with a browser ends up really hard work. Users then typically record
their browser sessions with the browser's networking tools and then compare
that recording with recorded data from curl's `--trace-ascii` option and
proceed to modify curl's requests (often with `-H / --header`) until the
server starts to respond the same to both.

This type of work can be both time consuming and tedious. You should always do
this with permission from the server owners or admins.

## Intermediaries' fiddlings

Intermediaries are proxies, explicit or implicit ones. Some environments will
force you to use one or you may choose to use one for various reasons, but
there are also the transparent ones that will intercept your network traffic
silently and proxy it for you no matter what you want.

Proxies are "middle men" that terminate the traffic and then act on your
behalf to the remote server. This can introduce all sorts of explicit
filtering and "saving" you from certain content or even "protecting" the
remote server from what data you try to send to it, but even more so it
introduces another software's view on how the protocol works and what the
right things to do are.

Interfering intermediaries are often the cause of lots of head aches and
mysteries down to downright malicious modifications of content.

We strongly encourage you to use HTTPS or other means to verify that the
contents you are downloading or uploading are really the data that the remote
server has sent to you and that your precious bytes end up verbatim at the
intended destination.

