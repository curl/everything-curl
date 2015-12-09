## CURL *handle

The CURL handle is what we usually call an "easy handle". You create one with
`curl_easy_init()` and it is then your handle to a transfer.

    CURL *easy = curl_easy_init();

Of course at the point in time when you have created it, it is empty and it
doesn't know what transfer it should do. You must then set a few options for
it so that it knows what to do when you ask it to perform.

Also, when you use an easy handle to actually perform a transfer it will build
up and hold "state". It means it will keep information within the handle that
libcurl can use and find. By reusing an easy handle for example, libcurl can
reuse that information again.

When you're done with the handle, like if you've done your transfers and you
don't plan to do any more with this same handle, you need to free it to remove
and clean up all related resources. You do this with `curl_easy_cleanup()`. We
encourage applications to reuse handles as much as possible for performance
and efficiency purposes.

In case of problem (like perhaps out of memory), curl_easy_init() returns NULL
and that is of course a serious error for any application. You need to write
your program to take this risk into account.

