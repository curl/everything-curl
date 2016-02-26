### Write callback

The write callback is set with CURLOPT_WRITEFUNCTION:

    curl_easy_setopt(handle, CURLOPT_WRITEFUNCTION, write_callback);

The `write_callback` function must match this prototype:

    size_t write_callback(char *ptr, size_t size, size_t nmemb, void *userdata);

This callback function gets called by libcurl as soon as there is data
received that needs to be saved. *ptr* points to the delivered data, and the
size of that data is *size* multiplied with *nmemb*.

If this callback isn't set, libcurl instead uses 'fwrite' by default.

The write callback will be passed as much data as possible in all invokes, but
you must not make any assumptions. It may be one byte, it may be thousands.
The maximum amount of body data that will be passed to the write callback is
defined in the curl.h header file: `CURL_MAX_WRITE_SIZE` (the usual default is
16K). If `CURLOPT_HEADER` is enabled for this transfer, which makes header
data get passed to the write callback, you can get up to
`CURL_MAX_HTTP_HEADER` bytes of header data passed into it. This usually means
100K.

This function may be called with zero bytes data if the transferred file is empty.

The data passed to this function will not be zero terminated! You cannot for
example use printf's "%s" operator to display the contents nor strcpy to copy
it.

This callback should return the number of bytes actually taken care of. If
that amount differs from the amount passed to your callback function, it'll
signal an error condition to the library. This will cause the transfer to get
aborted and the libcurl function used will return `CURLE_WRITE_ERROR`.

The user pointer passed in to the callback in the *userdata* argument is set
with CURLOPT_WRITEDATA:

    curl_easy_setopt(handle, CURLOPT_WRITEDATA, custom_pointer);
