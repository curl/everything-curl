# Differences

## Binaries and different platforms

The command-line tool `curl` is a *binary executable file*. The curl project
does not by itself distribute or provide binaries. Binary files are highly
system specific and oftentimes also bound to specific system versions.

Different curl versions, built by different people on different platforms
using different third party libraries with different built-time options makes
the tool offer different features in different places. In addition, curl is
continuously developed, so newer versions of the tool are likely to have more
and better features than the older ones.

## Command lines, quotes and aliases

There are many different command line environments, shells and prompts in
which curl can be used. They all come with their own sets of limitations,
rules and guidelines to follow. The curl tool is designed to work with any of
them without causing troubles but there may be times when your specific
command line system does not match what others use or what is otherwise
documented.

One way that command-line systems differ, for example, is how you can put
quotes around arguments such as to embed spaces or special symbols. In
most Unix-like shells you use double quotes (") and single quotes (')
depending if you want to allow variable expansions or not within the quoted
string, but on Windows there is no support for the single quote version.

In some environments, like PowerShell on Windows, the authors of the command
line system decided they know better and "help" the user to use another tool
instead of curl when `curl` is typed, by providing an alias that takes
precedence when a command line is executed. In order to use curl properly with
PowerShell, you need to type in its full name including the extension:
`curl.exe` or remove the alias.

Different command-line environments have different maximum command line lengths
and force users to limit how large an amount of data is put into a single line.
curl adapts to this by offering a way to provide
command-line options through a file or stdin using the [-K option](configfile.md).
