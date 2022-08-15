# Build tests

Before you can run any tests you need to build curl but also build the test
suite and its associated tools and servers.

Most conveniently, you can just build and run them all by issuing `make test`
in the build directory root but if you want to work more on tests or perhaps
even debug one, you may want to jump into the `tests` directory and work from
within that. Build it all and run test `144` like this:

    cd tests
    make
    ./runtests.pl 144
