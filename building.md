# 8. Building and installing

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

Looking at the curl web site at http://curl.haxx.se you can see the latest
curl and libcurl version relased from the project. That's the latest source
code package you can get.

When you opt for a prebuilt and prepackaged version for your operating system
or distribution of choice, you may not always find the latest version but you
might have to either be satisfied with the latest version somone has packaged
for your environment, or you need to build it yourself from source.

The curl project also provides info about the latest version in a somewhat
more machine-readable format on this URL: `http://curl.haxx.se/info`.

## Installing from your package repository

curl and libcurl have been around for a very long time and most Linux
distributions, BSD versions and other *nix versions have package repositories
that allow you to install curl packages.

The most common ones are described below.

### apt-get

`apt-get` is a tool to install pre-built packages on Debian Linux and Ubuntu
Linux distributions and derivates.

To install the curl command line tool, you usually just

    apt-get install curl

... and that then makes sure the dependencies are installed and usually
libcurl is then also installed as an individual package.

If you want to build applications against libcurl, you need a development
package installed - to get the include headers and some additional
documentation etc. You can then select a libcurl with the TLS backend you
prefer:

    apt-get install libcurl4-openssl-dev

or

    apt-get install libcurl4-nss-dev

or

    apt-get install libcurl4-gnutls-dev

### yum

With Redhat Linux and CentOS Linux derivates, you use `yum` to install
packages. Install the command line tool with:

    yum install curl

You install the libcurl development package (with include files and some docs
etc) with this:

    yum install curl-devel

(The Redhat family of Linux systems usually ship curl built to use NSS as TLS
backend.)

### homebrew

TBD
