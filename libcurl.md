# 9. Using libcurl

The engine in the curl command line tool is libcurl. libcurl is also the
engine for hundreds ands thousands of tools, services and applications out
there today that want to do internet data transfers.

We have designed libcurl to be "transfer-oriented" usually without forcing
users to be protocol experts or in fact know much at all about the networking
or the protocols involved. That said, networking and protocols are areas with
lots of pitfalls and special cases so the more you know about these things,
the more you'll be able to understand about libcurl's options and ways of
workings. Not to mention when you're debugging and need yto understand what to
do next when things don't go as you intended them.

## Basic design

The fundamentals you need to lear with libcurl: first you create an "easy
handle", which is your handle to a transfer really. Then you set options for
that handle, that controls how the upcoming transfer will pan out and finally
you fire off the transfer. After the transfer has completed, you can figure
out if it succeeded or not and you can extract stats and various informations
that libcurl gathered during the transfer.

The actual "perform the transfer phase" can be done using sifferent different
means and function calls, depending on what kind of behavior you want in your
application and how libcurl is best integrated into your architecture.

## curl --libcurl

We actively encourage users to first try out the transfer they want to do with
the curl command line tool, and once it works roughly the way you want it to
you append the `--libcurl [filename]` option to the command line and run it
again.

The `--libcurl` command line option will create a C program in the provided
file name. That C program is an application that uses libcurl to run the
transfer you just had the curl command line tool do. Sure there are some
exceptions and it isn't always a 100% match, but you will find that it can
serve as an excellent inspiration source for what libcurl options you want or
can use and what additional arguments to provide to them.

If you specify the filename as a single dash, as in `--libcurl -` you will get
the program written to stdout instead of a file.

## CURL *handle

TBD

### curl_easy_setopt

TBD

## HTTP Cookies

TBD

## HTTP multipart formposts

TBD

## Connection reuse

TBD

## Callbacks

TBD

### Write callback

TBD

### Read callback

TBD

### Progress callbacks

TBD

### Header callback

TBD

### Debug callback

TBD

### SSL context callback

TBD

### ioctl and seek callbacks

TBD

### Convert to and from network callbacks

TBD

### Convert from UTF8 callback

TBD

### Sockopt callback

TBD

### Opensocket and closesocket callbacks

TBD

### SSH key callback

TBD

### RTSP interleave callback

TBD

### FTP chunk callbacks

TBD

### FTP matching callback

TBD

## Easy API

TBD

### Easy examples

TBD

## Multi API

TBD

### Multi examples

TBD

## multi_socket API

TBD

### multi_socket examples

TBD

## Common mistakes

TBD

## When things don't run the way you thought they would

TBD
