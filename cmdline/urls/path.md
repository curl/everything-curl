# Path

Every URL contains a path. If there is none given, `/` is implied. For example
when you use just the hostname like in:

    curl https://example.com

The path is sent to the specified server to identify exactly which resource
that is requested or that is provided.

The exact use of the path is protocol dependent. For example, getting the file
`README` from the default anonymous user from an FTP server:

    curl ftp://ftp.example.com/README

For the protocols that have a directory concept, ending the URL with a
trailing slash means that it is a directory and not a file. Thus asking for a
directory list from an FTP server is implied with such a slash:

    curl ftp://ftp.example.com/tmp/

If you want a non-ASCII letter or maybe even space (` `) as part of the path
field, remember to "URL-encode" that letter: write it as `%HH` where `HH` is
the hexadecimal byte value. ` ` is `%20`.
