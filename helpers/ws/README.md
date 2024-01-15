# WebSocket

WebSocket is a transfer protocol done *on top* of HTTP that offers a general
purpose bidirectional byte-stream. The protocol was created for more than just
plain uploads and downloads and is more similar to something like TCP over
HTTP.

A WebSocket client application sets up a connection with an HTTP request that
*upgrades* into WebSocket - and once upgraded, the involved parties speak
WebSocket over that connection until it is done and the connection is closed.

* [Support](support.md)
* [URLs](urls.md)
* [Concept](concept.md)
* [Options](options.md)
* [Read](read.md)
* [Meta](meta.md)
* [Write](write.md)
