# URLs

A client starts a WebSocket communication with libcurl by using a URL with the
scheme `ws` or `wss`. Like in `wss://websocket.example.com/traffic-lights`.

The `wss` variant is for using a TLS security connection, while the `ws` one
is done over insecure clear text.
