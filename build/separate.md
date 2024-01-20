# Separate install

At times when you build curl and libcurl from source, you do this with the
purpose of experimenting, testing or perhaps debugging. In these scenarios,
you might not be ready to replace your system wide libcurl installation.

Many modern systems already have libcurl installed in the system, so when you
build and install your test version, you need to make sure that your new build
is used for your purposes.

We get a lot of reports from people who build and install their own version of
curl and libcurl, but when they subsequently invoke their new curl build, the
new tool finds an older libcurl in the system and instead uses that. This
tends to confuse users.

## Static linking

You can avoid the problem of curl finding an older dynamic libcurl library by
instead linking with libcurl statically. This however instead triggers a slew
of other challenges because linking modern libraries with several third party
dependencies statically is hard work. When you link statically, you need to
make sure you provide all the dependencies to the linker. This is not a method
we recommend.

## Dynamic linking

When you invoke `curl` on a modern system, there is a runtime linker (often
called `ld.so`) that loads the shared libraries the executable was built to
use. The shared libraries are searched for and loaded from a set of paths.

The problem is often that the system libcurl library exists in that path,
while your newly built libcurl does not. Or they both exist in the path but
the system one is found first.

The runtime linker path order is typically defined in `/etc/ld.so.conf` on
Linux systems. You can change the order and you can add new directories to the
list of directories to search. Remember to run `ldconfig` after an update.

## Temporary installs

If you build a libcurl and install it somewhere and you just want to use it
for a single application or maybe just to test something out for a bit,
editing and changing the dynamic library path might be a bit too intrusive.

A normal unix offers a few other alternative takes that we recommend.

### `LD_LIBRARY_PATH`

You can set this environment variable in your shell to make the runtime
linker look in a particular directory. This affects all executables loaded
where this variable is set.

It is convenient for quick checks, or even if you want to rotate around and
have your single `curl` executable use different libcurls in different
invokes.

It can look like this when you have installed your new curl build in
`$HOME/install`:

    export LD_LIBRARY_PATH=$HOME/install/lib
    $HOME/install/bin/curl https://example.com/
    
### `rpath`

Often, a better way to forcibly load your separate libcurl instead of the
system one, is to set the `rpath` of the specific `curl` executable you
build. That gives the runtime linker a specific path to check for this
specific executable.

This is done at link time, and if you build your own libcurl using
application, you can make that load your custom libcurl build like this:

    gcc -g example.c -L$HOME/install/lib -lcurl -Wl,-rpath=$HOME/install/lib

With `rpath` set, the executable linked against `$HOME/install/lib/libcurl.so`
then makes the runtime linker use that specific path and library, while other
binaries in your system continue to use the system libcurl.

When you want to make your custom build of `curl` use its own libcurl and you
install them into `$HOME/install`, then a configure command line for this
looks something like this:

    LDFLAGS="-Wl,-rpath,$HOME/install/lib" ./configure ...

If your system supports the runpath form of rpath it is often better to use
that instead because it can be overridden by the `LD_LIBRARY_PATH` environment
variable. It may also prevent libtool bugs when testing in-tree builds of curl,
since then libtool can use `LD_LIBRARY_PATH`. Newer linkers may use the runpath
form of rpath by default when rpath is specified but others need an additional
linker flag `-Wl,--enable-new-dtags` like this:

    LDFLAGS="-Wl,-rpath,$HOME/install/lib -Wl,--enable-new-dtags" \
      ./configure ...
