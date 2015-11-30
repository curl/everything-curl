## What does curl do?

cURL is a project and its primary purpose and focus is to make two products:

- curl, the command line tool

- libcurl the transfer library with a C API

Both the tool and the library do internet transfers for resources specified as
URLs using internet protocols.

Everything and anything that is related to internet protocol transfers can be
considered curl's business. Things that are not related to that should be
avoided and be left for other projects and products.

It could be important to also consider that curl and libcurl try to avoid
handling the actual data that is transferred. It has for example no knowledge
about HTML or anything else of the content that is popular to transfer over
HTTP, but it knows all about how to transfer such data over HTTP.

Both products are frequently used not only to drive thousands or millions
scripts and applications for an internet connection world, but also for a lot
of server testing, protocol fiddling and trying out new things.

The library is used in every imaginable sort of embedded device where internet
transfers are needed: car infotainment, televisions, blurayplayers, settop
boxes, printers, routers, game systems etc.

### Command line tool

Running curl from the command line, it was natural and Daniel never even
during a short moment considered anything else than that it would output data
on stdout, to the terminal, by default. The "everything is a pipe" mantra of
standard Unix philosophy was something Daniel believed in. curl is like 'cat'
or one of the other unix tools. It sends data to stdout to make it easy to
chain together with other tools to do what you want. That's also why virtually
all curl options that allow reading from a file or writing to a file, also
have the ability to select doing it to stdout or from stdin.

Following that style of what unix command line tools worked, it was also never
any question about that it should support multiple URLs on the command line.

### The library

TBD
