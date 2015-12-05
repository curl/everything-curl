## List all command line options

curl has more than one hundred command line options and the number of options
keep increasing over time. Chances are the number of options will surpass 200
within a year or two.

In order to find out which options you need to perform as certain action, you
can of course list all options, scan through the list and pick the one you're
looking for. `curl --help` or simply `curl -h` will get you a list of all
existing options with a brief explanation. If you don't really know what
you're looking for, you probably won't be entirely satisfied.

Then you can instead opt to use `curl --manual` which then will output the
entire man page for curl plus an appended tutorial for the most common use
cases. That is a very thorough and complete document on how each option
works. Several thousand lines of documentation. To wade through that is also a
tedious work and we encourage use of a search function through those text
masses. Some people will appreciate the man page in its [web
version](http://curl.haxx.se/docs/manpage.html).

## Config file

You can easily end up with curl command lines that use a very lage amount of
command line options, make it rather hard to work with. Sometimes the length
of the command line you want to enter even hits the maximum length your
command line system allows. The Microsoft windows command prompt being an
example of something that has a fairly small maximum line length.

To aid such sitations, curl offers a feature we call "config file". It
basically allows you to write command line options in a text file instead and
then tell curl to read options from that file in addition to the command line.

You tell curl to read more command line options from a specific file with the
-K/--config option, like this:

    curl -K cmdline.txt http://example.com

... and in the `cmdline.txt` file (which of course can use any file name you
please) you enter each command line per line:

    # this is a comment, we ask to follow redirects
    --location
    # ask to do a HEAD request
    --head

The config file accepts both short and long options, exactly as you would
write them on a command line. As a special extra feature, it also allows you
to write the long format of the options without the leading two dashes to make
it easier to read. Using that style, the config file shown above can
alternatively be written as:

    # this is a comment, we ask to follow redirects
    location
    # ask to do a HEAD request
    head

Command line options that take an argument must have its argument provided on
the same line as the option. For example changing the user-agent HTTP header
can be done with

    user-agent "Everything-is-an-agent"

### Default config file

TBD

## Passwords and snooping

TBD

## The progress meter

TBD
