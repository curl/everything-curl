# Build from source

The curl project creates source code that can be built to produce the two
products curl and libcurl. The actual conversion from source code to binaries
is often referred to as "building". You build curl and libcurl from source.

The curl project doesn't provide any built binaries at all, it only ships the
source code. The binaries which can be found on the download page of the curl
web and installed from other places on the Internet are all built and provided
to the world by other friendly people and organizations.

The source code consists of a large amount of files containing C
code. Generally speaking, the same set of files are used to build binaries for
all platforms and computer architectures that curl supports. curl can be built
and run on a vast amount of different platforms. If you use a rare operating
system yourself, chances are that building curl yourself from source is the
easiest or perhaps only way to get curl.

Making it easy to build curl is a priority to the curl project, although we
don't always necessarily succeed!

## git vs tarballs

When release tarballs are created, a few files are generated and included in
the final file that is the one used for the release. Those generated files are
not present in the git repository, exactly for that reason that they are
generated so there's no need to store them in git.

So, if you want to build curl from git you need to generate some of those
files yourself before you can build. On Linux and unix systems, do this by
running `./buildconf` and on Windows you run `buildconf.bat`.

## On Linux and unixlike systems

There are two distinctly different ways to build curl on Linux and other unix
like systems. There's the one using the configure script and there's the cmake
approach.

There are two different build environments to cater for people's different
opinons and tastes. The configure based build is arguably the more mature and
more complete build system and should probably be considered the default one.

### Autotools

The "Autotools" is a collection of different tools that used together generate
for example the `configure` script. The configure script is run by the user
who wants to build curl and it does a whole bunch of things:

 - it checks for features and functions present in your system

 - it offers command line options so that you as a builder can decide what to
   enable and disable in the build. Features and protocols etc can be toggled
   on/off. Or even compiler warning levels and more.

 - it offers command line options to let the builder point to specific
   installation paths for various third party dependencies that curl can be
   built to use.

 - specify on with file path the generated installation should be placed when
   ultimately the build is made and "make install" is invoked

In the most basic usage, just running `./configure` in the source directory is
enough. When the script completes, it outputs a summary of what options it has
detected/enabled and what featurs that are still disabled, some of them
possibly because it failed to detect the prensence of necesary third party
dependencies that are needed for those functions to work.

Then you invoke `make` to build the entire thing and then you can invoke `make
install` to install curl, libcurl and associated things. `make install`
requires that you have the correct rights in your system to create and write
files in the installation directory or you will get some errors.

### cross-compiling

Cross-compiling means that you build the source on one architecture but the
output is created to get run on a different one. For example you could build
the source on a Linux machine but have the output work to get run on a Windows
machine.

For cross-compiling to work, you need a dedicated compiler and build system
setup for the particular target system you want to build for. How to get and
install that is however not covered in this book.

Once you have a cross compiler, you can instruct configure to use that
compiler instead of the "native" compiler when it builds curl so that the end
result then can be moved over and used on the other machine.

### cmake

TBD

### static linking

TBD

## On Windows

TBD

### make

TBD

### cmake

TBD

### other compilers

TBD

## On other systems

TBD

## Porting curl to non-supported systems

TBD
