# Cleanup

When you are done working with the URL handle, clean it up. This frees all
resources associated with this URL.

    curl_url_cleanup(h);

All created URL handles must be freed with a call to this function, including
handles created with `curl_url_dup()`.

The URL handle that is cleaned up this way may then no longer be used as it
is gone.
