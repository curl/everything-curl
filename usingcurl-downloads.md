## Downloads

"Download" means getting data from a server on a network, and the server is
then clearly considered to be above you. Load data down from the server to
your machine where you're running curl.

Downloading is probably the most common use case for curl. Get the specific
data onto your machine, pointed out by a URL.

### What exactly is downloaded?

You specify the resource to download by giving curl a URL. curl defaults to
downloading a URL unless told otherwise. The URL identifies what to
download. In this example the URL to download is "https://example.com":

    $ curl http://example.com

The URL is broken down into its individual components ([as explained
elsewhere](cmdline-urls.md)), the correct server is contacted and is then
asked to deliver the specific resource - often a file. The server then
delivers the data, or it refuses or perhaps the client asked for the wrong
data and then that data is delivered.

A request for a resource is protocol specific so a FTP:// URL works
differently than a HTTP:// URL or an SFTP:// URL.

A URL without a path part, that is a URL that has a host name part only like
the "http://example.com" example above, will get a slash ('/') appended to it
internally and then that is the resource curl will ask for from the server.

If you specify multiple URLs on the command line, curl will download each URL
one by one. It won't start the second transfer until the first one is complete
etc.

### Storing downloads

If you try the example download as in the previous section, you'll notice that
curl will output the downloaded data to stdout unless told to do something
else. Outputting data to stdout is really useful when you want to pipe it into
another program or similar, but it is not always the optimial way to deal with
your downloads.

Tell curl a specific file name to save the download in with `-o [filename]`
(with "--output" as the long version of the option), where filename is either
just a file name, a relative path to a file name or a full path to the file.

Also note that you can put the -o before or after the URL, it makes no
difference.

    $ curl -o output.html http://example.com/
    $ curl -o /tmp/index.html http://example.com/
    $ curl http://example.com -o ../../folder/savethis.html

This is of course not limited to http:// URLs but works the same way no matter
which URL you download:

    $ curl -o file.txt ftp://example.com/path/to/file-name.ext

curl has several other ways to store and name the downloaded data. Details
follow!

### -O

Many URLs however already contain the file name part in the rightmost
end. curl lets you use that as a shortcut so you don't have to repeat it with
-o. So instead of:

    $ curl -o file.html http://example.com/file.html

You can save the remove URL resource into the local file 'file.html' with this:

    $ curl -O http://example.com/file.html

This is the `-O` (upperase letter o) option, or --remote-name for the long
name version. The -O option selects the local file name to use by picking the
file name part of the URL that you provide. This is important. You specify the
URL and curl picks the name from this data. If the site redirects curl further
(and if you tell curl to follow redirects), it doesn't change the file name
curl will use for storing this.

### -J

HTTP servers have the option to provide a header named `Content-Disposition:`
in responses. That header may contain a suggested file name for the contents
delivered, and curl can be told to use that hint to name its local file. The
`-J / --remote-header-name` enables this, if you also use the -O option - and
it then makes curl use the file name from the URL by default and only *if*
there's actually a valid Content-Disposition header arriving, it switches to
saving using that name.

-J has some problems and risks associated with it that users need to be aware
of:

1. it will only use the rightmost part of the suggested file name, so any path
or directories the server suggests will be stripped out.

2. since the file name is entirely selected by the server, curl will of course
overwrite any preexisting local file in your current directory if you use -J
and the server happens to use such a file name.

3. file name encoding and character sets. curl does not decode the name in any
way, so you may end up with a URL encoded file name where a brower would
otherwise decode it to something more readable using a for you a sensible
character set.

### --compressed

TBD

### shell redirects

TBD

### Several downloads

TBD

### --remote-name-all

TBD

### "my browser shows something else"

A very common use case is using curl to get a URL that you can get in your
browser when you paste the URL in the browser's address bar.

But a browser getting a URL does so much more and in so many different ways
than curl, so what curl shows in your terminal output is probably not at all
what you see in your browser window.

TBD
