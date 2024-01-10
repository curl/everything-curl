# MSYS2

[MSYS2](https://www.msys2.org/) is a popular build system for Windows based on [mingw-w64](https://www.mingw-w64.org/) and includes both gcc and clang compilers. MSYS2 uses a package manager named `pacman` (a port from arch-linux) and has about 2000 precompiled [mingw-packages](https://github.com/msys2/MINGW-packages). MSYS2 is designed to build standalone software: the binaries built with mingw-w64 compilers do not depend on MSYS2 itself\[^1].

## Get curl and libcurl on MSYS2

Current information about the [`mingw-w64-curl`](https://github.com/msys2/MINGW-packages/blob/master/mingw-w64-curl/PKGBUILD) package can be found on the msys2 website: https://packages.msys2.org/base/mingw-w64-curl. Here we can also find installation instructions for the various available flavors. For example to install the default x64 binary for curl we run:

    pacman -Sy mingw-w64-x86_64-curl

This package contains both the `curl` command line tool as well as libcurl headers and shared libraries. The default `curl` packages are built with the OpenSSL backend and hence depend on `mingw-w64-x86_64-openssl`. There are also `mingw-w64-x86_64-curl-gnutls` and `mingw-w64-x86_64-curl-gnutls` packages, refer to the [msys2 website](https://packages.msys2.org/base/mingw-w64-curl) for more details.

Just like on Linux, we can use `pkg-config` to query the flags needed to build against libcurl. Start msys2 using the mingw64 shell (which automatically sets the path to include `/mingw64`) and run:

    pkg-config --cflags libcurl
    # -IC:/msys64/mingw64/include

    pkg-config --libs libcurl
    # -LC:/msys64/mingw64/lib -lcurl

The pacman package manager installs precompiled binaries. Next up we explain
how to use pacman to build curl locally, for example to customize the
configuration.

## Building libcurl on MSYS2

Building packages with pacman is almost just as simple as installing. The entire process is contained in the [PKGBUILD](https://github.com/msys2/MINGW-packages/blob/master/mingw-w64-curl/PKGBUILD) file from the `mingw-w64-curl` package. We can easily modify the file to rebuild the package ourselves.

If we start with a clean msys2 installation, we first want to install some build tools, like `autoconf`, `patch` and `git`. Start the msys2 shell and run:

    # Sync the repositories
    pacman -Syu

    # Install git, autoconf, patch, etc
    pacman -S git base-devel

    # Install GCC for x86_64
    pacman -S mingw-w64-x86_64-toolchain

Now clone the `mingw-packages` repository and go to the `mingw-w64-curl` package:

    git clone https://github.com/msys2/MINGW-packages
    cd MINGW-packages/mingw-w64-curl

This directory contains the PKGBUILD file and patches that are used for
building curl. Have a look at the PKGBUILD file to see what is going on. Now
to compile it, we can do:

    makepkg-mingw --syncdeps --skippgpcheck

That is it. The `--syncdeps` parameter automatically checks and prompts to
install dependencies of `mingw-w64-curl` if these are not yet installed. Once
the process is complete you have 3 new files in the current directory, for
example:

* `pacman -U mingw-w64-x86_64-curl-7.80.0-1-any.pkg.tar.zst`
* `pacman -U mingw-w64-x86_64-curl-gnutls-7.80.0-1-any.pkg.tar.zst`
* `pacman -U mingw-w64-x86_64-curl-winssl-7.80.0-1-any.pkg.tar.zst`

Use the `pacman -u` command to install such a local package file:

    pacman -U mingw-w64-x86_64-curl-winssl-7.80.0-1-any.pkg.tar.zst

Have a look at the [msys2
docs](https://www.msys2.org/docs/package-management/) or join the
[gitter](https://gitter.im/msys2/msys2) to learn more about building with
pacman and msys2.

\[^1]: Be careful not to confuse the [mingw-package](https://github.com/msys2/MINGW-packages) `mingw-w64-curl` with the [msys-packages](https://github.com/msys2/MSYS2-packages) `curl` and `curl-devel`. The latter are part of msys2 environment itself (e.g. to support pacman downloads), but not suitable for redistribution. To build redistributable software that does not depend on MSYS2 itself, you always need `mingw-w64-…` packages and toolchains.
