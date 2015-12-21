## Downloads

"Download" means getting data from a server on a network, and the server is
then clearly considered to be above you. Load data down from the server to
your machine where you're running curl.

Downloading is probably the most common use case for curl. Get the specific
data onto your machine, pointed out by a URL.

### What exactly is downloaded?

You specify the resource to download by giving curl a URL. The URL identifies
what to download.

   $ curl http://example.com

The URL is broken down into its individual components ([as explained
elsewhere](cmdline-urls.md)), the correct server is contacted and is then
asked to deliver the specific resource - often a file. The server then
delivers the data, or it refuses or perhaps the client asked for the wrong
data and then that data is delivered.

A request for a resource is protocol specific so a FTP:// URL works
differently than a HTTP:// URL or an SFTP:// URL.

A URL without a path part, that is that has a host name part only like the
"http://example.com" example above, will get a slash ('/') appended to it
internally and then that is the resource curl will ask for from the server.

If you specify multiple URLs on the command line, curl will download each URL
one by one. It won't start the second transfer until the first one is complete
etc.

### Storing downloads

-o

-O

-J

--compressed

'>' shell redirects

TBD

### Several downloads

TBD

### "my browser shows something else"

A very common use case is using curl to get a URL that you can get in your
browser when you paste the URL in the browser's address bar.

But a browser getting a URL does so much more and in so many different ways
than curl, so what curl shows in your terminal output is probably not at all
what you see in your browser window.

TBD
