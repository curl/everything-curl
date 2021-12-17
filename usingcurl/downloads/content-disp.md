# Use the target file name from the server

HTTP servers have the option to provide a header named `Content-Disposition:`
in responses. That header may contain a suggested file name for the contents
delivered, and curl can be told to use that hint to name its local file. The
`-J / --remote-header-name` enables this. If you also use the `-O` option,
it makes curl use the file name from the URL by default and only *if*
there is actually a valid Content-Disposition header available, it switches to
saving using that name.

`-J` has some problems and risks associated with it that users need to be
aware of:

1. It will only use the rightmost part of the suggested file name, so any path
or directories the server suggests will be stripped out.

2. Since the file name is entirely selected by the server, curl will, of
course, overwrite any preexisting local file in your current directory if the
server happens to provide such a file name.

3. File name encoding and character sets issues. curl does not decode the name
in any way, so you may end up with a URL-encoded file name where a browser
would otherwise decode it to something more readable using a sensible
character set.

