# What exactly is downloading?

You specify the resource to download by giving curl a URL. curl defaults to
downloading a URL unless told otherwise, and the URL identifies what to
download. In this example the URL to download is `http://example.com`:

    curl http://example.com

The URL is broken down into its individual components
([as explained elsewhere](../../cmdline/urls/)), the correct server is
contacted and is then asked to deliver the specific resource—often a file. The
server then delivers the data, or it refuses or perhaps the client asked for
the wrong data and then that data is delivered.

A request for a resource is protocol-specific so an `FTP://` URL works
differently than an `HTTP://` URL or an `SFTP://` URL.

A URL without a path part, that is a URL that has a hostname part only (like
the `http://example.com` example above) gets a slash ('/') appended to it
internally and then that is the resource curl asks for from the server.

If you specify multiple URLs on the command line, curl downloads each URL one
by one. It does not start the second transfer until the previous one is
complete, etc.
