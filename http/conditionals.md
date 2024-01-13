# Conditionals

Sometimes users want to avoid downloading a file again if the same file maybe
already has been downloaded the day before. This can be done by making the
HTTP transfer conditioned on something. curl supports two different
conditions: the file timestamp and etag.

## Check by modification date

Download the file only if it is newer than a specific date with the use of the
`-z` or `--time-cond` option:

    curl -z "Jan 10, 2017" https://example.com/file -O

Or the reverse, get the file only if it is older than the specific time by
prefixing the date with a dash:

    curl --time-cond "-Jan 10, 2017" https://example.com/file -O

The date parser is liberal and accepts most formats you can write the date
with, and you can also specify it complete with a time:

    curl --time-cond "Sun, 12 Sep 2004 15:05:58 -0700" \
      https://www.example.org/file.html

The `-z` option can also extract and use the timestamp from a local file,
which is handy to only download a file if it has been updated remotely:

    curl -z file.html https://example.com/file.html -O

It is often useful to combine the use of `-z` with the `--remote-time` flag,
which sets the time of the locally created file to the same timestamp as the
remote file had:

    curl -z file.html -o file.html --remote-time https://example.com/file.html

## Check by modification of content

HTTP servers can return a specific *ETag* for a given resource version. If the
resource at a given URL changes, a new Etag value must be generated, so a
client knows that as long as the ETag remains the same, the content has not
changed.

Using ETags, curl can check for remote updates without having to rely on times
or file dates. It also then makes the check able to detect sub-second changes,
which the timestamp based checks cannot.

Using curl you can download a remote file and save its ETag (if it provides
any) in a separate cache by using the `--etag-save` command line option. Like
this:

    curl --etag-save etags.txt https://example.com/file -o output

A subsequent command line can then use that previously saved etag and make
sure to only download the file again if it has changed, like this:

    curl --etag-compare etag.txt https://example.com/file -o output

The two etag options can also be combined in the same command line, so that if
the file actually was updated, curl would save the update ETag again in the
file:

    curl --etag-compare etag.txt --etag-save etag.txt \
      https://example.com/file -o output
