# Variables

This concept of variables for the command line and config files was added in
curl 8.3.0.

A user sets a *variable* to a plain string with `--variable varName=content`
or from the contents of a file with `--variable varName@file` where the file
can be stdin if set to a single dash (`-`).

A variable in this context is given a specific name and it holds contents. Any
number of variables can be set. If you set the same variable name again, it
gets overwritten with new content. Variable names are case sensitive, can be
up to 128 characters long and may consist of the characters a-z, A-Z, 0-9 and
underscore.

 * [Assign variables](assign.md)
 * [Expand variables](expand.md)
 * [Environment variables](env.md)
 * [Expand --variable](expand-variable.md)
 * [Expand functions](functions.md)
