# libcurl

The engine in the curl command-line tool is libcurl. libcurl is also the
engine in thousands of tools, services and applications out there today,
performing their Internet data transfers.

## C API

libcurl is a library of functions that are provided with a C API, for
applications written in C. You can easily use it from C++ too, with only a few
considerations (see [libcurl for C++ programmers](cplusplus.md)). For other
languages, there exist *bindings* that work as intermediate layers between
libcurl the library and corresponding functions for the particular language
you like.

## Transfer oriented

We have designed libcurl to be transfer oriented usually without forcing users
to be protocol experts or in fact know much at all about networking or the
protocols involved. You setup a transfer with as many details and specific
information as you can and want, and then you tell libcurl to perform that
transfer.

That said, networking and protocols are areas with lots of pitfalls and
special cases so the more you know about these things, the more you are able
to understand about libcurl's options and ways of working. Not to mention,
such knowledge is invaluable when you are debugging and need to understand
what to do next when things do not go as you intended.

The most basic libcurl using application can be as small as just a couple of
lines of code, but most applications do, of course, need more code than that.

## Simple by default, more on demand

libcurl generally does the simple and basic transfer by default, and if you
want to add more advanced features, you add that by setting the correct
options. For example, libcurl does not support HTTP cookies by default but it
does once you tell it.

This makes libcurl's behaviors easier to guess and depend on, and also it
makes it easier to maintain old behavior and add new features. Only
applications that actually ask for and use the new features get that behavior.

  * [Header files](headers.md)
  * [Global initialization](globalinit.md)
  * [API compatibility](api.md)
  * [--libcurl](--libcurl.md)
  * [multi-threading](threading.md)
  * [CURLcode return codes](curlcode.md)
  * [Verbose operations](verbose.md)
  * [Caches](caches.md)
  * [Performance](performance.md)
  * [for C++ programmers](cplusplus.md)
