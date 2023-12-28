# Debug

The debug callback is set with `CURLOPT_DEBUGFUNCTION`:

    curl_easy_setopt(handle, CURLOPT_DEBUGFUNCTION, debug_callback);

The `debug_callback` function must match this prototype:

    int debug_callback(CURL *handle,
                       curl_infotype type,
                       char *data,
                       size_t size,
                       void *userdata);

This callback function replaces the default verbose output function in the
library and gets called for all debug and trace messages to aid applications
to understand what's going on. The *type* argument explains what sort of data
that is provided: header, data or SSL data and in which direction it flows.

A common use for this callback is to get a full trace of all data that libcurl
sends and receives. The data sent to this callback is always the unencrypted
version, even when, for example, HTTPS or other encrypted protocols are used.

This callback must return zero or cause the transfer to stop with an error
code.

The user pointer passed in to the callback in the *userdata* argument is set
with `CURLOPT_DEBUGDATA`:

    curl_easy_setopt(handle, CURLOPT_DEBUGDATA, custom_pointer);
