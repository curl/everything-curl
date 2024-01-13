# Header data

The header callback is set with `CURLOPT_HEADERFUNCTION`:

    curl_easy_setopt(handle, CURLOPT_HEADERFUNCTION, header_callback);

The `header_callback` function must match this prototype:

    size_t header_callback(char *ptr, size_t size, size_t nmemb,
                           void *userdata);

This callback function gets called by libcurl as soon as a header has been
received. *ptr* points to the delivered data, and the size of that data is
*size* multiplied with *nmemb*. libcurl buffers headers and delivers only
"full" headers, one by one, to this callback.

The data passed to this function is not be zero terminated. You cannot, for
example, use printf's `%s` operator to display the contents nor strcpy to copy
it.

This callback should return the number of bytes actually taken care of. If
that number differs from the number passed to your callback function, it
signals an error condition to the library. This causes the transfer to abort
and the libcurl function used returns `CURLE_WRITE_ERROR`.

The user pointer passed in to the callback in the *userdata* argument is set
with `CURLOPT_HEADERDATA`:

    curl_easy_setopt(handle, CURLOPT_HEADERDATA, custom_pointer);
