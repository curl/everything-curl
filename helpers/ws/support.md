# Support

WebSocket is an **EXPERIMENTAL** feature present in libcurl 7.86.0 and
later. Since it is experimental, you need to explicitly enable it in the build
for it to be present and available.

To figure out if your libcurl installation supports WebSocket, you can call
[`curl_version_info()`](../../libcurl/api.md) and check the `->protocols` fields in the
returned struct. It should contain `ws` for it to be present, and probably
also `wss`.
