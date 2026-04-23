# Reading URLs from a file

Starting in curl 8.13.0, curl can be told to download a set of URLs provided
in a text file, one URL per line. It is done with with the standard `--url`
option but instead of providing a URL you provide the filename with a `@`
symbol as prefix, like: `--url @filename`. It can be told to load the list of
URLs from stdin by a single dash as filename, like `--url @-`.

When curl is asked to download URLs provided in a file, it implies using
`--remote-name` for each provided URL. The URLs are assumed to be "absolute"
and there is no globbing applied or done on them. Features such as
`--skip-existing` work fine in combination with this.

Any line in the URL file that starts with `#` is treated as a comment and is
skipped.

Download many files in parallel provided in a text file:

    curl --url @filelist.txt --parallel
