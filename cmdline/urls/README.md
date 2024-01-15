# URLs

curl is called curl because a substring in its name is URL (Uniform Resource
Locator). It operates on URLs. URL is the name we casually use for the web
address strings, like the ones we usually see prefixed with `HTTP://` or
starting with www.

URL is, strictly speaking, the former name for these. URI (Uniform Resource
Identifier) is the more modern and correct name for them. The syntax is
defined in [RFC 3986](https://www.ietf.org/rfc/rfc3986.txt).

Where curl accepts a “URL” as input, it is then really a “URI”. Most of the
protocols curl understands also have a corresponding URI syntax document that
describes how that particular URI format works.

* [Scheme](scheme.md)
* [Name and password](auth.md)
* [Host](host.md)
* [Port number](port.md)
* [Path](path.md)
* [Query](query.md)
* [FTP type](ftptype.md)
* [Fragment](fragment.md)
* [Browsers](browsers.md)
* [Many options and URLs](options.md)
* [Connection reuse](connreuse.md)
* [Parallel transfers](parallel.md)
* [trurl](trurl.md)
