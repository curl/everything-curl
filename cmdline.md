# 6. Command line

curl started out as a command line tool and it has been invoked from shell
prompts and from within scripts by thousands of users over the years. curl has
established itself as one of those trusty tools that is there for you to help
you get your work done.

## Binaries and different platforms

The command line tool "curl" is a binary executable file. The curl project
does not by itself distribute or provide binaries. Binary files are highly
system specific and oftentimes also bound to specific system versions.

To get a curl for your platform and your system, you need to get a curl
executable from somewhere. Many people build their own from the source code
provided by the curl project, lots of people install it using a package tool
for their operating system and yet another portion of users download binary
install packages from sources they trust.

No matter how you do it, make sure you're getting your version from a trusted
source and that you verify digital signatures or the authenticity of the
packages in other ways.

Also, remember that curl is often built to use third party libraries to
perform and unless curl is built to use them statically you must also have
those third party libraries installed - and they exact set of libraries will
vary depending on the particular build you get.

## Command lines, quotes and aliases

There are many different command lines, shells and prompts in which curl can
be used. They all come with their own sets of limitations, rules and
guidelines to follow. The curl tool is designed to work with any of them
without causing troubles but there may be times when your specific command
line system doesn't match what others use or what is otherwise documented.

One way that command line systems differ, for example, is how you can put
quotes around arguments to for example embed spaces or special symbols. In
most unix-like shells you use double quotes (") and single quotes (')
depending if you want to allow variable expansions or not within the quoted
string, but on Windows there's no support for the single quote version.

In some environments, like PowerShell on Windows, the authors of the command
line system decided they know better and "help" the user to use another tool
instead of curl when curl is typed, by providing an alias that takes precedent
when a command line is executed. In order to use curl properly with
powershell, you need to type in its full name including the extension:
"curl.exe".

Different command line environments will also have different maximum command
line lengths and force the users to limit how large amount of data that can be
put into a single line. curl adapts to this by offering a way to provide
command line options through a file or on stdin - using the -K option.

## Garbage in, garbage out

curl has very little will of its own. It tries to please you and your wishes
to a very large extent. It also means that it will try to play with what you
give it. If you misspell an option, it might do something unintended. If you
pass in a slightly illegal URL, chances are curl will still deal with it and
proceed. It means that you can pass in crazy data in some options and you can
have curl pass on that crazy data in its transfer operation.

This is a design choice, as it allows you to really tweak how curl does its
the protocol communications and you can have curl massage your server
implemenations in the most creative ways.

## Command line options

When telling curl to do something, you invoke curl with zero, one or several
command line options to accompany the URL or set of URLs you want the transfer
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

The command line parser in curl always parses the entire line and you can put
the options anywhere you like, they can also appear after the URL:

    $ curl http://example.com -Lv

### Long options

Single letter options are convient since they are quick to write and use, but
as there are only a limited number of letters in the alphabet and there are
many things to control, not all options are available like that. Long option
names are therefore provided for those. Also, as a convenience and to allow
scripts to become more readable, all the short options have longer name
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
features. For some of them you need to pass on data. Like perhaps a user name
or a path to a file. You do this by writing first the option and then the
argument, separated with a space. Like for example if you want to send send an
arbitrary string of data in a HTTP POST to a server:

    $ curl -d arbitrary http://example.com

and it works the same way even if you use the long form of the option:

    $ curl --data arbitrary http://example.com

When you use the short options with arguments, you can in fact also write the
data without the space separator:

    $ curl -darbitrary http://example.com

### Negate options

For options that switch on something, there is also a way to switch it
off. You then use the long form of the option with an initial "no-" prefix
before the name. As an example, to switch off verbose mode:

    $ curl --no-verbose http://example.com

## URLs

curl is called curl exactly because a substring in its name is URL (Uniform
Resource Locator). It operates on URLs. URL is the name we casually use for
the web address strings, like the ones we usually see prefixed with http:// or
starting with www.

URL is strictly speaking the former name for this. URI (Uniform Resource
Identifier) is the more modern and correct name for it. It is defined in
RFC3986.

Where curl accepts a "URL" as input, it is then really a "URI". Most of the
protocols curl understands also have a corresponding URI syntax document that
describes how that particular URI format works.

curl assumes that you give it a valid URL and it only does limited checks of
the format in order to extract the information it deems necessary to perform
its operation. You can for example most probably pass in illegal letters in
the URL without curl noticing or caring and it will just pass them on.

### Scheme

URLs start with the "scheme", which is the official name for the "http://"
part. That tells which protocol the URL uses. As a convenience, curl also
allows users to leave out the scheme part from URLs. Then it guesses which
protocol to use based on the first part of the host name.

### Name and password

After the scheme, there can be a possible user name and password embedded.
The use of this syntax is usually frowned upon these days since you easily
leak this information in scripts or otherwise. For example, listing the
directory of an FTP server using a given name and password:

    $ curl ftp://user:password@example.com/

The presense of user name and password in the URL is completely optional. curl
also allows that information to be provide with normal command line options,
outside of the URL.

### Host name or address

The host name part of the URL is of course simply a name that can be resolved
to an numerical IP address, or the numerical address itself. When specifying a
numerical address, use the dotted version for IPv4 addresses:

    $ curl http://127.0.0.1/

... and for IPv6 addresses the numerical version needs to be within square
brackets:

    $ curl http://[::1]/

When a host name is used, the converting of the name to an IP address is
typically done using the system's resolver functions. That normally lets a
sysadmin provide local name looksups in the `/etc/hosts` file (or equivalent).

### Port number

Each protocol has a "default port" that curl will use for it, unless a
specified port number is given. The optional port number can be provided
within the URL after the host name part, as a colon and the port number
written in decimal. For example, asking for a HTTP document on port 8080:

    $ curl http://example.com:8080/

With the name specified as an IPv4 address:

    $ curl http://127.0.0.1:8080/

With the name given as an IPv6 address:

    $ curl http://[fdea::1]:8080/

### Path

Every URL contains a path. If there's none given, "/" is implied. The path is
sent to the specified server to identify exactly which resource that is
requested or that will be provided.

The exact use of the path is protocol dependent. For example, getting a file
README from the default anonymous user from an FTP server:

    $ curl ftp://ftp.example.com/README

For the protocols that have a directory concept, ending the URL with a
trailing slash means that it is a directory and not a file. Thus asking for a
directory list from an FTP server is implied with such a slash:

    $ curl ftp://ftp.example.com/tmp/

### Fragment

URLs offer a "fragment part". That's usually seen as a hash symbol (#) and a
name for a specific name within a web page in browsers. curl supports
fragments fine when a URL is passed to it, but the fragment part is never
actually sent over the wire so it doesn't make a difference to curl's
operations wether it is present or not.

### Browsers' "address bar"

It is important to realize that when you use a modern web browser, the
"address bar" they tend to feature at the top of their main windows are not
using "URLs" or even "URIs". They are in fact mostly using IRIs, which is a
superset of URIs to allow internationalization like non-latin symbols and
more, but it usually goes beyond that too as they tend to for example handle
spaces and do magic things on percent encoding in ways none of these mention
specifications say a client should do.

The address bar is quite simply an interface for humans to enter and see
URI-like strings.

Sometimes the differences between what you see in a browser's address bar and
what you can pass in to curl is significant.

## Many options and URLs

As mentioned above, curl supports hundreds of command line options and it also
supports an unlimited number of URLs. If your shell or command line system
supports it, there's really no limit to how long command line you can pass to
curl.

curl will parse the entire command line first, apply the wishes from the
command line options used, and then go over the URLs one by one (in a left to
right order) to perform the operations.

For some options (for example -o or -O that tell curl where to store the
transfer), you may want to specify one option for each URL on the command
line.

curl will return an exit code for its operation on the last URL used.

## Separate options per URL

In previous sections we described how curl always parses all options in the
whole command line and applies those to all the URLs that it transfers.

That was a simplification: curl also offers an option (-;, --next) that
inserts a sort of boundary between a set of options and URLs that it will
apply the options for. When the command line parses finds a --next option, it
applies the following options to the next set of URLs to operate with. The
--next option thus works as a *divider* between a set of options and URLs. You
can use as many --next options as you please.

As an example, we do a HTTP GET to a URL and follow redirects, we then make a
second HTTP POST to a different URL and we round it up with a HEAD request to
a third URL. All in a single command line:

    $ curl --location http://example.com/1 --next
      --data sendthis http://example.com/2 --next
      --head http://example.com/3

Trying something like that _without_ the --next options on the command line
would generate an illegal command line since curl would attempt to combine
both a POST and a HEAD:

    Warning: You can only select one HTTP request method! You asked for both POST
    Warning: (-d, --data) and HEAD (-I, --head).

## Connection reuse

Setting up a TCP connection and especially a TLS connection can be a slow
process, even on high bandwidth networks.

It can be useful to remember that curl has a connection pool internally which
keeps previously used connections alive and around for a while after they were
used so that subsequent requests to the same hosts can reuse an already
established connection.

Of course they can only be kept alive for as long as the curl tool is running,
but it is a very good reason for trying to get several transfers done within
the same command line instead of running several independent curl command line
invokes.

## URL Globbing

TBD

## List all options

TBD

## Config file

TBD

## Passwords and snooping

TBD

## The progress meter

TBD
