# Build from source

The curl project creates source code that can be built to produce the two
products curl and libcurl. The conversion from source code to binaries
is often referred to as "building". You build curl and libcurl from source.

The curl project doesn't provide any built binaries at all, it only ships the
source code. The binaries which can be found on the download page of the curl
web and installed from other places on the Internet are all built and provided
to the world by other friendly people and organizations.

The source code consists of a large number of files containing C
code. Generally speaking, the same set of files are used to build binaries for
all platforms and computer architectures that curl supports. curl can be built
and run on a vast number of platforms. If you use a rare operating system
yourself, chances are that building curl from source is the easiest or perhaps
the only way to get curl.

Making it easy to build curl is a priority to the curl project, although we
don't always necessarily succeed!

## git vs tarballs

When release tarballs are created, a few files are generated and included in
the final release file. Those generated files are not present in the git
repository, because they are generated and there is no need to
store them in git.

So, if you want to build curl from git you need to generate some of those
files yourself before you can build. On Linux and Unix systems, do this by
running `./buildconf` and on Windows you run `buildconf.bat`.

## On Linux and Unix-like systems

There are two distinctly different ways to build curl on Linux and other
Unix-like systems. There's the one using the configure script and there's the
CMake approach.

There are two different build environments to cater for people's different
opinions and tastes. The configure based build is arguably the more mature and
more convering build system and should probably be considered the default one.

### Autotools

The "Autotools" is a collection of different tools that used together generate
the `configure` script. The configure script is run by the user
who wants to build curl and it does a whole bunch of things:

 - it checks for features and functions present in your system

 - it offers command-line options so that you as a builder can decide what to
   enable and disable in the build. Features and protocols, etc., can be toggled
   on/off. Or even compiler warning levels and more.

 - it offers command-line options to let the builder point to specific
   installation paths for various third-party dependencies that curl can be
   built to use.

 - specifies on which file path the generated installation should be placed when
   ultimately the build is made and "make install" is invoked

In the most basic usage, just running `./configure` in the source directory is
enough. When the script completes, it outputs a summary of what options it has
detected/enabled and what features that are still disabled, some of them
possibly because it failed to detect the presence of necessary third-party
dependencies that are needed for those functions to work.

Then you invoke `make` to build the entire thing and `make
install` to install curl, libcurl and associated things. `make install`
requires that you have the correct rights in your system to create and write
files in the installation directory or you will get some errors.

### cross-compiling

Cross-compiling means that you build the source on one architecture but the
output is created to be run on a different one. For example, you could build
the source on a Linux machine but have the output work to run on a Windows
machine.

For cross-compiling to work, you need a dedicated compiler and build system
setup for the particular target system for which you want to build. How to get
and install that system is not covered in this book.

Once you have a cross compiler, you can instruct configure to use that
compiler instead of the "native" compiler when it builds curl so that the end
result then can be moved over and used on the other machine.

### CMake

TBD

### static linking

TBD

## On Windows

TBD

### make

TBD

### CMake

TBD

### other compilers

TBD

## On other systems

TBD

## Porting curl to non-supported systems

TBD

## Select TLS backend

The configure based build offers the user to select from a wide variety of
different TLS libraries when building. You select them by using the correct
command line options.

The default OpenSSL configure check will also detect and use BoringSSL or
libressl.

 - BoringSSL: - by default
 - GnuTLS: `--without-ssl --with-gnutls`.
 - NSS: `--without-ssl --with-nss`
 - OpenSSL: - by default
 - PolarSSL: `--without-ssl --with-polarssl`
 - Wolfssl: `--without-ssl --with-wolfssl`
 - libressl: - by default
 - mbedTLS: `--without-ssl --with-mbedtls`
 - schannel: `--without-ssl --with-winssl`
 - secure transport: `--with-winssl --with-darwinssl`

All the `--with-*` options also allow you to provide the install prefix so
that configure will search for the specific library where you tell it to.
