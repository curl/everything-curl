# Debug builds

When we speak of *debug builds*, we usually refer to curl builds that are done
with debug code and symbols still present. We strongly recommend you do this
if you want to work with curl development as it makes it easier to test and
debug.

You make a debug build using configure like this:

    ./configure --enable-debug

Debug-builds make it possible to run individual test cases with gdb with
runtests.pl, which is handy - especially for example if you can make it crash
somewhere as then gdb can catch it and show you exactly where it happens etc.

Debug-builds are also built a little different than regular *release builds*
in that they contain some snippets of code that makes curl easier to test. For
example it allows the test suite to override the random number generator so
that testing for values that otherwise are random actually work. Also, the
unit tests only work on debug builds.

## Memdebug

Debug builds also enable the *memdebug* internal memory tracking and debugging
system.

When switched on, the memdebug system outputs detailed information about a lot
of memory-related options into a logfile, so that it can be analyzed and
verified after the fact. Verified that all memory was freed, all files were
closed and so on.

This is a poor-man's version of valgrind but does not at all compare with its
features. It is however fairly portable and low-impact.

In a debug build, the memdebug system is enabled by curl if the
`CURL_MEMDEBUG` environment variable is set to a filename, which is used for
the log. The test suite sets this variable for us (see `tests/log/memdump`)
and verifies it after each test run, if present.
