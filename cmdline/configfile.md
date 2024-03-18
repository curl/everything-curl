# Config file

Curl commands with multiple command-line options can become cumbersome to work
with. The number of characters can even exceed the maximum length allowed by
your terminal application.

To aid such situations, curl allows you to write command-line options in a
plain text config file and tell curl to read options from that file when
applicable.

You can also use config files to assign data to variables and transform the
data with functions, making them incredibly useful. This is discussed in the
[Variables](variables.md) section.

Some examples below contain multiple lines for readability. The backslash
(`\`) is used to instruct the terminal to ignore the newline.

## Specify the config file to use

Using the `-K` or long form `--config` option tells curl to read from a config file.

    curl  \
        --config configFile.txt \
        --url https://example.com

The file path specified is relative to the current directory in your terminal.

You can name the config file whatever you like. `configFile.txt` is used for
simplicity in the example above.

## Syntax

Enter one command per line. Use a hash symbol for comments:

    # curl config file

    # Follow redirects
    --location

    # Do a HEAD request
    --head

## Command line options

You can use both short and long options, exactly as you would write them on a command line. 

You can also write the long option WITHOUT the leading two dashes to make
it easier to read. 

    # curl config file

    # Follow redirects
    location

    # Do a HEAD request
    head

## Arguments

A command line option that takes an argument must have its argument provided on
the SAME LINE as the option. 

    # curl config file

    user-agent "Everything-is-an-agent"

You can also use `=` or `:` between the option and its argument. As you see
above, it is not necessary, but some like the clarity it offers. Setting the
user-agent option again:

    # curl config file

    user-agent = "Everything-is-an-agent"

The user agent string example we have used above has no white spaces, so the
quotes are technically not needed:

    # curl config file

    user-agent = Everything-is-an-agent

See "When to use quotes" below for more info on when quotes should be used.

## URLs

When entering URLs at the command line, everything that is not an option is
assumed to be a URL. However, in a config file, you must specify a URL with
`--url` or `url`.

    # curl config file

    url = https://example.com

## When to use quotes

You need to use double quotes when:

* the parameter contains white space, or starts with the characters `:` or `=`.
* you need to use escape sequences (available options: `\\`, `\"`, `\t`, `\n`, `\r` and `\v`. A backslash preceding any other letter is ignored).

If a parameter containing white space is not enclosed in double quotes, curl
considers the next space or newline as the end of the argument.

## Default config file

When curl is invoked, it always (unless `-q` is used), checks for a default
config file and uses it if found.

Curl looks for the default config file in the following locations, in this order:

1) `$CURL_HOME/.curlrc`

2) `$XDG_CONFIG_HOME/.curlrc` (Added in 7.73.0)

3) `$HOME/.curlrc`

4) Windows: `%USERPROFILE%\\.curlrc`

5) Windows: `%APPDATA%\\.curlrc`

6) Windows: `%USERPROFILE%\\Application Data\\.curlrc`

7) Non-Windows: use getpwuid to find the home directory

8) On Windows, if it finds no `.curlrc` file in the sequence described above,
it checks for one in the same directory the curl executable is placed.

On Windows two filenames are checked per location: `.curlrc` and `_curlrc`,
preferring the former. Ancient curl versions on Windows checked for `_curlrc`
only.
