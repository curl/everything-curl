# Support

To figure out if your libcurl installation supports WebSocket, you can call
[`curl_version_info()`](../../libcurl/api.md) and check the `->protocols` fields in the
returned struct. It should contain `ws` for it to be present, and probably
also `wss`.

WebSocket is supported by default since 8.11.0.
