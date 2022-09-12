# Read

An application receives and reads incoming Websocket traffic using one of
these two methods:

## Write callback

When the `CURLOPT_CONNECT_ONLY` option is **not** set, websocket data will be
delivered to the write callback.

In the default "frame mode" (as opposed to "raw mode"), libcurl delivers
complete websocket frames to the callback one by one as they arrive. The
application can then call `curl_ws_meta()` to get information about the
specific frame that was passed to the callback.

## `curl_ws_recv`

If the connect-only option was set, the transfer ends after the websocket has
been setup to the remote host and from that point the application needs to
call `curl_ws_recv()` to read websocket data and `curl_ws_send()` to send it.

The `curl_ws_recv` function has this prototype:

    CURLcode curl_ws_recv(CURL *curl, void *buffer, size_t buflen,
                          size_t *recv, unsigned int *recvflags);

`curl` - the handle to the transfer
 
`buffer` - pointer to a buffer to receive the websocket data in

`buflen` - the size in bytes of the **buffer**

`recv` - the size in bytes of the data stored in the **buffer* on return

**recvflags** - a bitmask of bits that describe the received frame. See the
bit descriptions below.

### `CURLWS_TEXT`
The buffer contains text data. Note that this makes a difference to WebSockets
but libcurl itself will not make any verification of the content or
precautions that you actually receive valid UTF-8 content.

### `CURLWS_BINARY`
This is binary data.

### `CURLWS_FINAL`
This is the final fragment of the message, if this is not set, it implies that
there will be another fragment coming as part of the same message.
 
### `CURLWS_CLOSE`
This transfer is now closed.

### `CURLWS_PING`
This as an incoming ping message, that expects a pong response.
