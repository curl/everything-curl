# Browsers

Browsers typically support and use a *different* URL standard than what curl
uses. Where curl uses RFC 3986 for guidance, the browsers use [the WHATWG URL
Specification](https://url.spec.whatwg.org/).

This is important because the two URL standards are not the same. They are not
completely compatible, even though in most daily use those differences rarely
show. Sometimes, a URL interpreted according to one of the specs will be
handled differently when interpreted by the other spec. As such, curl and
browsers do not always treat URLs the same way.

The WHATWG spec is also *changing* over time.

Since curl is developed to be able to do the same operations a browser can,
the curl URL parser has been slightly adjusted to cater to some of the
differences. For example it accepts spaces in the URL when read from incoming
HTTP headers and it accepts either one, two or three slashes as a separator
between the scheme and the hostname. That is why we sometimes say that curl's
parser is *RFC 3986+* compliant.

curl strives hard to not break existing behavior, which makes it still support
the URLs and the URL format it supported back in 1998. The browsers do not.

## Browsers' address bar

When you use a modern web browser, the address bar they tend to feature at the
top of their main windows are not using URLs or even URIs. They are in fact
mostly using IRIs, which is a superset of URIs to allow internationalization
like non-Latin symbols and more, but it usually goes beyond that, too, as they
tend to, for example, handle spaces and do magic things on percent encoding in
ways none of these mentioned specifications say a client should do.

The address bar is quite simply an interface for humans to enter and see
URI-like strings.

Sometimes the differences between what you see in a browser's address bar and
what you can pass into curl is significant.
