# FTP wildcard matching

libcurl supports FTP wildcard matching. You use this feature by setting
`CURLOPT_WILDCARDMATCH` to `1L` and then use a "wildcard pattern" in the in
the filename part of the URL.

## Wildcard patterns

The default libcurl wildcard matching function supports:

`*` - ASTERISK

    ftp://example.com/some/path/*.txt

To match all txt files in the directory `some/path`. Only two asterisks are
allowed within the same pattern string.

`?` - QUESTION MARK"

A question mark matches any (exactly one) character. Like if you have files
called `photo1.jpeg` and `photo7.jpeg` this pattern could match them:

    ftp://example.com/some/path/photo?.jpeg

`[` - BRACKET EXPRESSION

The left bracket opens a bracket expression. The question mark and asterisk
have no special meaning in a bracket expression. Each bracket expression ends
by the right bracket (`]`) and matches exactly one character. Some examples
follow:

`[a-zA-Z0-9]` or `[f-gF-G]` - character intervals

`[abc]`  - character enumeration

`[^abc]` or `[!abc]` - negation

`[[:name:]]` class expression. Supported classes are alnum, lower, space,
alpha, digit, print, upper, blank, graph, xdigit.

`[][-!^]` - special case, matches only `\-`, `]`, `[`, `!` or `^`.

`[\\[\\]\\\\]` - escape syntax. Matches `[`, `]` or `\\`.

Using the rules above, a filename pattern can be constructed:

    ftp://example.com/some/path/[a-z[:upper:]\\\\].jpeg

## FTP chunk callbacks

When FTP wildcard matching is used, the `CURLOPT_CHUNK_BGN_FUNCTION` callback
is called before a transfer is initiated for a file that matches.

The callback can then opt to return one of these return codes to tell libcurl
what to do with the file:

 - `CURL_CHUNK_BGN_FUNC_OK` transfer the file
 - `CURL_CHUNK_BGN_FUNC_SKIP`
 - `CURL_CHUNK_BGN_FUNC_FAIL` stop because of error

After the matched file has been transferred or skipped, the
`CURLOPT_CHUNK_END_FUNCTION` callback is called.

The end chunk callback can only return success or error.

## FTP matching callback

If the default pattern matching function is not to your liking, you can provide
your own replacement function by setting the `CURLOPT_FNMATCH_FUNCTION` option
to your alternative.
