## Command line options

When telling curl to do something, you invoke curl with zero, one or several
command-line options to accompany the URL or set of URLs you want the transfer
to be about. curl supports almost two hundred different options.

### Short options

Command line options pass on information to curl about how you want it to
behave. Like you can ask curl to switch on verbose mode with the -v option:

    $ curl -v http://example.com

-v is here used as a "short option". You write those with the minus symbol and
a single letter immediately following it. Many options are just switches that
switches something on or changes something between two known states. They can
be used with just that option name. You can then also combine several
single-letter options after the minus. To ask for both verbose mode and that
curl follows HTTP redirects:

    $ curl -vL http://example.com

The command-line parser in curl always parses the entire line and you can put
the options anywhere you like; they can also appear after the URL:

    $ curl http://example.com -Lv

### Long options

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

    $ curl --verbose http://example.com

and asking for HTTP redirects as well using the long format looks like:

    $ curl --verbose --location http://example.com

### Arguments to options

Not all options are just simple boolean flags that enable or disable
features. For some of them you need to pass on data, like perhaps a user name
or a path to a file. You do this by writing first the option and then the
argument, separated with a space. Like, for example, if you want to send an
arbitrary string of data in an HTTP POST to a server:

    $ curl -d arbitrary http://example.com

and it works the same way even if you use the long form of the option:

    $ curl --data arbitrary http://example.com

When you use the short options with arguments, you can, in fact, also write the
data without the space separator:

    $ curl -darbitrary http://example.com

### Negative options

For options that switch on something, there is also a way to switch it
off. You then use the long form of the option with an initial "no-" prefix
before the name. As an example, to switch off verbose mode:

    $ curl --no-verbose http://example.com
