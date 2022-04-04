# CMake

CMake is an alternative build method that works on most modern platforms,
including Windows. Using this method you first need to have cmake installed on
your build machine, invoke cmake to generate the build files and then
build. With cmake's `-G` flag, you select which build system to generate files
for. See `cmake --help` for the list of "generators" your cmake installation
supports.

On the cmake command line, the first argument specifies where to find the cmake
source files, which is `.` (a single dot) if in the same directory.

To build on Linux using plain make with CMakeLists.txt in the same directory,
you can do:

    cmake -G "Unix Makefiles" .
    make

Or rely on the fact that unix makefiles are the default there:

    cmake .
    make

To create a subdirectory for the build and run make in there:

    mkdir build
    cd build
    cmake ..
    make

