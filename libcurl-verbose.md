## Verbose operations

Okay, we just showed how to get the error as a human readable text as that is
an excellent help to figure out what went wrong in a particular transfer and
often explains why it can be done like that or what the problem is for the
moment.

The next lifesaver when writing libcurl applications that everyone needs to
know about and needs to use extensively, at least while developing libcurl
applications or debugging libcurl itself, is to enable "verbose mode" with
`CURLOPT_VERBOSE`:

    CURLcode ret = curl_easy_setopt(handle, CURLOPT_VERBOSE, 1L);

When libcurl is told to be verbose it will mention transfer-related details
and information to stderr while the transfer is ongoing. This is awesome to
figure out why things fail and to learn exactly what libcurl does when you ask
it different things. You can redirect the output elsewhere by changing stderr
with `CURLOPT_STDERR` or you can get even more info in a fancier way with the
debug callback (explained further in a later section).

### Trace everything

Verbose is certainly fine, but sometimes you need more. libcurl also offers a
trace callback that in addition to showing you all the stuff the verbose mode
does, it also passes on *all* data sent and received so that your application
gets a full trace of everything.

The sent and received data passed to the trace callback is given to the
callback in its unencrypted form, which can be handy when working with
TLS or SSH based protocols when capturing the data off the network for
debugging is not practical.

When you set the `CURLOPT_DEBUGFUNCTION` option, you still need to have
`CURLOPT_VERBOSE` enabled but with the trace callback set libcurl will use
that callback instead of its internal handling.

The trace callback should match a prototype like this:

    int my_trace(CURL *handle, curl_infotype type, char *ptr, size_t size,
                 void *userp);

**handle** is the easy handle it concerns, **type** describes the particular
data passed to the callback (data in/out, header in/out, TLS data in/out and
"text"), **ptr** points to the data being **size** number of bytes. **userp**
is the custom pointer you set with `CURLOPT_DEBUGDATA`.

The data pointed to by **ptr** *will not* be zero terminated, but will be
exactly of the size as told by the **size** argument.

The callback must return 0 or libcurl will consider it an error and abort the
transfer.

On the curl web site, we host an example called
[debug.c](https://www.curl.se/libcurl/c/debug.html) that includes a simple
trace function to get inspiration from.

There are also additional details in the [CURLOPT_DEBUGFUNCTION man
page](https://www.curl.se/libcurl/c/CURLOPT_DEBUGFUNCTION.html).
