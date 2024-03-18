# Easy handle

The fundamentals you need to learn with libcurl:

First you create an "easy handle", which is your handle to a transfer, really:

    CURL *easy_handle = curl_easy_init();

You then set options in that handle to control the upcoming transfer.
This example sets the URL:

    /* set URL to operate on */
    res = curl_easy_setopt(easy_handle, CURLOPT_URL, "http://example.com/");

If `curl_easy_setopt()` returns `CURLE_OK`, we know it stored the option fine.

Creating the easy handle and setting options on it does not make any transfer
happen, and usually do not even make much more happen other than libcurl
storing your wish to be used later when the transfer actually occurs. Lots of
syntax checking and validation of the input may also be postponed, so just
because `curl_easy_setopt` did not complain, it does not mean that the input
was correct and valid; you may get an error returned later.

Read more on [easy options](options/) in its separate section.

When you are done setting options to your easy handle, you can fire off the
actual transfer.

The actual performing of the transfer can be done using different methods and
function calls, depending on what kind of behavior you want in your
application and how libcurl is best integrated into your architecture. Those
are further described later in this chapter.

While the transfer is ongoing, libcurl calls your specified functions—known as
*[callbacks](callbacks/)* — to deliver data, to read data and to do a
variety of things.

After the transfer has completed, you can figure out if it succeeded or not
and you can extract statistics and other information that libcurl gathered
during the transfer from the easy handle. See [Post transfer information](getinfo.md).

## Reuse

Easy handles are meant and designed to be reused. When you have done a single
transfer with the easy handle, you can immediately use it again for your next
transfer. There are lots of gains to be had by this.

All options are "sticky". If you make a second transfer with the same handle,
the same options are used. They remain set in the handle until you change them
again, or call `curl_easy_reset()` on the handle.

## Reset

By calling `curl_easy_reset()`, all options for the given easy handle are
reset and restored to their default values. The same values the options had
when the handle was initially created. The caches remain intact.

## Duplicate

An easy handle, with all its currently set options, can be duplicated using
`curl_easy_duphandle()`. It returns a copy of the handle passed in to it.

The caches and other state information are not carried over.
