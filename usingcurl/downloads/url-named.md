# Download to a file named by the URL

Many URLs, however, already contain the filename part in the rightmost end.
curl lets you use that as a shortcut so you do not have to repeat it with
`-o`. Instead of:

    curl -o file.html http://example.com/file.html

You can save the remote URL resource into the local file 'file.html' with
this:

    curl -O http://example.com/file.html

This is the `-O` (uppercase letter o) option, or `--remote-name` for the long
name version. The `-O` option selects the local filename to use by picking the
filename part of the URL that you provide. This is important. You specify the
URL and curl picks the name from this data. If the site redirects curl further
(and if you tell curl to follow redirects), it does not change the filename
curl uses for storing this.

## Store in another directory

When the correct filename to use has been selected as explained above, you can
still change the directory in which that file will be saved by using
`--output-dir`. It is especially useful in combination with `-O` of course, as
that option otherwise implies saving the file in the current directory.

To save the new file in the `/tmp` directory using a filename taken from the
URL:

    curl -O --output-dir /tmp http://example.com/file.html

## Use the URL's filename part for all URLs

As a reaction to adding a hundred `-O` options when using a hundred URLs, we
introduced an option called `--remote-name-all`. This makes `-O` the default
operation for all given URLs. You can still provide individual "storage
instructions" for URLs but if you leave one out for a URL that gets
downloaded, the default action is then switched from stdout to -O style.
