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
differently than an HTTP:// URL or an SFTP:// URL.

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
(with `--output` as the long version of the option), where filename is either
just a file name, a relative path to a file name or a full path to the file.

Also note that you can put the `-o` before or after the URL, it makes no
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
`-o`. So instead of:

    $ curl -o file.html http://example.com/file.html

You can save the remove URL resource into the local file 'file.html' with this:

    $ curl -O http://example.com/file.html

This is the `-O` (upperase letter o) option, or `--remote-name` for the long
name version. The -O option selects the local file name to use by picking the
file name part of the URL that you provide. This is important. You specify the
URL and curl picks the name from this data. If the site redirects curl further
(and if you tell curl to follow redirects), it doesn't change the file name
curl will use for storing this.

### -J

HTTP servers have the option to provide a header named `Content-Disposition:`
in responses. That header may contain a suggested file name for the contents
delivered, and curl can be told to use that hint to name its local file. The
`-J / --remote-header-name` enables this, if you also use the `-O` option -
and it then makes curl use the file name from the URL by default and only *if*
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

### Compression

curl allows you to ask HTTP and HTTPS servers to provide compressed versions
of the URL and then perform automatic decompression of it on arrival. In
situations where bandwidth is more limited than CPU this will help you receive
more data in a shorter amount of time.

HTTP compression can be done using two different mechanisms. One which might
be considered "The Right Way" and the other that is the way that everyone is
using and is the widespread and popular way to do it! The common way to
compress HTTP content is using the Content-Encoding header. You ask curl to
use this with the `--compressed` option.

    $ curl --compressed http://example.com/

With this option enabled and if the server support it, it delivers the data in
a compressed way and curl will decompress it before saving it or sending it to
stdout. This usually means that as a user you don't really see or experience
the compression other than possibly a faster transfer.

The `--compressed` option asks Content-Encoding compression using one of the
supported compression algorithms. There's also the rarer Tranfer-Encoding
method, which is the method that was created for this automated method but was
never really widely adopted. You can tell curl to ask for tranfer-encoded
compression with `--tr-encoding`:

    $ curl --tr-encoding http://example.com/

In theory there's nothing that prevents you from using both in the same
command line, although in practise you may then experience that some servers
get a little confused when ask to compress in two different ways. It's
generally safer to just pick one.

### shell redirects

When you invoke curl from a shell or some other command line prompt system,
that environment generally provide you with a set of output redirection
abilities. In most linux and unix shell, and with Windows' command prompts,
you direct stdout to a file with `> filename`. Using this of course makes the
use of -o or -O superfluous.

    $ curl http://example.com/ > example.html

Redirecting output to a file redirects all output from curl to that file, so
even if you ask to transfer more than one URL to stdout, directing the output
will get all the URLs output stored in that single file.

    $ curl http://example.com/1 http://example.com/2 > files

Unix shells usually allow you to redirect the *stderr* stream separately. The
stderr stream is usually a stream that also gets shown in the terminal but you
can redirect it separately from the stdout stream. The stdout stream is for
the data while stderr is meta data and errors etc that aren't data. You can
redirect stderr with `2>file` like this:

    $ curl http://example.com > files.html 2>errors

### several downloads

As curl can be told to download many URLs in a single command line, there are
of course times when you want to store these downloads in nicely named local
file names.

The key to understanding this is that each download URL needs its own "storage
instruction". Without said "storage instruction", curl will default to sending
the data to stdout. If you ask for two URLs and only tell curl where to save
the first URL, the second one is sent to stdout. Like this:

    $ curl -o one.html http://example.com/1 http://example.com/2

The "storage instructions" are read and handled in the same order as the
download URLs so they don't have to be next to the URL in any way. You can
round up all the output options first, last or interleaved with the URLs. You
choose!

These examples all work the same way:

    $ curl -o 1.txt -o 2.txt http://example.com/1 http://example.com/2
    $ curl http://example.com/1 http://example.com/2 -o 1.txt -o 2.txt
    $ curl -o 1.txt http://example.com/1 http://example.com/2 -o 2.txt
    $ curl -o 1.txt http://example.com/1 -o 2.txt http://example.com/2

The `-O` is similarly just an instruction for a single download so if you
download multiple URLs, use more of them:

    $ curl -O -O http://example.com/1 http://example.com/2

### --remote-name-all

As a reaction to use two think adding a hundred `-O` options when using a
hundred URLs, we introduced an option called `--remote-name-all`. This makes
`-O` the default operation for all given URLs. You can still provide
individual "storage instructions" for URLs but if you leave one out for a URL
that gets downloaded, the default action is then switched from stdout to -O
style.

### "my browser shows something else"

A very common use case is using curl to get a URL that you can get in your
browser when you paste the URL in the browser's address bar.

But a browser getting a URL does so much more and in so many different ways
than curl, so what curl shows in your terminal output is probably not at all
what you see in your browser window.

#### Client differences

Curl only gets exactly what you ask it to get and it never parses the actual
content, the data, that the server delivers. A browser gets data and it
activates different parsers depending on what kind of content it thinks it
gets. For example, if the data is HTML it will parse it to display a web page
and possibly download other sub resources such as images, javascript and CSS
files. When curl downloads a HTML it will just get that single HTML resources,
even if it when parsed by a browser would cause a whole busload of more
downloads. If you want curl to download any subresources as well, you need to
pass those URLs to curl and ask it to get those, just like any other URLs.

Clients also differ in how they send their requests, and some aspects of a
requests for a resource includes for example format perferences, asking for
compressed data or just telling the server from which previous page we're
"coming from". curl's requests will differ a little or a lot from how your
browser sends its requests.

#### Server differences

The server that receives the request and deliver data is often setup to act in
certain ways depending on what kind of client it thinks communicates with it.
Sometimes it is as innocent as trying to deliver the best content for the
client, sometimes it is to hide some content for some content or even to try
to work-around known problems in specific browsers. Then there's also of
course various kind of login systems that might rely on HTTP authentication or
cookies or the client being from the pre-validated IP address range.

Sometimes getting the same response from a server using curl as the response
you get with a browser ends up really hard work. Users then typically record
their browser sessions with the browser's networking tools and then compare
that recording with recorded data with curl's `--trace-ascii` option and the
proceed to modify curl's requests (often with `-H / --header`) until the
server starts to respond the same to both.

This type of work can be both time consuming and tedious. You should always do
this with permission from the server owners or admins.

#### Intermediaries fiddlings

Intermediaries are proxies, explicit or implicit ones. Some environments will
force you to use one or you may choose to use one for various reasons, but
there are also the transparent ones that will intercept your network traffic
silently and proxy it for you no matter what you want.

Proxies are "middle men" that terminates the traffic and then acts on your
behalf to the remote server. This can introduce all sorts of explicit
filtering and "saving" you from certain content or even "protecting" the
remote server from what data you try to send to it, but even more so it
introduces another software's view on how the protocol works and what the
right things to do are.

Interfering intermediaries are often the cause of lots of head aches and
mysteries down to downright malicious modifications of content.

We strongly encourage you to use HTTPS or other means to verify that the
contents you're downloading or uploading is really the data that the remote
server has sent to you or that your precious bytes end up verbatim at the
intended destination.

### Rate limiting

TBD

### Maximum filesize

--max-filesize

TBD

### Metalink

--metalink

TBD

### --xattr

TBD
