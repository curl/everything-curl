## Releases

A release in the curl project means packaging up all the source code that is
in the master branch of the code repository, signing the package, tagging the
point in time in the code repo, and then putting it up on the web site for the
world to download.

It is one single source code archive for all platforms curl can run on. It is
the one and only package for both curl and libcurl.

We never ship any curl or libcurl _binaries_ from the project. All the
packaged binaries that are provided with operating systems or on other
download sites are done by gracious volunteers outside of the project.

As of a few years back, we make an effort to do our releases on an eight week
cycle and unless some really serious and urgent problem shows up we stick to
this schedule. On a Wednesday, and then again a Wednesday eight weeks later
and so it continues. Non-stop.

For every release we tag the source code in the repository with "curl-release
version" and we update the [changelog](http://daniel.haxx.se/changes.html).

## Daily snapshots

Every single change to the source code is committed and pushed to the source
code repository. This repository is hosted on github.com and is using git
these days (but hasn't always been this way). When building curl off the
repository, there are a few things you need to generate and setup that
sometimes cause people some problems or just friction. To help with that, we
provide daily snapshots.

The daily snapshots are generated daily (clever naming, right?) as if a
release had been made at that point in time. It produces a package of all
sources code and all files that are normally part of a release and puts it in
a package and uploads it to a special place
([http://curl.haxx.se/snapshots/](http://curl.haxx.se/snapshots/)) to allow
interested people to get the very latest code. To test, to experiment and
whatever.

The snapshots are only kept for around 20 days until deleted.

