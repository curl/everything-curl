# Use the target filename from the server

HTTP servers have the option to provide a header named `Content-Disposition:`
in responses. That header may contain a suggested filename for the contents
delivered, and curl can be told to use that hint to name its local file. The
`-J / --remote-header-name` enables this. If you also use the `-O` option, it
makes curl use the filename from the URL by default and only *if* there is
actually a valid `Content-Disposition` header available, it switches to saving
using that name.

If there are *multiple* Content-Disposition headers, curl picks the name from
the first one it sees.

By default curl saves that file in your current directory, which can be
changed with `--output-dir`.

`-J` has some challenges and risks associated with it that users need to be
vary of:

- It only uses the rightmost part of the suggested filename; the path part is
stripped out.

- Since the filename is provided by the server, curl does not overwrite any
preexisting local file in your current directory if the server happens to
provide such a filename (unless you use `--clobber`).

- filename encoding and character sets issues. curl does not decode the name
in any way, so you may end up with a URL-encoded filename where a browser
would otherwise decode it to something more readable using a sensible
character set.

## Location: too

The above approach mentioned works pretty well, but has limitations. One of
them being that if the site instead of providing a `Content-Disposition`
header only redirects the client to a new URL to download from, curl does not
pick up the new name but instead keeps using the one from the originally
provided URL.

Since curl 8.19.0, -J also picks up the filename from `Location:` headers and
uses that filename if no `Content-Disposition` header arrives.

If you run a command line like:

    curl -L -O -J https://example.com/download?id=6347d

Assuming the site redirects curl to the actual download URL for the tarball
you want to download like this:

    HTTP/1 301 redirect

    Location: https://example.org/release.tar.gz

This makes curl save the contents of that transfer in a local file called
`release.tar.gz`.

If there is *both* a redirect and a `Content-Disposition` header, the latter
takes precedence.

## What filename?

Since the selected final name used for storing the data is selected based on
contents of a header passed from the server, using this option in a scripting
scenario introduces the challenge: what filename did curl actually use?

A user can easily extract this information with curl’s [-w
option](../verbose/writeout.md). Like this:

    curl -w '%{filename_effective}' -O -J -L \
      https://example.com/download?id=6347d

This command line outputs the used filename to stdout.

Tweak the command line further to instead direct that name to stderr or to a specific file etc. Whatever you think works.
