# Handling build options

The curl and libcurl source code has been carefully written to build and run
on virtually every computer platform in existence. This can only be done
through hard work and by adhering to a few guidelines (and, of course, a fair
amount of testing).

A golden rule is to always add #ifdefs that checks for specific features, and
then have the setup scripts (configure or CMake or hard-coded) check for the
presence of said features in a user's computer setup before the program is
compiled there. Additionally and as a bonus, thanks to this way of writing the
code, some features can be explicitly turned off even if they are present in
the system and *could* be used. Examples of that would be when users want to,
for example, build a version of the library with a smaller footprint or with
support for certain protocols disabled, etc.

The project sometimes uses #ifdef protection around entire source files when,
for example, a single file is provided for a specific operating system or
perhaps for a specific feature that is not always present. This is to make it
possible for all platforms to always build all files—it simplifies the build
scripts and makefiles a lot. A file entirely #ifdefed out hardly adds anything
to the build time, anyway.

Rather than sprinkling the code with #ifdefs, to the extent where it is
possible, we provide functions and macros that make the code look and work the
same, independent of present features. Some of those are then empty macros for
the builds that lack the features.

Both TLS handling and name resolving are handled with an internal API that
hides the specific implementation and choice of 3rd party software
library. That way, most of the internals work the same independent of which
TLS library or name resolving system libcurl is told to use.

