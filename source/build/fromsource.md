# Build from source

The curl project creates source code that can be built to produce the two
products curl and libcurl. The conversion from source code to binaries
is often referred to as "building". You build curl and libcurl from source.

The curl project does not provide any built binaries at all—it only ships the
source code. The binaries which can be found on the download page of the curl
web and installed from other places on the Internet are all built and provided
to the world by other friendly people and organizations.

The source code consists of a large number of files containing C
code. Generally speaking, the same set of files are used to build binaries for
all platforms and computer architectures that curl supports. curl can be built
and run on a vast number of platforms. If you use a rare operating system
yourself, chances are that building curl from source is the easiest or perhaps
the only way to get curl.

Making it easy to build curl is a priority to the curl project, although we do
not always necessarily succeed!

## git vs tarballs

When release tarballs are created, a few files are generated and included in
the final release bundle. Those generated files are not present in the git
repository, because they are generated and there is no need to
store them in git.

So, if you want to build curl from git you need to generate some of those
files yourself before you can build. On Linux and Unix-like systems, do this by
running `./buildconf` and on Windows, run `buildconf.bat`.

## On Linux and Unix-like systems

There are two distinctly different ways to build curl on Linux and other
Unix-like systems; there is the one using [autotools.md](the configure script)
and there is [cmake.md](the CMake approach).

There are two different build environments to cater to people's different
opinions and tastes. The configure-based build is arguably the more mature and
more encompassing build system and should probably be considered the default
one.

## On Windows

On Windows there are at least four different ways to build. The above
mentioned ways, [cmake.md](the CMake approach) and using
[configure](autotools.md) with msys work, but the more popular and common
methods are probably building with Microsoft's Visual Studio compiler using
either `nmake` or project files. See the build on [windows](windows.md)
section.

* [Autotools](autotools.md) - build with configure
* [CMake](cmake.md)
* [On Windows](windows.md) - Windows-specific ways to build
