# Scheme

URLs start with the "scheme", which is the official name for the `http://`
part. That tells which protocol the URL uses. The scheme must be a known one
that this version of curl supports or it will show an error message and
stop. Additionally, the scheme must neither start with nor contain any
whitespace.

## The scheme separator

The scheme identifier is separated from the rest of the URL by the `://`
sequence. That is a colon and two forward slashes. There exists URL formats
with only one slash, but curl does not support any of them. There are two
additional notes to be aware of, about the number of slashes:

curl allows some illegal syntax and tries to correct it internally; so it will
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

## Without scheme

As a convenience, curl also allows users to leave out the scheme part from
URLs. Then it guesses which protocol to use based on the first part of the
host name. That guessing is basic, as it just checks if the first part of the
host name matches one of a set of protocols, and assumes you meant to use that
protocol. This heuristic is based on the fact that servers traditionally used
to be named like that. The protocols that are detected this way are FTP, DICT,
LDAP, IMAP, SMTP and POP3. Any other host name in a scheme-less URL will make
curl default to HTTP.

For example, this gets a file from an FTP site:

    curl ftp.funet.fi/README
    
While this gets data from a HTTP server:

    curl example.com

You can modify the default protocol to something other than HTTP with the
`--proto-default` option.
