# Expand variables

Variables can be expanded in option parameters using `{{varName}}` when the
option name is prefixed with `--expand-`. This makes the content of the
variable `varName` get inserted.

If you reference a name that does not exist as a variable, a blank string is
inserted.

Insert `{{` verbatim in the string by escaping it with a backslash:

`\{{`.

The example below contains multiple lines for readability. The backslash (`\`)
is used to instruct the terminal to ignore the newline.

In the example below, the variable `host` is set and then expanded:

    curl \
        --variable host=example \
        --expand-url "https://{{host}}.com"

For options specified without the `--expand-` prefix, variables are not
expanded.

Variable content holding null bytes that are not encoded when expanded causes
curl to exit with an error.
