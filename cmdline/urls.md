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

* [Scheme](urls/scheme.md)
* [Name and password](urls/auth.md)
* [Host](urls/host.md)
* [Port number](urls/port.md)
* [Path](urls/path.md)
* [Query](urls/query.md)
* [FTP type](urls/ftptype.md)
* [Fragment](urls/fragment.md)
* [Browsers](urls/browsers.md)
* [Many options and URLs](urls/options.md)
* [Connection reuse](urls/connreuse.md)
* [Parallel transfers](urls/parallel.md)
* [trurl](urls/trurl.md)
