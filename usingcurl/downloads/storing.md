# Storing downloads

If you try the example download as in the previous section, you will notice
that curl will output the downloaded data to stdout unless told to do
something else. Outputting data to stdout is really useful when you want to
pipe it into another program or similar, but it is not always the optimal way
to deal with your downloads.

Give curl a specific filename to save the download in with `-o [filename]`
(with `--output` as the long version of the option), where filename is either
just a filename, a relative path to a filename or a full path to the file.

Also note that you can put the `-o` before or after the URL; it makes no
difference:

    curl -o output.html http://example.com/
    curl -o /tmp/index.html http://example.com/
    curl http://example.com -o ../../folder/savethis.html

This is, of course, not limited to `http://` URLs but works the same way no
matter which type of URL you download:

    curl -o file.txt ftp://example.com/path/to/file-name.ext

If you ask curl to send the output to the terminal, it attempts to detect and
prevent binary data from being sent there since that can seriously mess up
your terminal (sometimes to the point where it stops working). You can
override curl's binary-output-prevention and force the output to get sent to
stdout by using `-o -`.

curl has several other ways to store and name the downloaded data. Details
follow.

## Overwriting

When curl downloads a remote resource into a local filename as described
above, it will overwrite that file in case it already existed. It will
*clobber* it.

curl offers a way to avoid this clobbering: `--no-clobber`.

When using this option, and curl finds that there already exists a file with
the given name, curl instead appends a period plus a number to the filename
in an attempt to find a name that is not already used. It will start with `1`
and then continue trying until it reaches `100` and pick the first available
one.

For example, if you ask curl to download a URL to `picture.png`, and in that
directory there already are two files called `picture.png` and
`picture.png.1`, the following will create save the file as `picture.png.2`:

    curl --no-clobber https://example.com/image -o picture.png

A user can use the [--write-out](../verbose/writeout.md) option's
`%filename_effective` variable to figure out which name that was eventually
used.

## Leftovers on errors

By default, if curl runs into a problem during a download and exits with an
error, the partially transferred file will be left as-is. It could be a small
fraction of the intended file, or it could be almost the entire thing. It is
up to the user to decide what to do with the leftovers.

The `--remove-on-error` command line option changes this behavior. It tells
curl to delete any partially saved file if curl exits with an error. No more
leftovers!
