# Long options

Single-letter options are convenient since they are quick to write and use, but
as there are only a limited number of letters in the alphabet and there are
many things to control, not all options are available like that. Long option
names are therefore provided for those. Also, as a convenience and to allow
scripts to become more readable, most short options have longer name
aliases.

Long options are always written with *two* minuses (or *dashes*, whichever you
prefer to call them) and then the name and you can only write one option name
per double-minus. Asking for verbose mode using the long option format looks
like:

    curl --verbose http://example.com

and asking for HTTP redirects as well using the long format looks like:

    curl --verbose --location http://example.com
