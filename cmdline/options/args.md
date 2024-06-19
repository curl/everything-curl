# Arguments to options

Not all options are just simple boolean flags that enable or disable
features. For some of them you need to pass on data, like perhaps a username
or a path to a file. You do this by writing first the option and then the
argument, separated with a space. Like, for example, if you want to send an
arbitrary string of data in an HTTP POST to a server:

    curl -d arbitrary http://example.com

and it works the same way even if you use the long form of the option:

    curl --data arbitrary http://example.com

When you use the short options with arguments, you can, in fact, also write the
data without the space separator:

    curl -darbitrary http://example.com

## Arguments with spaces

At times you want to pass on an argument to an option, and that argument
contains one or more spaces. For example you want to set the user-agent field
curl uses to be exactly `I am your father`, including those three spaces. Then
you need to put quotes around the string when you pass it to curl on the
command line. The exact quotes to use varies depending on your shell/command
prompt, but generally it works with double quotes in most places:

    curl -A "I am your father" http://example.com

Failing to use quotes, like if you would write the command line like this:

    curl -A I am your father http://example.com

… makes curl only use 'I' as a user-agent string, and the following strings,
`am`, `your` and `father` are instead treated as separate URLs since they do
not start with `-` to indicate that they are options and curl only ever
handles options and URLs.

To make the string itself contain double quotes, which is common when you for
example want to send a string of JSON to the server, you may need to use
single quotes (except on Windows, where single quotes do not work the same
way). Send the JSON string `{ "name": "Darth" }`:

    curl -d '{ "name": "Darth" }' http://example.com

Or if you want to avoid the single quote thing, you may prefer to send the
data to curl via a file, which then does not need the extra quoting. Assuming
we call the file 'json' that contains the above mentioned data:

    curl -d @json http://example.com
