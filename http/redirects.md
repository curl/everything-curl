# Redirects

The “redirect” is a fundamental part of the HTTP protocol. The concept was
present and is documented already in the first spec (RFC 1945), published in
1996, and it has remained well-used ever since.

A redirect is exactly what it sounds like. It is the server sending back an
instruction to the client instead of giving back the contents the client
wanted. The server says “go look over *here* instead for that thing you asked
for“.

Redirects are not all alike. How permanent is the redirect? What request
method should the client use in the next request?

All redirects also need to send back a `Location:` header with the new URI to
ask for, which can be absolute or relative.

## Permanent and temporary

Is the redirect meant to last or just remain valid for now? If you want a GET
to permanently redirect users to resource B with another GET, send back
a 301. It also means that the user-agent (browser) is meant to cache this and
keep going to the new URI from now on when the original URI is requested.

The temporary alternative is 302. Right now the server wants the client to
send a GET request to B, but it should not cache this but keep trying the
original URI when directed to it next time.

Note that both 301 and 302 make browsers do a GET in the next request, which
possibly means changing the method if it started with a POST (and only if
POST). This changing of the HTTP method to GET for 301 and 302 responses is
said to be “for historical reasons”, but that’s still what browsers do so most
of the public web behaves this way.

In practice, the 303 code is similar to 302. It is not be cached and it makes
the client issue a GET in the next request. The differences between a 302 and
303 are subtle, but 303 seems to be more designed for an “indirect response”
to the original request rather than just a redirect.

These three codes were the only redirect codes in the HTTP/1.0 spec.

curl however, does not remember or cache any redirects at all so to it,
there is really no difference between permanent and temporary redirects.

## Tell curl to follow redirects

In curl's tradition of only doing the basics unless you tell it differently,
it does not follow HTTP redirects by default. Use the `-L, --location` option
to tell it to do that.

When following redirects is enabled, curl follows up to 30 redirects by
default. There is a maximum limit mostly to avoid the risk of getting caught
in endless loops. If 30 is not sufficient for you, you can change the maximum
number of redirects to follow with the `--max-redirs` option.

## GET or POST?

All three of these response codes, 301 and 302/303, assume that the client
sends a GET to get the new URI, even if the client might have sent a POST in
the first request. This is important, at least if you do something that does
not use GET.

If the server instead wants to redirect the client to a new URI and wants it
to send the same method in the second request as it did in the first, like if
it first sent POST it’d like it to send POST again in the next request, the
server would use different response codes.

To tell the client “the URI you sent a POST to, is permanently redirected to B
where you should instead send your POST now and in the future”, the server
responds with a 308. To complicate matters, the 308 code is only recently
defined (the [spec](https://tools.ietf.org/html/rfc7238#section-3) was
published in June 2014) so older clients may not treat it correctly. If so,
then the only response code left for you is…

The (older) response code to tell a client to send a POST also in the next
request but temporarily is 307. This redirect is not be cached by the client
though, so it’ll again post to A if requested to again. The 307 code was
introduced in HTTP/1.1.

Oh, and redirects work the same way in HTTP/2 as they do in HTTP/1.1.

|                     |Permanent | Temporary   |
|---------------------|----------|-------------|
|Switch to GET        | 301      | 302 and 303 |
|Keep original method | 308      | 307         |

### Decide what method to use in redirects

It turns out that there are web services out there in the world that want a
POST sent to the original URL, but are responding with HTTP redirects that use
a 301, 302 or 303 response codes and *still* want the HTTP client to send the
next request as a POST. As explained above, browsers won’t do that and neither
does curl by default.

Since these setups exist, and they’re actually not terribly rare, curl offers
options to alter its behavior.

You can tell curl to not change the non-GET request method to GET after a 30x
response by using the dedicated options for that: `--post301`, `--post302` and
`--post303`. If you are instead writing a libcurl based application, you
control that behavior with the `CURLOPT_POSTREDIR` option.

## Redirecting to other hostnames

When you use curl you may provide credentials like username and password for
a particular site, but since an HTTP redirect might move away to a different
host curl limits what it sends away to other hosts than the original within
the same transfer.

So if you want the credentials to also get sent to the following hostnames
even though they are not the same as the original—presumably because you trust
them and know that there is no harm in doing that—you can tell curl that it is
fine to do so by using the `--location-trusted` option.

# Non-HTTP redirects

Browsers support more ways to do redirects that sometimes make life
complicated to a curl user as these methods are not supported or recognized by
curl.

## HTML redirects

If the above was not enough, the web world also provides a method to redirect
browsers by plain HTML. See the example `<meta>` tag below. This is somewhat
complicated with curl since curl never parses HTML and thus has no knowledge
of these kinds of redirects.

    <meta http-equiv="refresh" content="0; url=http://example.com/">

## JavaScript redirects

The modern web is full of JavaScript and as you know, JavaScript is a language
and a full runtime that allows code to execute in the browser when visiting
websites.

JavaScript also provides means for it to instruct the browser to move on to
another site - a redirect, if you will.
