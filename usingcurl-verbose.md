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

Ok so we invoked curl with a URL that it considers incomplete so it helps us
and it adds a trailing slash before it moves on.

    *   Trying 93.184.216.34...

This tells us curl now tries to connect to this IP address. It means the name
'example.com' has been resolved to one or more addresses and this is the first
(and possibly only) address curl will try to connect to.

    * Connected to example.com (93.184.216.34) port 80 (#0)

It worked! curl connected to the site and here it explains how the name maps
to the IP address and on which port it has connected to. The '(#0)' part is
which internal number curl has given this connection. If you try multiple URLs
in the same command line you can see it use more connections or reuse
connections, so the connection counter may increase or not increase
depending on what curl decides it needs to do.

If we use an HTTPS:// URL instead of an HTTP one, there will also be a whole
bunch of lines explaining how curl uses CA certs to verify the server's
certificate and some details from the server's certificate, etc. Including
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

This is the full HTTP request to the site. This request is how it looks
in a default curl 7.45.0 installation and it may, of course, differ slightly
between different releases and in particular it will change if you add command
line options.

The last line of the HTTP request headers looks empty, and it is. It
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
headers—metadata—about the response. The first line's "200" might be the
most important piece of information in there and means "everything is fine".

The last line of the received headers is, as you can see, empty, and that is the
marker used for the HTTP protocol to signal the end of the headers.

After the headers comes the actual response body, the data payload. The
regular -v verbose mode does not show that data but only displays

    { [1270 bytes data]

That 1270 bytes should then be in the 'saved' file. You can also see that
there was a header named Content-Length: in the response that contained the
exact file length (it won't always be present in responses).

### --trace and --trace-ascii

There are times when `-v` is not enough. In particular, when you want to store
the complete stream including the actual transferred data.

For situations when curl does encrypted file transfers with protocols such as
HTTPS, FTPS or SFTP, other network monitoring tools (like Wireshark or
tcpdump) won't be able to do this job as easily for you.

For this, curl offers two other options that you use instead of `-v`.

`--trace [filename]` will save a full trace in the given file name. You can
also use '-' (a single minus) instead of a file name to get it passed to
stdout. You would use it like this:

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
microseconds in that second.

### HTTP/2

When doing file transfers using version two of the HTTP protocol, HTTP/2, curl
sends and receives **compressed** headers. So to display outgoing and incoming
HTTP/2 headers in a readable and understandable way, curl will actually show
the uncompressed versions in a style similar to how they appear with HTTP/1.1.

### --write-out

This is one of the often forgotten little gems in the curl arsenal of command
line options. `--write-out` or just `-w` for short, writes out information
after a transfer has completed and it has a large range of variables that you
can include in the output, variables that have been set with values and
information from the transfer.

You tell curl to write a string just by passing that string to this option:

    curl -w "formatted string" http://example.com/

…and you can also have curl read that string from a given file instead if
you prefix the string with '@':

    curl -w @filename http://example.com/

…or even have curl read the string from stdin if you use '-' as filename:

    curl -w @- http://example.com/

The variables that are available are accessed by writing `%{variable_name}` in
the string and that variable will then be substituted by the correct value. To
output a normal '%' you just write it as '%%'. You can also output a newline
by using '\n', a carriage return with '\r' and a tab space with '\t'.

(The %-symbol is special on the Windows command line, where all occurrences of
% must be doubled when using this option.)

As an example, we can output the Content-Type and the response code from an
HTTP transfer, separated with newlines and some extra text like this:

    curl -w "Type: %{content_type}\nCode: %{response_code}\n" http://example.com

This feature writes the output to stdout so you probably want to make sure
that you don't also send the downloaded content to stdout as then you might
have a hard time to separate out the data.

#### Available --write-out variables

Some of these variables are not available in really old curl versions.

- %{content_type} shows the Content-Type of the requested document, if there
  was any.

- %{filename_effective} shows the ultimate filename that curl writes out
  to. This is only meaningful if curl is told to write to a file with the
  `--remote-name` or `--output` option. It's most useful in combination with
  the `--remote-header-name` option.

- %{ftp_entry_path} shows the initial path curl ended up in when logging on to
  the remote FTP server.

- %{response_code} shows the numerical response code that was found in the
  last transfer.

- %{http_connect} shows the numerical code that was found in the last response
  (from a proxy) to a curl CONNECT request.

- %{local_ip} shows the IP address of the local end of the most recently done
  connection—can be either IPv4 or IPv6

- %{local_port} shows the local port number of the most recently made
   connection

- %{num_connects} shows the number of new connects made in the recent transfer.

- %{num_redirects} shows the number of redirects that were followed in the
   request.

- %{redirect_url} shows the actual URL a redirect *would* take you to when an
   HTTP request was made without `-L` to follow redirects.

- %{remote_ip} shows the remote IP address of the most recently made
  connection—can be either IPv4 or IPv6.

- %{remote_port} shows the remote port number of the most recently made
   connection.

- %{size_download} shows the total number of bytes that were downloaded.

- %{size_header} shows the total number of bytes of the downloaded headers.

- %{size_request} shows the total number of bytes that were sent in the HTTP
  request.

- %{size_upload} shows the total number of bytes that were uploaded.

- %{speed_download} shows the average download speed that curl measured for
  the complete download in bytes per second.

- %{speed_upload} shows the average upload speed that curl measured for the
  complete upload in bytes per second.

- %{ssl_verify_result} shows the result of the SSL peer certificate
  verification that was requested. 0 means the verification was successful.

- %{time_appconnect} shows the time, in seconds, it took from the start until
  the SSL/SSH/etc connect/handshake to the remote host was completed.

- %{time_connect} shows the time, in seconds, it took from the start until the
  TCP connect to the remote host (or proxy) was completed.

- %{time_namelookup} shows the time, in seconds, it took from the start until
  the name resolving was completed.

- %{time_pretransfer} shows the time, in seconds, it took from the start until
  the file transfer was just about to begin. This includes all pre-transfer
  commands and negotiations that are specific to the particular protocol(s)
  involved.

- %{time_redirect} shows the time, in seconds, it took for all redirection
  steps including name lookup, connect, pretransfer and transfer before the
  final transaction was started. time_redirect shows the complete execution
  time for multiple redirections.

- %{time_starttransfer} shows the time, in seconds, it took from the start
  until the first byte was just about to be transferred. This includes
  time_pretransfer and also the time the server needed to calculate the
  result.

- %{time_total} shows the total time, in seconds, that the full operation
  lasted. The time will be displayed with millisecond resolution.

- %{url_effective} shows the URL that was fetched last. This is particularly
  meaningful if you have told curl to follow Location: headers (with `-L`).

### Silence

The opposite of verbose is, of course, to make curl more silent. With the `-s`
(or `--silent`) option you make curl switch off the progress meter and not
output any error messages for when errors occur. It gets mute. It will still
output the downloaded data you ask it to.

With silence activated, you can ask for it to still output the error message on
failures by adding `-S` or `--show-error`.
