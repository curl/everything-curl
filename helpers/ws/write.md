# Write

An application can receive WebSocket data two different ways, but there is
only one way for it to send data over the connection: the `curl_ws_send()`
function.

## `curl_ws_send()`

    CURLcode curl_ws_send(CURL *curl, const void *buffer, size_t buflen,
                          size_t *sent, curl_off_t fragsize,
                          unsigned int sendflags);

`curl` - transfer handle

`buffer` - pointer to the frame data to send

`buflen` - length of the data (in bytes) in `buffer`

`fragsize` - the total size of the whole fragment, used when sending only a
 part of a larger fragment.

`sent` - number of bytes that were sent

`flags` - bitmask describing the data. See bit descriptions below.

## Full fragment vs partial

To send a complete WebSocket fragment, set `fragsize` to zero and provide data
for all other arguments.

To send a fragment in smaller pieces: send the first part with `fragsize` set
to the *total* fragment size. You **must** know and provide the size of the
entire fragment before you can send it. In subsequent calls to
`curl_ws_send()` you send the next pieces of the fragment with `fragsize` set
to zero but with the `CURLWS_OFFSET` bit sets in the `flags` argument. Repeat
until all pieces have been sent that constitute the whole fragment.

## Flags

### `CURLWS_TEXT`

The buffer contains text data. Note that this makes a difference to WebSocket
but libcurl itself does not perform any verification of the content or make
any precautions that you actually send valid UTF-8 content.

### `CURLWS_BINARY`

This is binary data.

### `CURLWS_CONT`

This is not the final fragment of the message, which implies that there is
another fragment coming as part of the same message where this bit is not set.

### `CURLWS_CLOSE`

Close this transfer.

### `CURLWS_PING`

This as a ping.

### `CURLWS_PONG`

This as a pong.

### `CURLWS_OFFSET`

The provided data is only a partial fragment and there is more data coming in
a following call to `curl_ws_send()`. When sending only a piece of the
fragment like this, the `fragsize` must be provided with the total expected
frame size in the first call and it needs to be zero in subsequent calls.

When `CURLWS_OFFSET` is set, no other flag bits should be set as this is a
continuation of a previous send and the bits describing the fragments were set
then.
