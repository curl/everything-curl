# Read

An application receives and reads incoming WebSocket traffic using one of
these two methods:

## Write callback

When the `CURLOPT_CONNECT_ONLY` option is **not** set, WebSocket data is
delivered to the write callback.

In the default frame mode (as opposed to raw mode), libcurl delivers parts
of WebSocket fragments to the callback as data arrives. The application can
then call `curl_ws_meta()` to get information about the specific frame that
was passed to the callback.

libcurl can deliver full fragments or partial ones, depending on what comes
over the wire when. Each WebSocket fragment can be up to 63 bit in size.

## `curl_ws_recv`

If the connect-only option was set, the transfer ends after the WebSocket has
been setup to the remote host and from that point the application needs to
call `curl_ws_recv()` to read WebSocket data and `curl_ws_send()` to send it.

The `curl_ws_recv` function has this prototype:

    CURLcode curl_ws_recv(CURL *curl, void *buffer, size_t buflen,
                          size_t *recv, struct curl_ws_frame **meta);

`curl` - the handle to the transfer
 
`buffer` - pointer to a buffer to receive the WebSocket data in

`buflen` - the size in bytes of the **buffer**

`recv` - the size in bytes of the data stored in the **buffer* on return

`meta` - gets a pointer to a struct with [information about the received frame](meta.md).
