# Write out

`--write-out` or just `-w` for short, outputs text and information after a
transfer is completed. It offers a large range of variables that you can
include in the output, variables that have been set with values and
information from the transfer.

Instruct curl to output a string by passing plain text to this option:

    curl -w "formatted string" http://example.com/

…and you can also have curl read that string from a given file instead if you
prefix the string with '@':

    curl -w @filename http://example.com/

…or even have curl read the string from stdin if you use '-' as filename:

    curl -w @- http://example.com/

## Variables

The variables that are available are accessed by writing `%{variable_name}` in
the string and that variable is substituted by the correct value. To output a
plain `%` you write it as `%%`. You can also output a newline by using `\n`, a
carriage return with `\r` and a tab space with `\t`.

As an example, we can output the Content-Type and the response code from an
HTTP transfer, separated with newlines and some extra text like this:

    curl -w "Type: %{content_type}\nCode: %{response_code}\n" \
      http://example.com

The output is sent to stdout by default so you probably want to make sure that
you do not also send the downloaded content to stdout as then you might have a
hard time to separate out the data; or use `%{stderr}` to send the output to
stderr.

## HTTP headers

This option also provides an easy to use way to output the contents of HTTP
response headers from the most recent transfer.

Use `%header{name}` in the string, where `name` is the case insensitive name
of the header (without the trailing colon). The output header contents are
then shown exactly as was sent over the network, with leading and trailing
whitespace trimmed. Like this:

    curl -w "Server: %header{server}\n" http://example.com

Starting in curl 8.17.0, you can output the contents of all occurrences of a
header field with a specific name - even for a whole redirect "chain" - by
appending `:all:[separator]` to the header name. The `[separator]` string (if
not blank) is a text that gets output between each header if there are more
than one to display. When more than one header is shown, they are output in
the chronological order of appearance over the wire. To include a close brace
(`}`) in the separator, escape it with a backslash: `\}`.

## Output

By default, this option makes the selected data get output on stdout. If that
is not good enough, the pseudo-variable `%{stderr}` can be used to direct (the
following) part to stderr and `%{stdout}` brings it back to stdout.

Send the write-out output to a specific file instead of stdout (or the
currently selected output stream) by using the `%output{filename}`
instruction. The data following is then written to that file. If you would
rather have curl append data to that file instead of creating it from
scratch, prefix the filename with `>>`. Like this: `%output{>>filename}`.

A write-out argument can include output to stderr, stdout and files as the
user sees fit.

## Time

Using `%time{format}`, you can output the current UTC time in your selected
format. The characters within `{}` create a format string that may contain
special character sequences called conversion specifications. Each conversion
specification starts with `%` and is followed by a character that instructs
curl to output a particular time detail. All other characters used are
displayed as-is.

The [list of time conversion specifiers](time-specifiers.md).

## Windows

**NOTE:** In Windows, the `%`-symbol is a special symbol used to expand
environment variables. In batch files all occurrences of `%` must be doubled
when using this option to properly escape. If this option is used at the
command prompt then the `%` cannot be escaped and unintended expansion is
possible.

## Available --write-out variables

[Available --write-out variables](all-variables.md)

