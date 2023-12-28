# Torture

When curl is built [debug enabled](debug.md), it offers a special kind of
testing. The tests we call **torture** tests. Do not worry, it is not quite as
grim as it may sound.

They verify that libcurl and curl exit paths work without any crash or memory
leak happening,

The torture tests work like this:

 - run the single test as-is first
 - count the number of invoked *fallible* functions
 - rerun the test once for every falling function call
 - make each fallible function call return error, one by one
 - verify that there is no leak or crash
 - continue until all fallible functions have been made to fail

This way of testing can take a seriously long time. I advise you to switch off
[valgrind](valgrind.md) when trying this out.

## Rerun a specific failure

If a single test fails, `runtests.pl` identifies exactly which "round" that
triggered the problem and by using the `-t` as shown, you can run a command
line that when invoked *only* fails that particular fallible function.

## Shallow

To make this way of testing a little more practical, the test suite also
provides a `--shallow` option. This lets the user set a maximum number of
fallible functions to fail per test case. If there are more invokes to fail
than is set with this value, the script randomly selects which ones to fail.

As a special feature, as randomizing things in tests can be uncomfortable, the
script uses a random seed based on year + month, so it remains the same for
each calendar month. Convenient, as if you rerun the same test with the same
`--shallow` value it runs the same random tests.

You can force a different seed with runtests' `--seed` option.
