# Browsers' address bar

It is important to realize that when you use a modern web browser, the address
bar they tend to feature at the top of their main windows are not using URLs
or even URIs. They are in fact mostly using IRIs, which is a superset of URIs
to allow internationalization like non-Latin symbols and more, but it usually
goes beyond that, too, as they tend to, for example, handle spaces and do
magic things on percent encoding in ways none of these mentioned
specifications say a client should do.

The address bar is quite simply an interface for humans to enter and see
URI-like strings.

Sometimes the differences between what you see in a browser's address bar and
what you can pass in to curl is significant.
