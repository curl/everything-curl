# Options

There is a dedicated setopt option for the application to control a websocket
communication: `CURLOPT_WS_OPTIONS`.

This option sets a bitmask of "flags" to libcurl, but at the moment, there is
only a single bit used.

## Raw mode

By setting the `CURLWS_RAW_MODE` bit in the bitmask, libcurl will deliver all
websocket traffic "raw" to the write callback instead of parsing the websocket
traffic itself. This raw mode is intended for applications that maybe
implemented websockets handling already and want to just move over to use
libcurl for the transfer and maintain its own websocket logic.

In raw mode, libcurl will also not handle any PING traffic automatically.
