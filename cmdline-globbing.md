## URL Globbing

At times you want to get a range of URLs that are mostly the same, with only a
small portion of it changing between the requests. Maybe it is a numeric range
or maybe a set of names. curl offers "globbing" as a way to specify many URLs
like that easily.

The globbing uses the resevered symbols [] and {} for this, symbols that
normally cannot be part of a legal URL (except for numerical IPv6 addresses
but curl handles them fine anyway). If the globbing gets in your way, disable
it with -g, --globoff.

While most transfer related functionality in curl is provided by the libcurl
library, the URL globbing feature is not!

### Numerical ranges

You can ask for a numerical range with [N-M] syntax. For example, you can ask
for 100 images one by one that are named numerically:

    $ curl -O http://example.com/[1-100].png

and it can even do the ranges with zero prefixes, like if the number is
three-digit all the time:

    $ curl -O http://example.com/[001-100].png

Or maybe you only want even numbered images so you tell curl a step counter
too:

    $ curl -O http://example.com/[0-100:2].png

### Alphabetical ranges

curl can also do alphabetical ranges, like when a site has a section named a
to z:

   $ curl -O http://example.com/secion[a-z].html

### A list

Sometimes the parts don't follow such an easy pattern, and then you can
instead give the full list yourself but then within the curly braces instead
of the brackets used for the ranges:

   $ curl -O http://example.com/{one,two,three,alpha,beta}.html

### Combinations

TBD

### Output variables for globbing

TBD
