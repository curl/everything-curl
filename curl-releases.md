## Releases

A release in the curl project means packaging up all the source code that is
in the master branch of the code repository, signing the package, tagging the
point in the code repository, and then putting it up on the web site for the
world to download.

It is one single source code archive for all platforms curl can run on. It is
the one and only package for both curl and libcurl.

We never ship any curl or libcurl _binaries_ from the project with one
exception: we host official curl binaries built for Windows users. All the
othrt packaged binaries that are provided with operating systems or on other
download sites are done by gracious volunteers outside of the project.

As of a few years back, we make an effort to do our releases on an eight week
cycle and unless some really serious and urgent problem shows up we stick to
this schedule. We release on a Wednesday, and then again a Wednesday eight
weeks later and so it continues. Non-stop.

For every release we tag the source code in the repository with "curl-release
version" and we update the [changelog](https://curl.haxx.se/changes.html).

We had done 182 curl releases by June 2019, and for all the ones made
since late 1999 there are lots of release stats available in our [curl release
log](https://curl.haxx.se/docs/releases.html).

## Daily snapshots

Every single change to the source code is committed and pushed to the source
code repository. This repository is hosted on github.com and is using git
these days (but has not always been this way). When building curl off the
repository, there are a few things you need to generate and setup that
sometimes cause people some problems or just friction. To help with that, we
provide daily snapshots.

The daily snapshots are generated daily (clever naming, right?) as if a
release had been made at that point. It produces a package of all sources code
and all files that are normally part of a release and puts it in a package and
uploads it to a special place
([https://curl.haxx.se/snapshots/](https://curl.haxx.se/snapshots/)) to allow
interested people to get the latest code to test, to experiment or
whatever.

The snapshots are only kept for around 20 days until deleted.

