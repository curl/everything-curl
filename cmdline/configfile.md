## Config file

You can easily end up with curl command lines that use a large number of
command-line options, making them rather hard to work with. Sometimes the
length of the command line you want to enter even hits the maximum length your
command-line system allows. The Microsoft Windows command prompt being an
example of something that has a fairly small maximum line length.

To aid such situations, curl offers a feature we call "config file". It allows
you to write command-line options in a text file instead and then tell curl to
read options from that file in addition to the command line.

You tell curl to read more command-line options from a specific file with the
-K/--config option, like this:

    curl -K cmdline.txt http://example.com

…and in the `cmdline.txt` file (which, of course, can use any file name you
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
the same line as the option. For example changing the User-Agent HTTP header
can be done with

    user-agent "Everything-is-an-agent"

To allow the config files to look even more like a true config file, it also
allows you to use '=' or ':' between the option and its argument. As you see
above it is not necessary, but some like the clarity it offers. Setting the
user-agent option again:

    user-agent = "Everything-is-an-agent"

The argument to an option can be specified without double quotes and then curl
will treat the next space or newline as the end of the argument. So if you
want to provide an argument with embedded spaces you must use double quotes.

The user agent string example we have used above has no white spaces and
therefore it can also be provided without the quotes like:

    user-agent = Everything-is-an-agent

Finally, if you want to provide a URL in a config file, you must do that the
`--url` way, or just with `url`, and not like on the command line where
everything that is not an option is assumed to be a URL. So you provide a URL
for curl like this:

    url = "http://example.com"

### Default config file

When curl is invoked, it always (unless `-q` is used) checks for a default
config file and uses it if found. The file name it checks for is `.curlrc` on
Unix-like systems and `_curlrc` on Windows.

The default config file is checked for in the following places in this order:

1. curl tries to find the "home directory": It first checks for the CURL_HOME
and then the HOME environment variables. Failing that, it uses `getpwuid()` on
Unix-like systems (which returns the home directory given the current user in
your system). On Windows, it then checks for the APPDATA variable, or as a
last resort the '%USERPROFILE%\Application Data'.

2. On Windows, if there is no _curlrc file in the home directory, it checks for one
in the same directory the curl executable is placed. On Unix-like systems, it will
simply try to load .curlrc from the determined home directory.

