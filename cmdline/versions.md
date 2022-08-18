# Options depend on version

`curl` was first typed on a command line back in the glorious year of 1998. It
already then worked on the specified URL and none, one or more command-line
options given to it.

Since then we have added more options. We add options as we go along and
almost every new release of curl has one or a few new options that allow users
to modify certain aspects of its operation.

With the curl project's rather speedy release chain with a new release
shipping every eight weeks, it is almost inevitable that you are at least not
always using the latest released version of curl. Sometimes you may even use a
curl version that is a few years old.

All command-line options described in this book were, of course, added to curl
at some point and only a small portion of them were available that fine spring
day in 1998 when curl first shipped. You may have reason to check your version
of curl and crosscheck with the curl man page for when certain options were
added. This is especially important if you want to take a curl command line
using a modern curl version back to an older system that might be running an
older installation.

The developers of curl are working hard to not change existing behavior.
Command lines written to use curl in 1998, 2003 or 2010 should all be possible
to run unmodified even today.
