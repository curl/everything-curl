# Windows

You can build curl on Windows in several different ways. We recommend using
the MSVC compiler from Microsoft or the free and open source mingw
compiler. The build process is, however, not limited to these.

If you use mingw, you might want to use the [autotools](autotools.md) build
system.

## Visual C++ project files

Using [CMake](cmake.md), you can generate a set of Visual Studio project
files:

    cmake -B build -G 'Visual Studio 17 2022'

Once generated, you import them and build with Visual Studio like normally.

You can even generate them for 32-bit Windows with:

    cmake -B build -G 'Visual Studio 17 2022' \
    -DCMAKE_GENERATOR_PLATFORM=x86

## Mingw

You can build curl with the mingw compiler suite. Use [CMake](cmake.md) to
generate the set of Makefiles for you:

    cmake -B build -G "MinGW Makefiles"
