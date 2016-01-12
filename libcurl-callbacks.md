## Callbacks

Lots of operations within libcurl are controlled with the use of *callbacks*.
A callback is a function pointer provided to libcurl that libcurl then calls
at some point in time to get a particular job done.

Each callback has its specific documented purpose and it requires that you
write it with the exact function prototype to accept the correct arguments and
return the documented return code and return value so that libcurl will
perform the way you want it to.

Each callback option also has a companion option that sets the associated
"user pointer". This user pointer is a pointer that libcurl doesn't touch or
care about, but just passes on as an argument to the callback. This allows you
to for example pass in pointers to local data all the way through to your
callback function.

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

### Read callback

The read callback is set with CURLOPT_READFUNCTION:

    curl_easy_setopt(handle, CURLOPT_READFUNCTION, read_callback);

The `read_callback` function must match this prototype:

    size_t read_callback(char *buffer, size_t size, size_t nitems, void *stream);

This callback function gets called by libcurl when it wants to send data to
the server. This is a transfer that you've set up to upload data or otherwise
send it off to the server. This callback will be called over and over until
all data has been delivered or the transfer failed.

The **stream** pointer points to the private data set with `CURLOPT_READDATA`.

If this callback isn't set, libcurl instead uses 'fread' by default.

The data area pointed at by the pointer **buffer** should be filled up with at
most **size** multiplied with **nitems** number of bytes by your function. The
callback should then return the number of bytes that it stored in that memory
area, or 0 if we've reached the end of the data. The callback can also return
a few "magic" return codes to cause libcurl to return failure immediately or
to pause the particular transfer. See the [CURLOPT_READFUNCTION man
page](http://curl.haxx.se/libcurl/c/CURLOPT_READFUNCTION.html) for details.

### Progress callbacks

TBD

### Header callback

TBD

### Debug callback

TBD

### SSL context callback

TBD

### ioctl and seek callbacks

TBD

### Convert to and from network callbacks

TBD

### Convert from UTF8 callback

TBD

### Sockopt callback

TBD

### Opensocket and closesocket callbacks

TBD

### SSH key callback

TBD

### RTSP interleave callback

TBD

### FTP chunk callbacks

TBD

### FTP matching callback

TBD

