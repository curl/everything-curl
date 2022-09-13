# Write

An application can receive websocket data two different ways, but there is
only one way for it to send off data over the connection. The `curl_ws_send()`
function.

## `curl_ws_send()`

    CURLcode curl_ws_send(CURL *curl, const void *buffer, size_t buflen,
                          size_t *sent, unsigned int sendflags);

`curl` - transfer handle

`buffer` - pointer to the fram data to send

`buflen` - lenght of the data (in bytes) in `buffer`

`sent` - number of bytes that were sent

`sendflags` - bitmask describing the data. See bit descriptions below.

### `CURLWS_TEXT`
The buffer contains text data. Note that this makes a difference to WebSocket
but libcurl itself will not make any verification of the content or
precautions that you actually send valid UTF-8 content.

### `CURLWS_BINARY`
This is binary data.

### `CURLWS_CONT`
This is not the final fragment of the message, which implies that there will
be another fragment coming as part of the same message where this bit is not
set.

### `CURLWS_CLOSE`
Close this transfer.

### `CURLWS_PING`
This as a ping.

### `CURLWS_PONG`
This as a pong.
