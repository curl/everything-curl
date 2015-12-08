# 9. Using libcurl

The engine in the curl command line tool is libcurl. libcurl is also the
engine in thousands of tools, services and applications out there today,
performing their internet data transfers.

We have designed libcurl to be "transfer-oriented" usually without forcing
users to be protocol experts or in fact know much at all about the networking
or the protocols involved. That said, networking and protocols are areas with
lots of pitfalls and special cases so the more you know about these things,
the more you'll be able to understand about libcurl's options and ways of
workings. Not to mention when you're debugging and need to understand what to
do next when things don't go as you intended them.

The most basic libcurl using application can be as small as just a couple of
lines of code, but applications will of course need more code than so.

## Basic design

The fundamentals you need to learn with libcurl:

- First you create an "easy handle", which is your handle to a transfer
  really.

- Then you set several options for that handle, that controls how the upcoming
  transfer will pan out.

- Finally you fire off the transfer.

After the transfer has completed, you can figure out if it succeeded or not
and you can extract stats and various information that libcurl gathered
during the transfer.

The actual "perform the transfer phase" can be done using different different
means and function calls, depending on what kind of behavior you want in your
application and how libcurl is best integrated into your architecture. Those
are further described later in this chapter.

## API compatibility

TBD

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

## Header files

There is ever only one header your libcurl using application needs to include:

    #include <curl/curl.h>

That file in turn includes a few other public header files but you can
basically pretend they don't exist. (Historically speaking, we started out
slightly different but over time we've stabilized around this form of only
using a single one for includes.)

## Global initialization

Before you do anything libcurl related in your program, you should do a global
libcurl initialize call with `curl_global_init()`. This is necessary because
some underlying libraries that libcurl might be using need a call ahead to get
setup and inited properly.

curl_global_init() is unfortunately not thread safe so you must sure that you
only do it once and never simultaneously as another call. It initializes
global state so you should only call it once and once your program is
completely done using libcurl you can call `curl_global_cleanup()` to again
free and clean up the associated global resources the init call allocated.

libcurl is built to handle that you skip the `curl_global_init()` call, but it
does so by calling it itself instead if you didn't do it before any actual
file transfer starts and it then uses its own defaults. But beware that it is
still not thread safe even then so it might cause some "interesting" side
effects for you. It is much better to call curl_global_init() yourself in a
controlled manner.

## CURL *handle

The CURL handle is what we usually call an "easy handle". You create one with
`curl_easy_init()` and it is then your handle to a transfer.

    CURL *easy = curl_easy_init();

Of course at the point in time when you have created it, it is empty and it
doesn't know what transfer it should do. You must then set a few options for
it so that it knows what to do when you ask it to perform.

Also, when you use an easy handle to actually perform a transfer it will build
up and hold "state". It means it will keep information within the handle that
libcurl can use and find. By reusing an easy handle for example, libcurl can
reuse that information again.

When you're done with the handle, like if you've done your transfers and you
don't plan to do any more with this same handle, you need to free it to remove
and clean up all related resources. You do this with `curl_easy_cleanup()`. We
encourage applications to reuse handles as much as possible for performance
and efficiency purposes.

In case of problem (like perhaps out of memory), curl_easy_init() returns NULL
and that is of course a serious error for any application. You need to write
your program to take this risk into account.

## Set handle options

You set options in the easy handle to control how that transfer is going to be
done or in some cases you can actually set options and modify the transfer's
behavior while it is in progress. You set options with `curl_easy_setopt()`
and you provide the handle, the option you want to set and the argument to the
option. All options take exactly one argument and you must always pass exactly
three parameters to the curl_easy_setopt() calls.

Since the curl_easy_setopt() call accepts several hundred different options
and the various options accept a variety of different types of arguments, it
is very important to read up on the specifics and provide exactly the argument
type the specific option supports and expects. Passing in the wrong type can
lead to unexpected side-effects or hard to understand hiccups.

The perhaps most important option that every transfer needs, is the URL.
libcurl cannot perform a transfer without knowing which URL it concerns so you
must tell it. The URL option name is `CURLOPT_URL` as all options are prefixed
with `CURLOPT_` and then the descriptive name - all using uppercase
letters. An example line setting the URL to get the "http://example.com" HTTP
contents could look like:

    CURLcode ret = curl_easy_setopt(easy, CURLOPT_URL, "http://example.com");

Again: this only sets the option in the handle. It will not do the actual
transfer or anything. It will basically just tell libcurl to copy the string
and if that works it returns OK.

It is of course good form to check the return code to see that nothing went
wrong.

### Setting numerical options

Since curl_easy_setopt() is a vararg function where the 3rd argument can use
different types depending on the situation, normal C language type conversion
cannot be done. So you **must** make sure that you truly pass a 'long' and not
an 'int' if the documentation tells you so. On architectures where they are
the same size, you may not get any problems but not all work like
that. Similarly, for options that accept a 'curl_off_t' type, it is
**crucial** that you pass in an argument using that type and no other.

Enforce a long:

    curl_easy_setopt(handle, CURLOPT_TIMEOUT, 5L); /* 5 seconds timeout */

Enforce a curl_off_t:

    curl_off_t no_larger_than = 0x50000;
    curl_easy_setopt(handle, CURLOPT_MAXFILE_LARGE, no_larger_than);

## Get handle options

No, there's no general method to extract the same information you previously
set with `curl_easy_setopt()`! If you need to be able to extract the
information again that you set earlier, then we encourage you to keep track of
that data yourself in your application.

## CURLcode return code

Many libcurl functions return a CURLcode. That's a special libcurl typedefed
variable for error codes. It returns CURLE_OK (which has the value zero) if
everything is fine and dandy and it returns a non-zero number if a problem was
detected. There are almost one hundred `CURLcode` errors in use, and you can
find them all in the `curl/curl.h` header file and documented in the
libcurl-errors man page.

You can convert a CURLcode into a human readable string with the
`curl_easy_strerror()` function - but be aware that these errors are rarely
phrased in a way that is suitable for anyone to expose in a UI or to an end
user:

    const char *str = curl_easy_strerror( error );
    printf("libcurl said %s\n", str);

Another way to get a slightly better error text in case of errors, is to set
the `CURLOPT_ERRORBUFFER` option to point out a buffer in your program and
then libcurl will store a related error message there before it returns an
error:

    curl error[CURL_ERROR_SIZE]; /* needs to be at least this big */
    CURLcode ret = curl_easy_setopt(handle, CURLOPT_ERRORBUFFER, error);

## Verbose operations

Okay, we just showed how to get the error as a human readable text as that is
an excellent help to figure out what went wrong in a particular transfer and
often explains why it can be done like that or what the problem is for the
moment.

The next life safer when writing libcurl applications that everyone needs to
know about and needs to use extensively, at least while developing libcurl
applications or debugging libcurl itself, is to enable "verbose mode" with
`CURLOPT_URL`:

    CURLcode ret = curl_easy_setopt(handle, CURLOPT_VERBOSE, 1L);

When libcurl is told to be verbose it will mention transfer related details
and information to stderr while the transfer is ongoing. This is awesome to
figure out why things fail and to learn exactly what libcurl does when you ask
it different things. You can redirect the output elsewhere by changing stderr
with `CURLOPT_STDERR` or you can get even more info in a fancier way with the
debug callback (explained further in a later section).

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
