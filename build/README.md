# Build curl and libcurl

The source code for this project is written in a way that allows it to be
compiled and built on just about any operating system and platform, with as
few restraints and requirements as possible.

If you have a 32bit (or larger) CPU architecture, if you have a C89 compliant
compiler and if you have roughly a POSIX supporting sockets API, then you can
most likely build curl and libcurl for your target system.

For the most popular platforms, the curl project comes with build systems
already done and prepared to allow you to easily build it yourself.

There are also friendly people and organizations who put together binary
packages of curl and libcurl and make them available for download. The
different options are explored below.

## The latest version?

Looking at the [curl website](https://curl.se), you can see the latest curl and
libcurl version released from the project. That is the latest source code
release package you can get.

When you opt for a prebuilt and prepackaged version for your operating system
or distribution of choice, you may not always find the latest version but you
might have to either be satisfied with the latest version someone has packaged
for your environment, or you need to build it yourself from source.

The curl project also provides info about the latest version in a somewhat
more machine-readable format on this URL: `https://curl.se/info`.

## Releases source code

The curl project creates source code that can be built to produce the two
products curl and libcurl. The conversion from source code to binaries
is often referred to as "building". You build curl and libcurl from source.

The curl project does not provide any built binaries at all — it only ships
the source code. The binaries which can be found on the download page of the
curl web and installed from other places on the Internet are all built and
provided to the world by other friendly people and organizations.

The source code consists of a large number of files containing C
code. Generally speaking, the same set of files are used to build binaries for
all platforms and computer architectures that curl supports. curl can be built
and run on a vast number of platforms. If you use a rare operating system
yourself, chances are that building curl from source is the easiest or perhaps
the only way to get curl.

Making it easy to build curl is a priority to the curl project, although we do
not always necessarily succeed.

## git vs release tarballs

When release tarballs are created, a few files are generated and included in
the final release bundle. Those generated files are not present in the git
repository, because they are generated and there is no need to store them in
git.

Of course, you can also opt to build the latest version that exists in the [git
repository](https://github.com/curl/curl). It could however be a bit more
fragile and probably requires slightly more attention to detail.

If you build curl from a git checkout, you need to generate some files
yourself before you can build. On Linux and Unix-like systems, do this by
running `autoreconf -fi` and on Windows, run `buildconf.bat`.

## On Linux and Unix-like systems

There are two distinctly different ways to build curl on Linux and other
Unix-like systems; there is the one using [the configure script](autotools.md)
and there is [the CMake approach](cmake.md).

There are two different build environments to cater to people's different
opinions and tastes. The configure-based build is arguably the more mature and
more encompassing build system and should probably be considered the default
one.

## On Windows

On Windows there are at least four different ways to build. The above
mentioned ways, [the CMake approach](cmake.md) and using
[configure](autotools.md) with msys work, but the more popular and
common methods are probably building with Microsoft's Visual Studio compiler
using either `nmake` or project files. See the build on
[windows](windows.md) section.

## Learn more

* [Autotools](autotools.md) - build with configure
* [CMake](cmake.md)
* [Separate install](separate.md)
* [On Windows](windows.md) - Windows-specific ways to build
* [Dependencies](deps.md)
* [TLS libraries](tls.md)
