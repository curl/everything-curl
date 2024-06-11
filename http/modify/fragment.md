# Fragment

A URL may contain an anchor, also known as a fragment, which is written with a
pound sign and string at the end of the URL. Like for example
`http://example.com/foo.html#here-it-is`. That fragment part, everything from
the pound/hash sign to the end of the URL, is only intended for local use and
is not sent over the network. curl simply strips that data off and discards
it.

## A range trick

A practical way to exploit the fact that the fragment is not sent over the
wire, is to use that field for ranges if you want to use the exact same URL
many times on the command line.

For example, download this same exact URL twenty times:

    curl "https://example.com/#[1-20]"
