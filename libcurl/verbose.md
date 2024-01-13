# Verbose operations

Okay, we just showed how to get the error as a human readable text as that is
an excellent help to figure out what went wrong in a particular transfer and
often explains why it can be done like that or what the problem is for the
moment.

The next lifesaver when writing libcurl applications that everyone needs to
know about and needs to use extensively, at least while developing libcurl
applications or debugging libcurl itself, is to enable verbose mode with
`CURLOPT_VERBOSE`:

    CURLcode ret = curl_easy_setopt(handle, CURLOPT_VERBOSE, 1L);

When libcurl is told to be verbose it outputs transfer-related details and
information to stderr while the transfer is ongoing. This is awesome to figure
out why things fail and to learn exactly what libcurl does when you ask it
different things. You can redirect the output elsewhere by changing stderr
with `CURLOPT_STDERR` or you can get even more info in a fancier way with the
debug callback (explained further in a later section).

## Trace everything

Verbose is certainly fine, but sometimes you need more. libcurl also offers a
trace callback that in addition to showing you all the stuff the verbose mode
does, it also passes on *all* data sent and received so that your application
gets a full trace of everything.

The sent and received data passed to the trace callback is given to the
callback in its unencrypted form, which can be handy when working with
TLS or SSH based protocols when capturing the data off the network for
debugging is not practical.

When you set the `CURLOPT_DEBUGFUNCTION` option, you still need to have
`CURLOPT_VERBOSE` enabled but with the trace callback set libcurl uses that
callback instead of its internal handling.

The trace callback should match a prototype like this:

    int my_trace(CURL *handle, curl_infotype type, char *data, size_t size,
                 void *user);

**handle** is the easy handle it concerns, **type** describes the particular
data passed to the callback (data in/out, header in/out, TLS data in/out and
text), **data** is a pointer pointing to the data being **size** number of
bytes. **user** is the custom pointer you set with `CURLOPT_DEBUGDATA`.

The data pointed to by **data** is *not* null terminated, but is exactly of
the size as told by the **size** argument.

The callback must return 0 or libcurl considers it an error and aborts the
transfer.

On the curl website, we host an example called
[debug.c](https://curl.se/libcurl/c/debug.html) that includes a simple trace
function to get inspiration from.

There are also additional details in the [CURLOPT_DEBUGFUNCTION man
page](https://curl.se/libcurl/c/CURLOPT_DEBUGFUNCTION.html).

## Transfer and connection identifiers

As the trace information flow passed to the debug callback is a continuous
stream even though your application might make libcurl use a large number of
separate connections and different transfers, there are times when you want to
see to which specific transfers or connections the various information belong
to. To better understand the trace output.

You can then get the transfer and connection identifiers from within the
callback:

    curl_off_t conn_id;
    curl_off_t xfer_id;
    res = curl_easy_getinfo(curl, CURLINFO_CONN_ID, &conn_id);
    res = curl_easy_getinfo(curl, CURLINFO_XFER_ID, &xfer_id);

They are two separate identifiers because connections can be reused and
multiple transfers can use the same connection. Using these identifiers
(numbers really), you can see which logs are associated with which transfers
and connections.

## Trace more

If the default amount of tracing data passed to the debug callback is not
enough. Like when you suspect and want to debug a problem in a more
fundamental lower protocol level, libcurl provides the `curl_global_trace()`
function for you.

With this function you tell libcurl to also include detailed logging about
components that it otherwise does not include by default. Such as details
about TLS, HTTP/2 or HTTP/3 protocol bits.

The `curl_global_trace()` functions takes an argument where you specify a
string holding a comma-separated list with the areas you want it to trace. For
example, include TLS and HTTP/2 details:

    /* log details of HTTP/2 and SSL handling */
    curl_global_trace("http/2,ssl");

The exact set of options varies, but here are some ones to try:

| area     | description                                     |
|----------|-------------------------------------------------|
| `all`    | show everything possible                        |
| `tls`    | TLS protocol exchange details                   |
| `http/2` | HTTP/2 frame information                        |
| `http/3` | HTTP/3 frame information                        |
| `*`      | additional ones in future versions              |

Doing a quick run with `all` is often a good way to get to see which specific
areas that are shown, as then you can do follow-up runs with more specific
areas set.
