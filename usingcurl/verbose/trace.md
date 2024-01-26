# Trace options

There are times when `-v` is not enough. In particular, when you want to store
the complete stream including the actual transferred data.

For situations when curl does encrypted file transfers with protocols such as
HTTPS, FTPS or SFTP, other network monitoring tools (like Wireshark or
tcpdump) are not able to do this job as easily for you.

For this, curl offers two other options that you use instead of `-v`.

`--trace [filename]` saves a full trace in the given filename. You can also
use '-' (a single minus) instead of a filename to get it passed to stdout. You
would use it like this:

    $ curl --trace dump http://example.com

When completed, there is a 'dump' file that can turn out pretty sizable. In
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

Every single sent and received byte gets displayed individually in hexadecimal
numbers. Received headers are output line by line.

If you think the hexadecimals are not helping, you can try `--trace-ascii
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

## Time stamps

The `--trace-time` option prefixes all verbose/trace outputs with a high
resolution timer for when the line is printed. It works with the regular `-v /
--verbose` option as well as with `--trace` and `--trace-ascii`.

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

## Identify transfers and connections

As the trace information flow showing on screen or to a file using these
options is a continuous stream even though your command line might make curl
use a large number of separate connections and different transfers, there are
times when you want to see to which specific transfers or connections the
various information below to. To better understand the trace output.

You can then add `--trace-ids` to the line and you see how curl adds two
numbers to all tracing: the connection number and the transfer number. They
are two separate identifiers because connections can be reused and multiple
transfers can use the same connection.

## More data

If the amount of tracing data is not enough. Like when you suspect and want to
debug a problem in a more fundamental lower protocol level, curl provides the
`--trace-config` option for you.

With this option you tell curl to also include logging about components that
it otherwise does not include by default, such as details about TLS, HTTP/2 or
HTTP/3 protocol bits. It also has convenience options for adding the
connection and transfer identifiers and time stamps.

The `--trace-config` option accepts an argument where you specify a
comma-separated list with the areas you want it to trace. For example, include
identifiers and show me HTTP/2 details:

    curl --trace-config ids,http/2 https://example.com

The exact set of options varies, but here are some ones to try:

| area     | description                                     |
|----------|-------------------------------------------------|
| `ids`    | the same identifiers as `--trace-ids` provides  |
| `time`   | the same time output as `--trace-time` provides |
| `all`    | show everything possible                        |
| `tls`    | TLS protocol exchange details                   |
| `http/2` | HTTP/2 frame information                        |
| `http/3` | HTTP/3 frame information                        |
| `*`      | additional ones in future versions              |

Doing a quick run with `all` is often a good way to get to see which specific
areas that are shown, as then you can do follow-up runs with more specific
areas set.
