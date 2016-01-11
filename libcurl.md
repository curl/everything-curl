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

## Basic design

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

### "Drive" transfers

libcurl provides three different ways to perform the transfer. Which way to
use in your case is entirely up to you and what you need.

1. The 'easy' interface lets you do a single transfer in a synchronous
fashion. Then libcurl will do the entire transfer and return control back to
your application when it is completed - successfully or failed.

2. The 'multi' interface is for when you want to do more than one transfer at
the same time, or you just want an non-blocking transfer mechanism.

3. The 'multi_socket' interface is a slight variation of the regular multi
one, but is event-based and is really the suggested API to use if you intend
to scale up the number of simultaneous transfers in the hundreds or thousands
or so.

Let's look at each one a little closer...

#### Driving with the "easy" interface

The name 'easy' was picked simply because this is really the easy way to use
libcurl, and with easy of course comes a few limitations. Like for example
that it can only do one transfer at a time and it does the entire transfer in
a single function call and returns once it is completed:

    res = curl_easy_perform( easy_handle );

If the server is slow, if the transfer is large or if you have some unpleasant
timeouts in the network or similar, this function call can end up taking a
very long time. You can of course set timeouts to not allow it to spend more
than N seconds, but it could still mean a substantial amount of time depending
on the particular conditions.

If you want your application to do something else while libcurl is transferring
with the easy interface, you need to use multiple threads. If you want to do
multiple simultaneous transfers when using the easy interface, you need to do
each of the transfers in their own threads.

#### Driving with the "multi" interface

The name 'multi' is for multiple, as in multiple parallel transfers - all done
in the same single thread. The multi API is non-blocking so it can also make
sense to use it for single transfers.

The transfer is still set in an "easy" `CURL *` handle has described above,
but with the multi interface you also need a multi `CURLM *` handle created
and use that to drive all the individual transfers with:

    CURLM *multi_handle = curl_multi_init();

A multi handle can also get certain options set in it, which you do with
`curl_multi_setopt()` but in the simplest case you might not have anything to
set there.

To drive a multi interface transfer, you first need to add all the individual
easy handles to the multi handle that should be transfered. You can add them
to the multi handle at any point and you can remove them again whenever you
like.  Removing an easy handle from a multi handle will of course remove the
association and that particular transfer would stop immediately.

Adding an easy handle to the multi handle is very easy:

    curl_multi_add_handle( multi_handle, easy_handle );

Removing one is just as easily done:

    curl_multi_remove_handle( multi_handle, easy_handle );

Having added the easy handles representing the transfers you want to perform,
you write the transfer loop. With the multi interface, you do the looping so
you can ask libcurl for a set of file descriptors and a timeout value and do
the `select()` call yourself, or you can use the slightly simplified version
which does that for us, with `curl_multi_wait`. The simplest loop would
basically be this: (*note that a real application would check return codes*)

    int transfers_running;
    do {
       curl_multi_wait ( multi_handle, NULL, 0, 1000, NULL);
       curl_multi_perform ( multi_handle, &transfers_running );
    } while (transfers_running);

The forth argument to `curl_multi_wait`, set to 1000 in the example above, is
a timeout in milliseconds. It is the longest time the function will wait for
any activity before it returns anyway. You don't want to lock up for too long
before calling `curl_multi_perform` again as there are timeouts, progress
callbacks and more that may loose precision if you do so.

To instead do select() on our own, we extract the file descriptors and timeout
value from libcurl like this (*note that a real application would check return
codes*) :

    int transfers_running;
    do {
      fd_set fdread;
      fd_set fdwrite;
      fd_set fdexcep;
      int maxfd = -1;
      long timeout;

      /* extract timeout value */
      curl_multi_timeout(multi_handle, &timeout);
      if (timeout < 0)
        timeout = 1000;

      /* convert to struct usable by select */
      timeout.tv_sec = timeout / 1000;
      timeout.tv_usec = (timeout % 1000) * 1000;

      FD_ZERO(&fdread);
      FD_ZERO(&fdwrite);
      FD_ZERO(&fdexcep);

      /* get file descriptors from the transfers */
      mc = curl_multi_fdset(multi_handle, &fdread, &fdwrite, &fdexcep, &maxfd);

      if (maxfd == -1) {
        SHORT_SLEEP;
      }
      else
       select(maxfd+1, &fdread, &fdwrite, &fdexcep, &timeout);

      /* timeout or readable/writable sockets */
      curl_multi_perform(multi_handle, &transfers_running);
    } while ( transfers_running );

Both these loops let you use one or more file descriptors of your own to wait
for, like if you read from your own sockets or a pipe or similar.

And again, you can add and remove easy handles to the multi handle at any
point during the looping. Removing a handle mid-transfer will of course abort
that transfer.

#### Driving with the "multi_socket" interface

TBD

