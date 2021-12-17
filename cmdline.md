# Command line basics

curl started out as a command-line tool and it has been invoked from shell
prompts and from within scripts by thousands of users over the years. curl has
established itself as one of those trusty tools that is there for you to help
you get your work done.

## Binaries and different platforms

The command-line tool "curl" is a binary executable file. The curl project
does not by itself distribute or provide binaries. Binary files are highly
system specific and oftentimes also bound to specific system versions.

To get a curl for your platform and your system, you need to get a curl
executable from somewhere. Many people build their own from the source code
provided by the curl project, lots of people install it using a package tool
for their operating system and yet another portion of users download binary
install packages from sources they trust.

No matter how you do it, make sure you are getting your version from a trusted
source and that you verify digital signatures or the authenticity of the
packages in other ways.

Also, remember that curl is often built to use third-party libraries to
perform and unless curl is built to use them statically you must also have
those third-party libraries installed; the exact set of libraries will
vary depending on the particular build you get.

## Command lines, quotes and aliases

There are many different command lines, shells and prompts in which curl can
be used. They all come with their own sets of limitations, rules and
guidelines to follow. The curl tool is designed to work with any of them
without causing troubles but there may be times when your specific command
line system does not match what others use or what is otherwise documented.

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
"curl.exe".

Different command-line environments will also have different maximum command
line lengths and force the users to limit how large amount of data that can be
put into a single line. curl adapts to this by offering a way to provide
command-line options through a file—or from stdin—using the [-K
option](cmdline/configfile.md).

## Garbage in gives garbage out

curl has little will of its own. It tries to please you and your wishes to a
large extent. It also means that it will try to play with what you give it. If
you misspell an option, it might do something unintended. If you pass in a
slightly illegal URL, chances are curl will still deal with it and proceed. It
means that you can pass in crazy data in some options and you can have curl
pass on that crazy data in its transfer operation.

This is a design choice, as it allows you to really tweak how curl does its
protocol communications and you can have curl massage your server
implementations in the most creative ways.
