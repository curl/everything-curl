# Autotools

The Autotools are a collection of different tools that are used together to
generate the `configure` script. The configure script is run by the user who
wants to build curl and it does a whole bunch of things:

 - It checks for features and functions present in your system.

 - It offers command-line options so that you as a builder can decide what to
   enable and disable in the build. Features and protocols, etc., can be
   toggled on/off, even compiler warning levels and more.

 - It offers command-line options to let the builder point to specific
   installation paths for various third-party dependencies that curl can be
   built to use.

 - It specifies on which file path the generated installation should be placed
   when ultimately the build is made and `make install` is invoked.

In the most basic usage, just running `./configure` in the source directory is
enough. When the script completes, it outputs a summary of what options it has
detected/enabled and what features that are still disabled, some of which
possibly because it failed to detect the presence of necessary third-party
dependencies that are needed for those functions to work. If the summary is
not what you expected it to be, invoke configure again with new options or
with the previously used options adjusted.

After configure has completed, you invoke `make` to build the entire thing and
then finally `make install` to install curl, libcurl and associated
things. `make install` requires that you have the correct rights in your
system to create and write files in the installation directory or you get an
error displayed.

## Cross-compiling

Cross-compiling means that you build the source on one architecture but the
output is created to be run on a different one. For example, you could build
the source on a Linux machine but have the output work on a Windows machine.

For cross-compiling to work, you need a dedicated compiler and build system
setup for the particular target system for which you want to build. How to get
and install that system is not covered in this book.

Once you have a cross compiler, you can instruct configure to use that
compiler instead of the native compiler when it builds curl so that the end
result then can be moved over and used on the other machine.

## Static linking

By default, configure setups the build files so that the following 'make'
command creates both shared and static versions of libcurl. You can change
that with the `--disable-static` or `--disable-shared` options to configure.

If you instead want to build with static versions of third party libraries
instead of shared libraries, you need to prepare yourself for an uphill
battle. curl's configure script is focused on setting up and building with
shared libraries.

One of the differences between linking with a static library compared to
linking with a shared one is in how shared libraries handle their own
dependencies while static ones do not. In order to link with library `xyz` as
a shared library, it is basically a matter of adding `-lxyz` to the linker
command line no matter which other libraries `xyz` itself was built to
use. But, if that `xyz` is instead a static library we also need to specify
each dependency of `xyz` on the linker command line. curl's configure cannot
keep up with or know all possible dependencies for all the libraries it can be
made to build with, so users wanting to build with static libs mostly need to
provide that list of libraries to link with.

## Select TLS backend

The configure-based build offers the user to select from a wide variety of
different TLS libraries when building. You select them by using the correct
command line options. Before curl 7.77.0, the configure script would
automatically check for OpenSSL, but modern versions do not.

 - AmiSSL: `--with-amissl`
 - AWS-LC: `--with-openssl`
 - BearSSL: `--with-bearssl`
 - BoringSSL: `--with-openssl`
 - GnuTLS: `--with-gnutls`
 - LibreSSL: `--with-openssl`
 - mbedTLS: `--with-mbedtls`
 - OpenSSL: `--with-openssl`
 - Rustls: `--with-rustls` (point to the rustls-ffi install path)
 - Schannel: `--with-schannel`
 - Secure Transport: `--with-secure-transport`
 - wolfSSL: `--with-wolfssl`

If you do not specify which TLS library to use, the configure script fails. If
you want to build *without* TLS support, you must explicitly ask for that with
`--without-ssl`.

These `--with-*` options also allow you to provide the install prefix so that
configure searches for the specific library where you tell it to. Like this:

    ./configure --with-gnutls=/home/user/custom-gnutls

You can opt to build with support for **multiple** TLS libraries by specifying
multiple `--with-*` options on the configure command line. Pick which one to
make the default TLS backend with `--with-default-ssl-backend=[NAME]`. For
example, build with support for both GnuTLS and OpenSSL and default to
OpenSSL:

    ./configure --with-openssl --with-gnutls \
      --with-default-ssl-backend=openssl

## Select SSH backend

The configure-based build offers the user to select from a variety of
different SSH libraries when building. You select them by using the
correct command-line options.

 - libssh2: `--with-libssh2`
 - libssh: `--with-libssh`
 - wolfSSH: `--with-wolfssh`

These `--with-*` options also allow you to provide the install prefix so that
configure searches for the specific library where you tell it to. Like this:

    ./configure --with-libssh2=/home/user/custom-libssh2

## Select HTTP/3 backend

The configure-based build offers the user to select different HTTP/3 libraries
when building. You select them by using the correct command-line options.

 - quiche: `--with-quiche`
 - ngtcp2: `--with-ngtcp2 --with-nghttp3`
 - msh3: `--with-msh3`
