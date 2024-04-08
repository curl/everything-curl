# Windows

You can build curl on Windows in several different ways. We recommend using
the MSVC compiler from Microsoft or the free and open source mingw
compiler. The build process is, however, not limited to these.

If you use mingw, you might want to use the [autotools](autotools.md) build
system.

## winbuild

This is how to build curl and libcurl using the command line.

Build with MSVC using the `nmake` utility like this:

    cd winbuild

Decide what options to enable/disable in your build. The `README.md` file in
that directory details them all, but an example command line could look like
this (split into several lines for readability):

    nmake WITH_SSL=dll WITH_NGHTTP2=dll ENABLE_IPV6=yes \
    WITH_ZLIB=dll MACHINE=x64 

## Visual C++ project files

Using [CMake](cmake.md), you can generate a set of Visual Studio project
files:

    cmake -B build -G 'Visual Studio 17 2022'

Once generated, you import them and build with Visual Studio like normally.

## Mingw

You can build curl with the mingw compiler suite. Use [CMake](cmake.md) to
generate the set of Makefiles for you:

    cmake -B build -G "MinGW Makefiles"
