## Verbose mode

If your curl command doesn't execute or return what you expected it to, your
first gut reaction should always be to run the command with the `-v /
--verbose` option to get more information.

When verbose mode is enabled, curl gets more talkative and will explain and
show a lot more of its doings. It will add informational tests and prefix them
with '*'. For example, let's see what curl might say when trying a simple HTTP
example (saving the downloaded data in the file called 'saved'):

   $ curl -v http://example.com -o saved
   * Rebuilt URL to: http://example.com/

Ok so we invoked curl with a URL that it considers a incomplete so it helps us
and it adds a trailing slash before it moves on.

   *   Trying 93.184.216.34...

This tells us curl now tries to connect to this IP address. It means the name
'example.com' has been resolved to one or more addresses and this is the first
(and possibly only) address curl will try to connect to.

   * Connected to example.com (93.184.216.34) port 80 (#0)

It worked. curl connected to the site and here it explains how the name maps
to the IP address and on which port it has connected to. The '(#0)' part is
which internal number curl has given this connection. If you try multiple URLs
in the same command line you can see it use more connections, or reuse
connections and then the connection counter may increase or not increase
depending on what curl decides it needs to do.

If we use a HTTPS:// URL instead of a HTTP one, there will also be a whole
bunch of lines explaining how curl uses CA certs to verify the server's
certificate and some details from the server's certificate etc. Including
which ciphers were selected and more TLS details.

In addition to the added information given from curl internals, the -v verbose
mode will also make curl show all headers it sends and receives. For protocols
without headers (like FTP, SMTP, POP3 and so on), we can consider commands and
responses as headers and they will thus also be shown with -v.

If we then continue the output seen from the command above (but ignore the
actual HTML response), curl will show:

    > GET / HTTP/1.1
    > Host: example.com
    > User-Agent: curl/7.45.0
    > Accept: */*
    >

This is the full HTTP request to the site. This request is how it looks like
in a default curl 7.45.0 installation and it may of course differ slightly
between different releases and in particular it will change if you add command
line options.

The last line of the HTTP request headers looks empty, and it is. It usually
signals the separation between the headers and the body, and in this request
there is no "body" to send.

Moving on and assuming everything goes according to plan, the sent request
will get a corresponding response from the server and that HTTP response will
start with a set of headers before the response body:

    < HTTP/1.1 200 OK
    < Accept-Ranges: bytes
    < Cache-Control: max-age=604800
    < Content-Type: text/html
    < Date: Sat, 19 Dec 2015 22:01:03 GMT
    < Etag: "359670651"
    < Expires: Sat, 26 Dec 2015 22:01:03 GMT
    < Last-Modified: Fri, 09 Aug 2013 23:54:35 GMT
    < Server: ECS (ewr/15BD)
    < Vary: Accept-Encoding
    < X-Cache: HIT
    < x-ec-custom-error: 1
    < Content-Length: 1270
    <

This may look mostly like mumbo jumbo to you, but this is normal set of HTTP
headers, meta-data, about the response. The first line's "200" might be the
most important piece of information in there and means "everything is fine".

The last line of the received headers is as you can see empty, and that is the
marker used for the HTTP protocol to signal the end of the headers.

After the headers comes the actual response body, the data payload. The
regular -v verbose mode does not show that data but only displays

    { [1270 bytes data]

That 1270 bytes should then be in the 'saved' file. You can also see that
there was a header named Content-Length: in the response that contained the
exact file length. (It won't always be present in responses.)

### --trace and --trace-ascii

There are times when `-v` is not enough. In particular when you want to store
the complete stream, including the actual transfered data.

For situations when curl does encrypted file transfers with protocols such as
HTTPS, FTPS or SFTP, other network monitoring tools (like Wireshark or
tcpdump) won't be able to do this job as easily for you.

For this, curl offers two other options that you use instead of `-v`.

`--trace [filename]` will save a full trace in the given file name. You can
also use '-' (a single minus) instead of a file name to get it passed to
stdout. You'd use it like this:

    $ curl --trace dump http://example.com

When completed, there's a 'dump' file that can turn out pretty sizable. In
this case, the 15 first lines of the dump file looks like:

    == Info: Rebuilt URL to: http://example.com/
    == Info:   Trying 93.184.216.34...
    == Info: Connected to example.com (93.184.216.34) port 80 (#0)
    => Send header, 75 bytes (0x4b)
    0000: 47 45 54 20 2f 20 48 54 54 50 2f 31 2e 31 0d 0a GET / HTTP/1.1..
    0010: 48 6f 73 74 3a 20 65 78 61 6d 70 6c 65 2e 63 6f Host: example.co
    0020: 6d 0d 0a 55 73 65 72 2d 41 67 65 6e 74 3a 20 63 m..User-Agent: c
    0030: 75 72 6c 2f 37 2e 34 35 2e 30 0d 0a 41 63 63 65 url/7.45.0..Acce
    0040: 70 74 3a 20 2a 2f 2a 0d 0a 0d 0a                pt: */*....
    <= Recv header, 17 bytes (0x11)
    0000: 48 54 54 50 2f 31 2e 31 20 32 30 30 20 4f 4b 0d HTTP/1.1 200 OK.
    0010: 0a                                              .
    <= Recv header, 22 bytes (0x16)
    0000: 41 63 63 65 70 74 2d 52 61 6e 67 65 73 3a 20 62 Accept-Ranges: b
    0010: 79 74 65 73 0d 0a                               ytes..

Every single sent and received byte get displayed individually in hexadecimal
numbers.

If you think the hexadecimals aren't helping, you can try `--trace-ascii
[filename]` instead, also this accepting '-' for stdout and that makes the 15
first lines of tracing look like:

    == Info: Rebuilt URL to: http://example.com/
    == Info:   Trying 93.184.216.34...
    == Info: Connected to example.com (93.184.216.34) port 80 (#0)
    => Send header, 75 bytes (0x4b)
    0000: GET / HTTP/1.1
    0010: Host: example.com
    0023: User-Agent: curl/7.45.0
    003c: Accept: */*
    0049: 
    <= Recv header, 17 bytes (0x11)
    0000: HTTP/1.1 200 OK
    <= Recv header, 22 bytes (0x16)
    0000: Accept-Ranges: bytes
    <= Recv header, 31 bytes (0x1f)
    0000: Cache-Control: max-age=604800

### --trace-time

This options prefixes all verbose/trace outputs with a high resolution timer
for when the line is printed. It works with the regular `-v / --verbose`
option as well as with `--trace` and `--trace-ascii`.

An example could look like this:

    $ curl -v --trace-time http://example.com
    23:38:56.837164 * Rebuilt URL to: http://example.com/
    23:38:56.841456 *   Trying 93.184.216.34...
    23:38:56.935155 * Connected to example.com (93.184.216.34) port 80 (#0)
    23:38:56.935296 > GET / HTTP/1.1
    23:38:56.935296 > Host: example.com
    23:38:56.935296 > User-Agent: curl/7.45.0
    23:38:56.935296 > Accept: */*
    23:38:56.935296 > 
    23:38:57.029570 < HTTP/1.1 200 OK
    23:38:57.029699 < Accept-Ranges: bytes
    23:38:57.029803 < Cache-Control: max-age=604800
    23:38:57.029903 < Content-Type: text/html
    ---- snip ----

The lines are all the local time as hours:minutes:seconds and then number of
miroseconds in that second.

### --write-out

TBD
