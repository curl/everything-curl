# URLs

curl is called curl because a substring in its name is URL (Uniform
Resource Locator). It operates on URLs. URL is the name we casually use for
the web address strings, like the ones we usually see prefixed with http:// or
starting with www.

URL is, strictly speaking, the former name for these. URI (Uniform Resource
Identifier) is the more modern and correct name for them. The syntax is
defined in [RFC 3986](https://www.ietf.org/rfc/rfc3986.txt).

Where curl accepts a “URL” as input, it is then really a “URI”. Most of the
protocols curl understands also have a corresponding URI syntax document that
describes how that particular URI format works.

curl assumes that you give it a valid URL and it only does limited checks of
the format in order to extract the information it deems necessary to perform
its operation. You can, for example, most probably pass in illegal characters
in the URL without curl noticing or caring and it will just pass them on.

* [Scheme](urls/scheme.md)
* [Name and password](urls/auth.md)
* [Host](urls/host.md)
* [Port number](urls/port.md)
* [Path](urls/path.md)
* [FTP type](urls/ftptype.md)
* [Fragment](urls/fragment.md)
* [Browsers' address bar](urls/browsers.md)
* [Many options and URLs](urls/options.md)
* [Connection reuse](urls/connreuse.md)
* [Parallel transfers](urls/parallel.md)
