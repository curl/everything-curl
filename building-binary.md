## Installing prebuilt binaries

There are many friendly people and organizations who put together binary
packages of curl and libcurl and make them available for download.

Many operating systems offer a "package repository" that is populated with
software packages for you to install. From the [curl download
page](http://curl.haxx.se/download.html) you can also follow links to plain
binary packages for popular operating systems.

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

### cygwin

TBD

## Binary packages for Windows

TBD
