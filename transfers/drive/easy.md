# Drive with easy

The name 'easy' was picked simply because this is really the easy way to use
libcurl, and with easy, of course, comes a few limitations. Like, for example,
that it can only do one transfer at a time and that it does the entire transfer in
a single function call and returns once it is completed:

    res = curl_easy_perform( easy_handle );

If the server is slow, if the transfer is large or if you have some unpleasant
timeouts in the network or similar, this function call can end up taking a
long time. You can, of course, set timeouts to not allow it to spend more
than N seconds, but it could still mean a substantial amount of time depending
on the particular conditions.

If you want your application to do something else while libcurl is transferring
with the easy interface, you need to use multiple threads. If you want to do
multiple simultaneous transfers when using the easy interface, you need to perform
each of the transfers in its own thread.

