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

While the transfer is ongoing, using any of the functions you can use to drive
the transfer (or in fact transfers - in plural), libcurl calls your specified
functions - known as *callbacks* - to deliver data, to read data or to do a
wide variety of things. See further below for callback details.

### "Drive" transfers

Easy

multi

multi_socket

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
