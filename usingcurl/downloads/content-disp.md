# Use the target filename from the server

HTTP servers have the option to provide a header named `Content-Disposition:`
in responses. That header may contain a suggested filename for the contents
delivered, and curl can be told to use that hint to name its local file. The
`-J / --remote-header-name` enables this. If you also use the `-O` option,
it makes curl use the filename from the URL by default and only *if*
there is actually a valid Content-Disposition header available, it switches to
saving using that name.

`-J` has some problems and risks associated with it that users need to be
aware of:

1. It only uses the rightmost part of the suggested filename, so any path or
directories the server suggests are stripped out.

2. Since the filename is provided by the server, curl does not overwrite any
preexisting local file in your current directory if the server happens to
provide such a filename (unless you use `--clobber`).

3. filename encoding and character sets issues. curl does not decode the name
in any way, so you may end up with a URL-encoded filename where a browser
would otherwise decode it to something more readable using a sensible
character set.
