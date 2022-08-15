# Unit tests

**Unit tests only work on [debug builds](debug.md).**

Unit tests are tests that use functions that are libcurl internal and
therefore not part of any public API, headers or external documentation.

If the internal function you want to test is made `static`, they should
instead be set `UNITTEST` - which then makes debug builds not use static for
them and they then become accessible to test from unit tests.

We provide a set of convenience functions and macros for unit tests to make it
quick and easy to write them.

All unit test programs are kept in `tests/unit`
