# Anchors or fragments

A URL may contain an "anchor", also known as a fragment, which is written with
a pound sign and string at the end of the URL. Like for example
`http://example.com/foo.html#here-it-is`. That fragment part, everything from
the pound/hash sign to the end of the URL, is only intended for local use and
will not be sent over the network. curl will simply strip that data off and
discard it.
