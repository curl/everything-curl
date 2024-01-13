# Continuous Integration

For every pull request submitted to the curl project on GitHub and for every
commit pushed to the master branch in the git repository, a vast amount of
virtual machines fire up, check out that code from git, build it with
different options and run the test suite and make sure that everything is
working fine.

We run CI jobs on several different operating systems, including Linux, macOS,
Windows, Solaris and FreeBSD.

We run jobs that build and test many different (combinations of) backends.

We have jobs that use different ways of building: autotools, cmake,
winbuild, Visual Studio, etc.

We verify that the distribution tarball works.

We run source code analyzers.

## Failing builds

Unfortunately, due to the complexity of everything involved we often have one
or two CI jobs that seemingly are stuck "permafailing", that seems to be
failing the jobs on a permanent basis.

We work hard to make them not, but it is a tough job and we often see red
builds even for changes that should otherwise be all green.
