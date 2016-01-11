## Easy handle

The fundamentals you need to learn with libcurl:

First you create an "easy handle", which is your handle to a transfer really.

    CURL *easy_handle = curl_easy_init();

Then you set various options in that handle, to control the upcoming transfer.
Like this example sets the URL:

    /* set URL to operate on */
    res = curl_easy_setopt( easy_handle, CURLOPT_URL, "http://example.com/");

Creating the easy handle and setting options on it, doesn't make any transfer
happen and usually don't even make much more happen than that libcurl stores
your wish to be used later when the transfer is actually happening. Lots of
syntax checking and validation of the input may also be postponed so just
because `curl_easy_setopt` didn't complain, it doesn't mean that the input was
correct and valid. You may get an error returned later.

All options are "sticky". They remain set in the handle until you change them
again, or call `curl_easy_reset()` on the handle.

When you're done setting options to your easy handle, you can fire off the
actual transfer.

The actual "perform the transfer phase" can be done using different different
means and function calls, depending on what kind of behavior you want in your
application and how libcurl is best integrated into your architecture. Those
are further described later in this chapter.

After the transfer has completed, you can figure out if it succeeded or not
and you can extract stats and various information that libcurl gathered during
the transfer from the easy handle. (See [Post transfer
information](libcurl-getinfo.md))

While the transfer is ongoing, libcurl calls your specified functions - known
as *[callbacks](libcurl-callbacks.md])* - to deliver data, to read data or to
do a wide variety of things.

### Reuse!

Easy handles are meant and designed to be reused. When you've done a single
transfer with the easy handle, you can immediately use it again for your next
transfer. There are lots of gains to be had by this.
