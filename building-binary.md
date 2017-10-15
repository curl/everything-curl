## Installing prebuilt binaries

There are many friendly people and organizations who put together binary
packages of curl and libcurl and make them available for download.

Many operating systems offer a "package repository" that is populated with
software packages for you to install. From the [curl download
page](https://curl.haxx.se/download.html) you can also follow links to plain
binary packages for popular operating systems.

## Installing from your package repository

curl and libcurl have been around for a very long time and most Linux
distributions, BSD versions and other *nix versions have package repositories
that allow you to install curl packages.

The most common ones are described below.

### apt

`apt` is a tool to install prebuilt packages on Debian Linux and Ubuntu Linux
distributions and derivates.

To install the curl command-line tool, you usually just

    apt install curl

…and that then makes sure the dependencies are installed and usually
libcurl is then also installed as an individual package.

If you want to build applications against libcurl, you need a development
package installed to get the include headers and some additional
documentation, etc. You can then select a libcurl with the TLS backend you
prefer:

    apt install libcurl4-openssl-dev

or

    apt install libcurl4-nss-dev

or

    apt install libcurl4-gnutls-dev

### yum

With Redhat Linux and CentOS Linux derivates, you use `yum` to install
packages. Install the command-line tool with:

    yum install curl

You install the libcurl development package (with include files and some docs,
etc.) with this:

    yum install curl-devel

(The Redhat family of Linux systems usually ship curl built to use NSS as TLS
backend.)


### nix

[Nix](https://nixos.org/nix/) is a package manager default to the NixOS distribution, but it can also be used on any Linux distribution. 

In order to install command-line tool:

    nix-env -i curl

### homebrew

[Homebrew](https://brew.sh/) is an OSX package manager. It does not come by default, but one can install it easily.

To install the command-line tool:

    brew install curl

### cygwin

TBD

## Binary packages for Windows

TBD
