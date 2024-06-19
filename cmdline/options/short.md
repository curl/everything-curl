# Short options

Command line options pass on information to curl about how you want it to
behave. Like you can ask curl to switch on verbose mode with the -v option:

    curl -v http://example.com

-v is here used as a "short option". You write those with the minus symbol and
a single letter immediately following it. Many options are just switches that
switch something on or change something between two known states. They can
be used with just that option name. You can then also combine several
single-letter options after the minus. To ask for both verbose mode and that
curl follows HTTP redirects:

    curl -vL http://example.com

The command-line parser in curl always parses the entire line and you can put
the options anywhere you like; they can also appear after the URL:

    curl http://example.com -Lv

and the two separate short options can of course also be specified separately,
like:

    curl -v -L http://example.com
