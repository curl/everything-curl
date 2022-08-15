# Tests

The curl test suite is a fundamental cornerstone in our development
process. It helps us verify that existing functionality is still there like
before, and we use it to check that new functionality behaves as expected.

With every bugfix and new feature, we ideally also create one or more test
cases.

The test suite is custom made and tailored specifically for our own purposes
to allow us to test curl from every possible angle that we think we need. It
does not rely on any third party test frameworks.

The tests are meant to be possible to build and run on virtually all platforms
available.

* [Test file format](tests/file-format.md)
* [Build tests](tests/build.md)
* [Run tests](tests/run.md)
* [Debug builds](tests/debug.md)
* [Test servers](tests/servers.md)
* [curl tests](tests/curl.md)
* [libcurl tests](tests/libcurl.md)
* [Unit tests](tests/unit.md)
* [Valgrind](tests/valgrind.md)
* [Continuous Integration](tests/ci.md)
* [Autobuilds](tests/autobuilds.md)
* [Torture](tests/torture.md)
