# Query

The query part of a URL is the data that is to the right of a question mark
(`?`) but to the left of the [fragment](fragment.md), which begins with a hash
(`#`).

The query can be any string of characters as long as they are URL
encoded. It is a common practice to use a sequence of key/value pairs
separated by ampersands (`&`). Like in
`https://example.com/?name=daniel&tool=curl`.

To help users create such query sets, properly encoded, curl offers the
command line option `--url-query [content]`. This option adds content, usually
a name + value pair, to the end of the query part of the provided URL.

When adding query parts, curl adds ampersand separators.

The syntax is identical to that used by `--data-urlencode` with one extension:
the `+` prefix. See below.

 - `content`: URL encode the content and add that to the query. Just be
   careful so that the content does not contain any `=` or `@` symbols, as
   that makes the syntax match one of the other cases below.

 - `=content`: URL encode the content and add that to the query. The initial
   `=` symbol is not included in the data.

 - `name=content`: URL encode the content part and add that to the query. Note
   that the name part is expected to be URL encoded already.

 - `@filename`: load data from the given file (including any newlines), URL
   encode that data and add that to the query.

 - `name@filename`: load data from the given file (including any newlines),
   URL encode that data and add that to the query. The name part gets an equal
   sign appended, resulting in `name=urlencoded-file-content`. Note that the
   name is expected to be URL encoded already.

 - `+content`: Add the content to the query without doing any encoding.
