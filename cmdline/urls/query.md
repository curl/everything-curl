# Query

The query part of a URL is the data that is to the right of a question mark
(`?`) but to the left of the [fragment](fragment.md), which begins with a hash
(`#`).

The query can be any string of characters really, but it is very common to set
it to a sequence of key/value pairs separated by ampersands (`&`). Like in
`https://example.com/?name=daniel&tool=curl`.

To help users create such query sets, curl offers the command line option
`--url-query [content]`. This option adds content, usually a name + value
pair, to the end of the query part of the provided URL.

When adding query parts, curl adds ampersand separators.

The syntax is identical to that used for
[--data-urlencode](../../http/post/url-encode.md) with one extension: If the
argument starts with a `+` (plus), the rest of the string is provided as-is
unencoded.

 - `content`: This will make curl URL encode the content and add that to the
   query. Just be careful so that the content does not contain any `=` or `@`
   symbols, as that will then make the syntax match one of the other cases
   below!

 - `=content`: This will make curl URL encode the content and add that to the
   query. The initial `=` symbol is not included in the data.

 - `name=content`: This will make curl URL encode the content part and add
   that to the query. Note that the name part is expected to be URL encoded
   already.

 - `@filename`: This will make curl load data from the given file (including
   any newlines), URL encode that data and that to the query.

 - `name@filename`: This will make curl load data from the given file
   (including any newlines), URL encode that data and add it to the query.
   The name part gets an equal sign appended, resulting in
   `name=urlencoded-file-content`. Note that the name is expected to be URL
   encoded already.
