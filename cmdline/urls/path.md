# Path

Every URL contains a path. If there is none given, `/` is implied. For example
when you use just the host name like in:

    curl https://example.com

The path is sent to the specified server to identify exactly which resource
that is requested or that will be provided.

The exact use of the path is protocol dependent. For example, getting a file
README from the default anonymous user from an FTP server:

    curl ftp://ftp.example.com/README

For the protocols that have a directory concept, ending the URL with a
trailing slash means that it is a directory and not a file. Thus asking for a
directory list from an FTP server is implied with such a slash:

    curl ftp://ftp.example.com/tmp/
