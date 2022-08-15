# Test file format

Each curl test is designed in a single text file using an XML-like
format.

Each test file is called `tests/data/testNUM` where `NUM` is a unique
numerical test identifier. Each test has to use its own dedicated number. The
number has no meaning other than identifying the test.

The test file defines exactly what command line or tool to run, what test
servers to invoke and how they should respond, exactly what protocol exchange
that should happen, what output and return code to expect and much more.

Everything is written within their dedicated tags like this when the name is
set:

    <name>
    HTTP with host name written backwards
    </name>

So far, the [test file format
specification](https://github.com/curl/curl/blob/master/tests/FILEFORMAT.md)
is only available in the git repository.

## keywords

Every test has one or more `<keywords>` set in the top of the file. They are
meant to be "tags" that identify features and protocols that are tested by
this test case. `runtests.pl` can be made to run only tests that match (or do
not match) such keywords.

## Preprocessed

Under the hood, each test input file is "preprocessed" at startup by
runtests.pl. This means that variables, macros and keywords are expanded and a
temporary version of the file is stored in `tests/log/tesyNUM` - and *that*
file is then used by all the test servers etc.

This processing allows the test format to offer features like `%repeat` to
create really big test files without bloating the input files correspondingly.
