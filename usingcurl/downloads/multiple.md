# Multiple downloads

As curl can be told to download many URLs in a single command line, there are,
of course, times when you want to store these downloads in nicely named local
files.

The key to understanding this is that each download URL needs its own "storage
instruction". Without said "storage instruction", curl will default to sending
the data to stdout. If you ask for two URLs and only tell curl where to save
the first URL, the second one is sent to stdout. Like this:

    curl -o one.html http://example.com/1 http://example.com/2

The "storage instructions" are read and handled in the same order as the
download URLs so they do not have to be next to the URL in any way. You can
round up all the output options first, last or interleaved with the URLs. You
choose.

These examples all work the same way:

    curl -o 1.txt -o 2.txt http://example.com/1 http://example.com/2
    curl http://example.com/1 http://example.com/2 -o 1.txt -o 2.txt
    curl -o 1.txt http://example.com/1 http://example.com/2 -o 2.txt
    curl -o 1.txt http://example.com/1 -o 2.txt http://example.com/2

The `-O` is similarly just an instruction for a single download so if you
download multiple URLs, use more of them:

    curl -O -O http://example.com/1 http://example.com/2
