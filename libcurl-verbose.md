## Verbose operations

Okay, we just showed how to get the error as a human readable text as that is
an excellent help to figure out what went wrong in a particular transfer and
often explains why it can be done like that or what the problem is for the
moment.

The next life safer when writing libcurl applications that everyone needs to
know about and needs to use extensively, at least while developing libcurl
applications or debugging libcurl itself, is to enable "verbose mode" with
`CURLOPT_URL`:

    CURLcode ret = curl_easy_setopt(handle, CURLOPT_VERBOSE, 1L);

When libcurl is told to be verbose it will mention transfer related details
and information to stderr while the transfer is ongoing. This is awesome to
figure out why things fail and to learn exactly what libcurl does when you ask
it different things. You can redirect the output elsewhere by changing stderr
with `CURLOPT_STDERR` or you can get even more info in a fancier way with the
debug callback (explained further in a later section).

