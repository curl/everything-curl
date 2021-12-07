# Download to a file named by the URL

Many URLs, however, already contain the file name part in the rightmost
end. curl lets you use that as a shortcut so you do not have to repeat it with
`-o`. So instead of:

    curl -o file.html http://example.com/file.html

You can save the remove URL resource into the local file 'file.html' with this:

    curl -O http://example.com/file.html

This is the `-O` (uppercase letter o) option, or `--remote-name` for the long
name version. The -O option selects the local file name to use by picking the
file name part of the URL that you provide. This is important. You specify the
URL and curl picks the name from this data. If the site redirects curl further
(and if you tell curl to follow redirects), it does not change the file name
curl will use for storing this.

## Use the URL's file name part for all URLs

As a reaction to adding a hundred `-O` options when using a hundred URLs, we
introduced an option called `--remote-name-all`. This makes `-O` the default
operation for all given URLs. You can still provide individual "storage
instructions" for URLs but if you leave one out for a URL that gets
downloaded, the default action is then switched from stdout to -O style.

