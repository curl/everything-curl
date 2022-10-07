# Meta

`curl_ws_recv()` and `curl_ws_meta()` both return a pointer to a
`curl_ws_frame` struct, which provides information about the incoming
WebSocket data. A WebSocket "frame" in this case is a part of a WebSocket
fragment. It *can* be a whole fragment, but it might also very well be only a
piece of it. The `curl_ws_frame` contains information about the frame to tell
you the details.

~~~c
struct curl_ws_frame {
  int age;              /* zero */
  int flags;            /* See the CURLWS_* defines */
  curl_off_t offset;    /* the offset of this data into the frame */
  curl_off_t bytesleft; /* number of pending bytes left of the payload */
};
~~~

## Age

This is just a number that identifies the age of this struct. It is always 0
now, but might increase in a future and then the struct might grow.

## Flags

The `flags' field is a bitmask describing details of data.

### `CURLWS_TEXT`
The buffer contains text data. Note that this makes a difference to WebSocket
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

## Offset

When the data delivered is just a part of a larger framgment, this identies
the offset in number of bytes into the larger fragment where this piece
belongs.

## Bytesleft

Number of outstanding payload bytes after this frame, that is left to complete
this fragment.
