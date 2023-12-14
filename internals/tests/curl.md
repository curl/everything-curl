# curl tests

The standard test in the suite is the "curl test". They all invoke a curl
command line and verifies that everything it sends, gets back and returns are
exactly as expected. Any mismatch and the test is considered a fail and the
script shows details about the error.

What the test features in the `<client><command>` section is what is used in
the command line, verbatim.

The `tests/log/commands.log` is handy to look at after a run, as it contains
the full command line that was run in the test.

If you want to make a test that does not invoke the curl command line tool,
then you should consider the [libcurl tests](libcurl.md) or
[unit tests](unit.md) instead.
