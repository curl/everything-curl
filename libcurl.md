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

First you create an "easy handle", which is your handle to a transfer really.

    CURL *curl_handle = curl_easy_init();

Then you set various options in that handle, to control the upcoming transfer.
Like this example sets the URL:

    /* set URL to operate on */
    res = curl_easy_setopt( curl_handle, CURLOPT_URL, "http://example.com/");

Finally you fire off the actual transfer.

The actual "perform the transfer phase" can be done using different different
means and function calls, depending on what kind of behavior you want in your
application and how libcurl is best integrated into your architecture. Those
are further described later in this chapter.

After the transfer has completed, you can figure out if it succeeded or not
and you can extract stats and various information that libcurl gathered during
the transfer. (See curl_easy_getinfo description.)

While the transfer is ongoing, using any of the functions you can use to drive
the transfer (or in fact transfers - in plural), libcurl calls your specified
functions - known as *callbacks* - to deliver data, to read data or to do a
wide variety of things. See further below for callback details.

### "Drive" transfers

libcurl provides three different ways to perform the transfer. Which way to
use in your case is entirely up to you and what you need.

1. The 'easy' interface lets you do a single transfer in a synchronous
fashion. Then libcurl will do the entire transfer and return control back to
your application when it is completed - successfully or failed.

2. The 'multi' interface is for when you want to do more than one transfer at
the same time, or you just want an non-blocking transfer mechanism.

3. The 'multi_socket' interface is a slight variation of the regular multi
one, but is event-based and is really the suggested API to use if you intend
to scale up the number of simultaneous transfers in the hundreds or thousands
or so.

Let's look at each one a little closer...

#### Driving with the "easy" interface

The name 'easy' was picked simply because this is really the easy way to use
libcurl, and with easy of course comes a few limitations. Like for example
that it can only do one transfer at a time and it does the entire transfer in
a single function call and returns once it is completed:

    res = curl_easy_perform( curl_handle );

If the server is slow, if the transfer is large or if you have some unpleasant
timeouts in the network or similar, this function call can end up taking a
very long time. You can of course set timeouts to not allow it to spend more
than N seconds, but it could still mean a substantial amount of time depending
on the particular conditions.

If you want your application to do something else while libcurl is transferring
with the easy interface, you need to use multiple threads. If you want to do
multiple simultaneous transfers when using the easy interface, you need to do
each of the transfers in their own threads.

#### Driving with the "multi" interface

TBD

#### Driving with the "multi_socket" interface

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

## Multi-threading

TBD

## Common mistakes

TBD

## When things don't run the way you thought they would

TBD
