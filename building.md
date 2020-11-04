# Building and installing

The source code for this project is written in a way that allows it to get
compiled and built on just about any operating system and platform, with as
few restraints and requirements as possible.

If you have a 32bit (or larger) CPU architecture, if you have a C89 compliant
compiler and if you have roughly a POSIX supporting sockets API, then you can
most likely build curl and libcurl for your target system.

For the most popular platforms, the curl project comes with build systems
already done and prepared to allow you to easily build it yourself.

There are also friendly people and organizations who put together binary
packages of curl and libcurl and make them available for download. The
different options will be explored below.

## The latest version?

Looking at the curl web site at https://www.curl.se you can see the latest
curl and libcurl version released from the project. That is the latest source
code package you can get.

When you opt for a prebuilt and prepackaged version for your operating system
or distribution of choice, you may not always find the latest version but you
might have to either be satisfied with the latest version someone has packaged
for your environment, or you need to build it yourself from source.

The curl project also provides info about the latest version in a somewhat
more machine-readable format on this URL: `https://www.curl.se/info`.

## off git!

Of course, when building from source you can also always opt to build the
latest version that exist in the [git
repository](https://github.com/curl/curl). It could however be a bit more
fragile and probably requires slightly more attention to detail.
