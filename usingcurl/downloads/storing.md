# Storing downloads

If you try the example download as in the previous section, you will notice
that curl will output the downloaded data to stdout unless told to do
something else. Outputting data to stdout is really useful when you want to
pipe it into another program or similar, but it is not always the optimal way
to deal with your downloads.

Give curl a specific file name to save the download in with `-o [filename]`
(with `--output` as the long version of the option), where filename is either
just a file name, a relative path to a file name or a full path to the file.

Also note that you can put the `-o` before or after the URL; it makes no
difference:

    curl -o output.html http://example.com/
    curl -o /tmp/index.html http://example.com/
    curl http://example.com -o ../../folder/savethis.html

This is, of course, not limited to http:// URLs but works the same way no matter
which type of URL you download:

    curl -o file.txt ftp://example.com/path/to/file-name.ext

If you ask curl to send the output to the terminal, it attempts to detect and
prevent binary data from being sent there since that can seriously mess up
your terminal (sometimes to the point where it stops working). You can
override curl's binary-output-prevention and force the output to get sent to
stdout by using `-o -`.

curl has several other ways to store and name the downloaded data. Details
follow.
