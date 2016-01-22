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

