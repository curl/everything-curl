## List all command-line options

curl has more than two hundred command-line options and the number of options
keep increasing over time. Chances are the number of options will reach 250
within a few years.

In order to find out which options you need to perform as certain action, you
can, of course, list all options, scan through the list and pick the one you
are looking for. `curl --help` or simply `curl -h` will get you a list of all
existing options with a brief explanation. If you do not really know what
you are looking for, you probably will not be entirely satisfied.

Then you can instead opt to use `curl --manual` which will output the entire
man page for curl plus an appended tutorial for the most common use
cases. That is a thorough and complete document on how each option works
amassing several thousand lines of documentation. To wade through that is also
a tedious work and we encourage use of a search function through those text
masses. Some people will appreciate the man page in its [web
version](https://www.curl.se/docs/manpage.html).

