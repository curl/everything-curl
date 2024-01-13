# Read data

The read callback is set with `CURLOPT_READFUNCTION`:

    curl_easy_setopt(handle, CURLOPT_READFUNCTION, read_callback);

The `read_callback` function must match this prototype:

    size_t read_callback(char *buffer, size_t size, size_t nitems,
                         void *stream);

This callback function gets called by libcurl when it wants to send data to
the server. This is a transfer that you have set up to upload data or
otherwise send it off to the server. This callback is called over and over
until all data has been delivered or the transfer failed.

The **stream** pointer points to the private data set with `CURLOPT_READDATA`:

    curl_easy_setopt(handle, CURLOPT_READDATA, custom_pointer);

If this callback is not set, libcurl instead uses 'fread' by default.

The data area pointed at by the pointer **buffer** should be filled up with at
most **size** multiplied with **nitems** number of bytes by your function. The
callback should then return the number of bytes that it stored in that memory
area, or 0 if we have reached the end of the data. The callback can also
return a few "magic" return codes to cause libcurl to return failure
immediately or to pause the particular transfer. See the [CURLOPT_READFUNCTION
man page](https://curl.se/libcurl/c/CURLOPT_READFUNCTION.html) for
details.

