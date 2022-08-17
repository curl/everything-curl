# libcurl tests

A libcurl test is a stand-alone C program that uses the public libcurl API to
do something.

Apart from that, everything else is tested, verified and checked the same way
[curl tests](curl.md) are.

Since these C programs are usually built and run on a plethora of different
platforms, considerations might need to be taken.

All libcurl test programs are kept in `tests/libtest`
