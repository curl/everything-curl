# Drive with multi

The name 'multi' is for multiple, as in multiple parallel transfers, all done
in the same single thread. The multi API is non-blocking so it can also make
sense to use it for single transfers.

The transfer is still set in an "easy" `CURL *` handle as described
[above](../easyhandle.md), but with the multi interface you also need a
multi `CURLM *` handle created and use that to drive all the individual
transfers. The multi handle can "hold" one or many easy handles:

    CURLM *multi_handle = curl_multi_init();

A multi handle can also get certain options set, which you do with
`curl_multi_setopt()`, but in the simplest case you might not have anything to
set there.

To drive a multi interface transfer, you first need to add all the individual
easy handles that should be transferred to the multi handle. You can add them
to the multi handle at any point and you can remove them again whenever you
like. Removing an easy handle from a multi handle removes the association and
that particular transfer stops immediately.

Adding an easy handle to the multi handle is easy:

    curl_multi_add_handle( multi_handle, easy_handle );

Removing one is just as easily done:

    curl_multi_remove_handle( multi_handle, easy_handle );

Having added the easy handles representing the transfers you want to perform,
you write the transfer loop. With the multi interface, you do the looping so
you can ask libcurl for a set of file descriptors and a timeout value and do
the `select()` call yourself, or you can use the slightly simplified version
which does that for us, with `curl_multi_wait`. The simplest loop could look
like this: (*note that a real application would check return codes*)

    int transfers_running;
    do {
       curl_multi_wait ( multi_handle, NULL, 0, 1000, NULL);
       curl_multi_perform ( multi_handle, &transfers_running );
    } while (transfers_running);

The fourth argument to `curl_multi_wait`, set to 1000 in the example above, is
a timeout in milliseconds. It is the longest time the function waits for any
activity before it returns anyway. You do not want to lock up for too long
before calling `curl_multi_perform` again as there are timeouts, progress
callbacks and more that may lose precision if you do so.

To instead do select() on our own, we extract the file descriptors and timeout
value from libcurl like this (*note that a real application would check return
codes*):

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
      mc = curl_multi_fdset(multi_handle, &fdread, &fdwrite,
                            &fdexcep, &maxfd);

      if (maxfd == -1) {
        SHORT_SLEEP;
      }
      else
       select(maxfd+1, &fdread, &fdwrite, &fdexcep, &timeout);

      /* timeout or readable/writable sockets */
      curl_multi_perform(multi_handle, &transfers_running);
    } while ( transfers_running );

Both these loops let you use one or more file descriptors of your own on which
to wait, like if you read from your own sockets or a pipe or similar.

And again, you can add and remove easy handles to the multi handle at any
point during the looping. Removing a handle mid-transfer aborts that transfer.

## When is a single transfer done?

As the examples above show, a program can detect when an individual transfer
completes by seeing that the `transfers_running` variable decreases.

It can also call `curl_multi_info_read()`, which returns a pointer to a struct
(a "message") if a transfer has ended and you can then find out the result of
that transfer using that struct.

When you do multiple parallel transfers, more than one transfer can of course
complete in the same `curl_multi_perform` invocation and then you might need
more than one call to `curl_multi_info_read` to get info about each completed
transfer.
