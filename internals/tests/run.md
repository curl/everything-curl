# Run tests

The main script that runs tests is called `tests/runtests.pl` and some of its
more useful features are:

## Run a range of tests

Run test 1 to 27:

    ./runtests.pl 1 to 27

Run all tests marked as `SFTP`:

    ./runtests.pl SFTP

Run all tests **not** marked `FTP`:

    ./runtests.pl '!FTP'

## Run a specific test with gdb

    ./runtests.pl -g 144

It starts up gdb, you can set break-points etc and then type `run` and off it
goes and performs the entire thing through the debugger.

## Run a specific test without valgrind

The test suite uses valgrind by default if it finds it, which is an excellent
way to find problems but it also makes the test run much slower. Sometimes you
want to do it faster:

    ./runtests.pl -n 144
