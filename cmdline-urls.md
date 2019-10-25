## URLs

curl is called curl because a substring in its name is URL (Uniform
Resource Locator). It operates on URLs. URL is the name we casually use for
the web address strings, like the ones we usually see prefixed with http:// or
starting with www.

URL is, strictly speaking, the former name for these. URI (Uniform Resource
Identifier) is the more modern and correct name for them. Their syntax is defined
in [RFC 3986](https://www.ietf.org/rfc/rfc3986.txt).

Where curl accepts a "URL" as input, it is then really a "URI". Most of the
protocols curl understands also have a corresponding URI syntax document that
describes how that particular URI format works.

curl assumes that you give it a valid URL and it only does limited checks of
the format in order to extract the information it deems necessary to perform
its operation. You can, for example, most probably pass in illegal characters in
the URL without curl noticing or caring and it will just pass them on.

### Scheme

URLs start with the "scheme", which is the official name for the `http://`
part. That tells which protocol the URL uses. The scheme must be a known one
that this version of curl supports or it will show an error message and
stop. Additionally, the scheme must neither start with nor contain any
whitespace.

### The scheme separator

The scheme identifier is separated from the rest of the URL by the `://`
sequence. That is a colon and two forward slashes. There exists URL formats
with only one slash, but curl does not support any of them. There are two
additional notes to be aware of, about the number of slashes:

curl allow some illegal syntax and try to correct it internally; so it will
also understand and accept URLs with one or three slashes, even though they
are in fact not properly formed URLs. curl does this because the browsers
started this practice so it has lead to such URLs being used in the wild every
now and then.

`file://` URLs are written as `file://<hostname>/<path>` but the only
hostnames that are okay to use are `localhost`, `127.0.0.1` or a blank
(nothing at all):

    file://localhost/path/to/file
    file://127.0.0.1/path/to/file
    file:///path/to/file

Inserting any other host name in there will make recent versions of curl to
return an error.

Pay special attention to the third example above
(`file:///path/to/file`). That is *three* slashes before the path. That is
again an area with common mistakes and where browsers allow users to use the
wrong syntax so as a special exception, curl on Windows also allows this
incorrect format:

    file://X:/path/to/file

… where X is a windows-style drive letter.

### Without scheme

As a convenience, curl also allows users to leave out the scheme part from
URLs. Then it guesses which protocol to use based on the first part of the
host name. That guessing is basic, as it just checks if the first part of the
host name matches one of a set of protocols, and assumes you meant to use that
protocol. This heuristic is based on the fact that servers traditionally used
to be named like that. The protocols that are detected this way are FTP, DICT,
LDAP, IMAP, SMTP and POP3. Any other host name in a scheme-less URL will make
curl default to HTTP.

You can modify the default protocol to something other than HTTP with the
`--proto-default` option.

### Name and password

After the scheme, there can be a possible user name and password embedded.
The use of this syntax is usually frowned upon these days since you easily
leak this information in scripts or otherwise. For example, listing the
directory of an FTP server using a given name and password:

    curl ftp://user:password@example.com/

The presence of user name and password in the URL is completely optional. curl
also allows that information to be provide with normal command-line options,
outside of the URL.

### Host name or address

The host name part of the URL is, of course, simply a name that can be resolved
to an numerical IP address, or the numerical address itself. When specifying a
numerical address, use the dotted version for IPv4 addresses:

    curl http://127.0.0.1/

…and for IPv6 addresses the numerical version needs to be within square
brackets:

    curl http://[::1]/

When a host name is used, the converting of the name to an IP address is
typically done using the system's resolver functions. That normally lets a
sysadmin provide local name lookups in the `/etc/hosts` file (or equivalent).

### Port number

Each protocol has a "default port" that curl will use for it, unless a
specified port number is given. The optional port number can be provided
within the URL after the host name part, as a colon and the port number
written in decimal. For example, asking for an HTTP document on port 8080:

    curl http://example.com:8080/

With the name specified as an IPv4 address:

    curl http://127.0.0.1:8080/

With the name given as an IPv6 address:

    curl http://[fdea::1]:8080/

### Path

Every URL contains a path. If there's none given, "/" is implied. The path is
sent to the specified server to identify exactly which resource that is
requested or that will be provided.

The exact use of the path is protocol dependent. For example, getting a file
README from the default anonymous user from an FTP server:

    curl ftp://ftp.example.com/README

For the protocols that have a directory concept, ending the URL with a
trailing slash means that it is a directory and not a file. Thus asking for a
directory list from an FTP server is implied with such a slash:

    curl ftp://ftp.example.com/tmp/

### FTP type

This is not a feature that is widely used.

URLs that identify files on FTP servers have a special feature that allows you
to also tell the client (curl in this case) which file type the resource
is. This is because FTP is a little special and can change mode for a transfer
and thus handle the file differently than if it would use another mode.

You tell curl that the FTP resource is an ASCII type by appending ";type=A"
to the URL. Getting the 'foo' file from example.com's root directory using ASCII
could then be made with:

    curl "ftp://example.com/foo;type=A"

And while curl defaults to binary transfers for FTP, the URL format allows you
to also specify the binary type with type=I:

    curl "ftp://example.com/foo;type=I"

Finally, you can tell curl that the identified resource is a directory if the
type you pass is D:

    curl "ftp://example.com/foo;type=D"

…this can then work as an alternative format, instead of ending the path
with a trailing slash as mentioned above.

### Fragment

URLs offer a "fragment part". That's usually seen as a hash symbol (#) and a
name for a specific name within a web page in browsers. curl supports
fragments fine when a URL is passed to it, but the fragment part is never
actually sent over the wire so it does not make a difference to curl's
operations whether it is present or not.

### Browsers' "address bar"

It is important to realize that when you use a modern web browser, the
"address bar" they tend to feature at the top of their main windows are not
using "URLs" or even "URIs". They are in fact mostly using IRIs, which is a
superset of URIs to allow internationalization like non-Latin symbols and
more, but it usually goes beyond that, too, as they tend to, for example, handle
spaces and do magic things on percent encoding in ways none of these mentioned
specifications say a client should do.

The address bar is quite simply an interface for humans to enter and see
URI-like strings.

Sometimes the differences between what you see in a browser's address bar and
what you can pass in to curl is significant.

## Many options and URLs

As mentioned above, curl supports hundreds of command-line options and it also
supports an unlimited number of URLs. If your shell or command-line system
supports it, there's really no limit to how long a command line you can pass
to curl.

curl will parse the entire command line first, apply the wishes from the
command-line options used, and then go over the URLs one by one (in a left to
right order) to perform the operations.

For some options (for example `-o` or `-O` that tell curl where to store the
transfer), you may want to specify one option for each URL on the command
line.

curl will return an exit code for its operation on the last URL used. If you
instead rather want curl to exit with an error on the first URL in the set
that fails, use the `--fail-early` option.

## Separate options per URL

In previous sections we described how curl always parses all options in the
whole command line and applies those to all the URLs that it transfers.

That was a simplification: curl also offers an option (-;, --next) that
inserts a sort of boundary between a set of options and URLs for which it will
apply the options. When the command-line parser finds a --next option, it
applies the following options to the next set of URLs. The --next option thus
works as a *divider* between a set of options and URLs. You can use as many
--next options as you please.

As an example, we do an HTTP GET to a URL and follow redirects, we then make a
second HTTP POST to a different URL and we round it up with a HEAD request to
a third URL. All in a single command line:

    curl --location http://example.com/1 --next
      --data sendthis http://example.com/2 --next
      --head http://example.com/3

Trying something like that _without_ the --next options on the command line
would generate an illegal command line since curl would attempt to combine
both a POST and a HEAD:

    Warning: You can only select one HTTP request method! You asked for both POST
    Warning: (-d, --data) and HEAD (-I, --head).

## Connection reuse

Setting up a TCP connection and especially a TLS connection can be a slow
process, even on high bandwidth networks.

It can be useful to remember that curl has a connection pool internally which
keeps previously used connections alive and around for a while after they were
used so that subsequent requests to the same hosts can reuse an already
established connection.

Of course, they can only be kept alive for as long as the curl tool is
running. It is a good reason for trying to get several transfers done
within the same command line instead of running several independent curl
command line invocations.

## Do the transfers in parallel

The default behavior of getting the specified URLs one by one in a serial
fashion makes it easy to understand exactly when each URL is fetched but it
can be slow.

Since version 7.66.0, curl offers the `-Z` (or `--parallel`) option that
instead instructs curl to attempt to do the specified transfers in a parallel
fashion. When this is enabled, curl will do a lot of transfers simultaneously
instead of serially. It will do up to 50 transfers at the same time and as
soon as one of them has completed, the next one will be kicked off.

For cases where you want to download many files from different sources and a
few of them might be slow, a few fast, this can speed things up tremendously.

If 50 parallel transfer is wrong for you, the `--parallel-max` option is there
to allow you to change that as well.

### Parallel transfer progress meter

Naturally, the ordinary progress meter display that shows file transfer
progress for a single transfer isn't that useful for parallel transfers so
when curl performs parallel transfers, it will show a different progress meter
that displays information about all the current ongoing transfers in a single
line.
