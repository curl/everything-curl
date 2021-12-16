# Convert to GET

A little convenience feature that could be suitable to mention in this context
is the `-G` or `--get` option, which takes all data you have specified with
the different `-d` variants and appends that data to the inputted URL
e.g. ```http://example.com``` separated with a '?' and then makes curl send a
GET instead.

This option makes it easy to switch between POSTing and GETing a form, for
example.

An example that adds an encoded piece of data as a query in the URL:

    curl -G --data-urlencode "name=daniel stenberg" https://example.com/
