# Assign variables

## Setting variables

You can set variables at the command line with `--variable` or in config files
with `variable` (no dashes):

    curl --variable varName=content

or in a config file:

    # Curl config file

    variable varName=content

## Assigning contents from file

You can assign the contents of a plain text file to a variable, too:

    curl --variable varName@filename

Starting in curl 8.12.0, you can get a byte range from content by appending
`[N-M]` to the variable name, where `N` and `M` are numerical byte offsets
into the content where the second number can be omitted to mean until end of
data. For example, get the contents from a file from byte offset 100 to 199,
inclusive:

    curl --variable "varName[100-199]@filename"

Alternatively, get offset three to twelve from a plain text:

    curl --variable "varName[3-12]=thefulltexttogetrangefrom"

Given a byte range that has no data results in an empty string. Asking for a
range that is larger than the content makes curl use the piece of the data
that exists.
