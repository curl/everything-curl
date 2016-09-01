### sockopt callback

The sockopt callback is set with CURLOPT_SOCKOPTFUNCTION:

    curl_easy_setopt(handle, CURLOPT_SOCKOPTFUNCTION, sockopt_callback);

The `sockopt_callback` function must match this prototype:

    int sockopt_callback(void *clientp,
                         curl_socket_t curlfd,
                         curlsocktype purpose);

This callback function gets called by libcurl when it when a new socket has
been created, but before the connect call to allow applications to change
specific socket options.

The **clientp** pointer points to the private data set with
`CURLOPT_SOCKOPTDATA`:

    curl_easy_setopt(handle, CURLOPT_SOCKOPTDATA, custom_pointer);

