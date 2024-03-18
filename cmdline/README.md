# Command line concepts

curl started out as a command-line tool and it has been invoked from shell
prompts and from within scripts by countless users over the years.

## Garbage in gives garbage out

curl has little will of its own. It tries to please you and your wishes to a
large extent. It also means that it tries to play with what you give it. If
you misspell an option, it might do something unintended. If you pass in a
slightly illegal URL, chances are curl still deals with it and proceeds. It
means that you can pass in crazy data in some options and you can have curl
pass on that crazy data in its transfer operation.

This is a design choice, as it allows you to really tweak how curl does its
protocol communications and you can have curl massage your server
implementations in the most creative ways.

  * [Differences](differences.md)
  * [Command line options](options.md)
  * [Options depend on version](versions.md)
  * [URLs](urls/)
  * [URL globbing](globbing.md)
  * [List options](listopts.md)
  * [Config file](configfile.md)
  * [Variables](variables.md)
  * [Passwords](passwords.md)
  * [Progress meter](progressmeter.md)
  * [Version](curlver.md)
  * [Persistent connections](persist.md)
  * [Exit code](exitcode.md)
  * [Copy as curl](copyas.md)
