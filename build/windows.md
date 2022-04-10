# On Windows

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
that directly details them all, but an example command line could look like
this (split into several lines for readability):

    nmake WITH_SSL=dll WITH_NGHTTP2=dll ENABLE_IPV6=yes \
    WITH_ZLIB=dll MACHINE=x64 

## Visual C++ project files

curl tarballs ship with pre-generated project files that you can load and
build curl with.

Project files are provided for several different Visual C++ versions.

To build with VC++, you will of course have to first install VC++ which is
part of Visual Studio.

Once you have VC++ installed you should launch the application and open one of
the solution or workspace files. The VC directory names are based on the
version of Visual C++ that you will be using. Each version of Visual Studio
has a default version of Visual C++. We offer these versions:

 - VC10      (Visual Studio 2010 Version 10.0)
 - VC11      (Visual Studio 2012 Version 11.0)
 - VC12      (Visual Studio 2013 Version 12.0)
 - VC14      (Visual Studio 2015 Version 14.0)
 - VC14.10   (Visual Studio 2017 Version 15.0)
 - VC14.30   (Visual Studio 2022 Version 17.0)

Separate solutions are provided for both libcurl and the curl command line
tool as well as a solution that includes both projects. libcurl.sln, curl.sln
and curl-all.sln, respectively. We recommend using curl-all.sln to build both
projects.

For example, if you are using Visual Studio 2022 then you should be able to
use `VC14.30\curl-all.sln` to build curl and libcurl.

## Running DLL based configurations

If you are a developer and plan to run the curl tool from Visual Studio (eg
you are debugging) with any third-party libraries (such as OpenSSL, wolfSSL or
libSSH2) then you will need to add the search path of these DLLs to the
configuration's PATH environment. To do that:

 1. Open the 'curl-all.sln' or 'curl.sln' solutions
 2. Right-click on the 'curl' project and select Properties
 3. Navigate to 'Configuration Properties > Debugging > Environment'
 4. Add `PATH='Path to DLL';C:\Windows\system32;C:\Windows;C:\Windows\System32\Wbem`

... where 'Path to DLL` is the configuration specific path. For example the
following configurations in Visual Studio 2010 might be:

DLL Debug - DLL OpenSSL (Win32):

    PATH=..\..\..\..\..\openssl\build\Win32\VC10\DLL Debug;C:\Windows\system32;
    C:\Windows;C:\Windows\System32\Wbem

DLL Debug - DLL OpenSSL (x64):

    PATH=..\..\..\..\..\openssl\build\Win64\VC10\DLL Debug;C:\Windows\system32;
    C:\Windows;C:\Windows\System32\Wbem

DLL Debug - DLL wolfSSL (Win32):

    PATH=..\..\..\..\..\wolfssl\build\Win32\VC10\DLL Debug;C:\Windows\system32;
    C:\Windows;C:\Windows\System32\Wbem

DLL Debug - DLL wolfSSL (x64):

    PATH=..\..\..\..\..\wolfssl\build\Win64\VC10\DLL Debug;C:\Windows\system32;
    C:\Windows;C:\Windows\System32\Wbem

If you are using a configuration that uses multiple third-party library DLLs
(such as `DLL Debug - DLL OpenSSL - DLL LibSSH2`) then `Path to DLL` will need
to contain the path to both of these.

## Notes

The following keywords have been used in the directory hierarchy:

 - `<platform>`      - The platform (For example: Windows)
 - `<ide>`           - The IDE (For example: VC10)
 - `<architecture>`  - The platform architecture (For example: Win32, Win64)
 - `<configuration>` - The target configuration (For example: DLL Debug, LIB
   Release - LIB OpenSSL)

If you are using the source code from the git repository, rather than a
release archive or nightly build, you will need to generate the project
files. Please run "generate -help" for usage details.

Should you wish to help out with some of the items on the TODO list, or find
bugs in the project files that need correcting, and would like to submit
updated files back then please note that, whilst the solution files can be
edited directly, the templates for the project files (which are stored in the
git repository) will need to be modified rather than the generated project
files that Visual Studio uses.
