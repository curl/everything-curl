# Get curl for Linux

Linux distributions come with "packager managers" that let you install
software that they offer. Most Linux distributions offer curl and libcurl to
be installed if they are not installed by default.

## Ubuntu and Debian

`apt` is a tool to install prebuilt packages on Debian Linux and Ubuntu Linux
distributions and derivatives.

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

## Redhat and Centos

With Redhat Linux and CentOS Linux derivatives, you use `yum` to install
packages. Install the command-line tool with:

    yum install curl

You install the libcurl development package (with include files and some docs,
etc.) with this:

    yum install libcurl-devel


### nix

[Nix](https://nixos.org/nix/) is a package manager default to the NixOS
distribution, but it can also be used on any Linux distribution.

In order to install command-line tool:

    nix-env -i curl

## Arch Linux

curl is located in the core repository of Arch Linux. This means it should be 
installed automatically if you follow the normal installation procedure.

If curl is not installed, Arch Linux uses `pacman` to install packages:
    
    pacman -S curl
