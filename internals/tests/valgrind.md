# Valgrind

Valgrind is a popular and powerful tool for debugging programs and especially
their use and abuse of memory.

`runtests.pl` automatically detects if valgrind is installed on your system
and by default runs tests using valgrind if found. You can pass `-n` to
runtests to disable the use of valgrind.

Valgrind makes execution much slower, but it is an excellent tool to find
memory leaks and use of uninitialized memory.
