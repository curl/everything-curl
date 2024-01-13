# Fragment

A URL may contain an anchor, also known as a fragment, which is written with a
pound sign and string at the end of the URL. Like for example
`http://example.com/foo.html#here-it-is`. That fragment part, everything from
the pound/hash sign to the end of the URL, is only intended for local use and
is not sent over the network. curl simply strips that data off and discards
it.
