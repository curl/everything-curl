# Expand functions

When expanding variables, curl offers a set of *functions* to change how they
are expanded. Functions are applied with colon + function name after the
variable, like this: `{{varName:function}}`.

Multiple functions can be applied to the variable. They are then applied in a
left-to-right order: `{{varName:func1:func2:func3}}`

The available functions are: `trim`, `json`, `url`, `b64` and `64dec`.

## `trim`

Expands the variable without leading and trailing white space. White space is
defined as:

* horizontal tabs
* spaces
* new lines
* vertical tabs
* form feed and carriage returns

This is extra useful when reading data from files.

    --expand-url "https://example.com/{{path:trim}}"

## `json`

Expands the variable as a valid JSON string. This makes it easier to insert
valid JSON into an argument (the quotes are not included in the resulting
JSON).

    --expand-json "\"full name\": \"{{first:json}} {{last:json}}\""

To trim the variable first, apply both functions (in this order):

    --expand-json "\"full name\": \"{{varName:trim:json}}\""


## `url`

Expands the variable URL encoded. Also known as *percent encoded*. This
function ensures that all output characters are legal within a URL and the
rest are encoded as `%HH` where `HH` is a two-digit hexadecimal number for the
ASCII value.

    --expand-data "varName={{varName:url}}"

To trim the variable first, apply both functions (in this order):

    --expand-data "varName={{varName:trim:url}}"

## `b64`

Expands the variable base64 encoded. Base64 is an encoding for binary data
that only uses 64 specific characters.

    --expand-data "content={{value:b64}}"

To trim the variable first, apply both functions (in this order):

    --expand-data "content={{value:trim:b64}}"

Example: get the contents of a file called `$HOME/.secret` into a variable
called `fix`. Make sure that the content is trimmed and percent-encoded sent
as POST data:

    curl \
        --variable %HOME=/home/default \
        --expand-variable fix@{{HOME}}/.secret \
        --expand-data "{{fix:trim:url}}" \
        --url https://example.com/

## `64dec`

The opposite of `b64`: this decodes base64-encoded content. Base64 is an
encoding for binary data that only uses 64 specific characters.

    --expand-data "content={{value:64dec}}"

Example: you get content using base64 encoding in the environment variable
`FILE`, but you want to pass it on in the curl invocation as part of the URL
in decoded form:

    curl \
        --variable %FILE \
        --expand-url https://example.com/{{FILE:64dec}}

**Note:** if `64dec` is used on content that is not valid Base64, for example
if it contains invalid characters not part of the Base64 set, the function
unconditionally returns the string `64dec-fail`.
