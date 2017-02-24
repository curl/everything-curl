# Build curl with boringssl

## build boringssl

$HOME/src is where I put the code in this example. You can pick wherever you
like.

    $ cd $HOME/src
    $ git clone https://boringssl.googlesource.com/boringssl
    $ cd boringssl
    $ mkdir build
    $ cd build
    $ cmake ..
    $ make

## set up the build tree to get detected by curl's configure

In the boringssl source tree root, make sure there's a `lib` and an `include`
dir. The `lib` dir should contain the two libs (I make them symlinks into the
build dir). The `include` dir is already present by default. Make and populate
`lib` like this (commands issued in the source tree root, not in the `build/`
subdirectory).


    $ mkdir lib
    $ cd lib
    $ ln -s ../build/ssl/libssl.a
    $ ln -s ../build/crypoto/libcrypto.a


## configure curl

`LIBS=-lpthread ./configure --with-ssl=$HOME/src/boringssl` (where I point out
the root of the boringssl tree)

verify that at the end of the configure run, it should say it detected
BoringSSL to be used

## build curl

run `make` in the curl source tree

Now you can install curl normally with `make install` etc.
