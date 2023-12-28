# Simple POST

To send form data, a browser URL encodes it as a series of `name=value` pairs
separated by ampersand (`&`) symbols. The resulting string is sent as the body
of a POST request. To do the same with curl, use the `-d` (or `--data`)
argument, like this:

    curl -d 'name=admin&shoesize=12' http://example.com/

When specifying multiple `-d` options on the command line, curl concatenates
them and insert ampersands in between, so the above example could also be
written like this:

    curl -d name=admin -d shoesize=12 http://example.com/

If the amount of data to send is too large for a mere string on the
command line, you can also read it from a filename in standard curl style:

    curl -d @filename http://example.com

While the server might assume that the data is encoded in some special way,
curl does not encode or change the data you tell it to send. **curl sends
exactly the bytes you give it** (except that when reading from a file. `-d`
skips over the carriage returns and newlines so you need to use
`--data-binary` if you rather intend them to be included in the data.).

To send a POST body that starts with a `@` symbol, to avoid that curl tries to
load that as a filename, use `--data-raw` instead. This option has no file
loading capability:

    curl --data-raw '@string' https://example.com
