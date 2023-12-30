# multi-threading

libcurl is thread safe but has no internal thread synchronization. You may have
to provide your own locking or change options to properly use libcurl threaded.
Exactly what is required depends on how libcurl was built. Please refer to the
[libcurl thread safety](https://curl.se/libcurl/c/threadsafe.html)
webpage, which contains the latest information.
