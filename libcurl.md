# 9. libcurl basics

The engine in the curl command line tool is libcurl. libcurl is also the
engine in thousands of tools, services and applications out there today,
performing their internet data transfers.

## Transfer oriented

We have designed libcurl to be transfer oriented usually without forcing users
to be protocol experts or in fact know much at all about the networking or the
protocols involved. You setup a transfer with as many details and specific
information as you can and want, and then you tell libcurl to perform that
transfer.

That said, networking and protocols are areas with lots of pitfalls and
special cases so the more you know about these things, the more you'll be able
to understand about libcurl's options and ways of workings. Not to mention
when you're debugging and need to understand what to do next when things don't
go as you intended them.

The most basic libcurl using application can be as small as just a couple of
lines of code, but applications will of course need more code than so.

## Simple by default, more on demand

libcurl generally does the simple and basic request by default, and if you
want to add more advanced features to the request or transfer, you add that by
setting the correct options. For example, libcurl doesn't support HTTP cookies
by default but you need to tell it.

This makes libcurl behaviors easier to guess and depend on, and also it makes
it easier to maintain old behavior and add new features. Only applications
that actually ask for and use the new features will get that behavior.

## Easy handle

The fundamentals you need to learn with libcurl:

First you create an "easy handle", which is your handle to a transfer really.

    CURL *easy_handle = curl_easy_init();

Then you set various options in that handle, to control the upcoming transfer.
Like this example sets the URL:

    /* set URL to operate on */
    res = curl_easy_setopt( easy_handle, CURLOPT_URL, "http://example.com/");

Finally you fire off the actual transfer.

The actual "perform the transfer phase" can be done using different different
means and function calls, depending on what kind of behavior you want in your
application and how libcurl is best integrated into your architecture. Those
are further described later in this chapter.

After the transfer has completed, you can figure out if it succeeded or not
and you can extract stats and various information that libcurl gathered during
the transfer. (See curl_easy_getinfo description.)

While the transfer is ongoing, libcurl calls your specified functions - known
as *[callbacks](libcurl-callbacks.md])* - to deliver data, to read data or to
do a wide variety of things.

