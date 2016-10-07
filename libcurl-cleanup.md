## Cleanup

In previous sections we've discussed how to setup handles and how to drive the
transfers. All transfers will of course end up some point, either successfully
or with a failure.

### Multi API

When you've finished a single transfer with the multi API, you use
`curl_multi_info_read()` to identify exactly which easy handle that was
completed and you remove that easy handle from the multi handle with
`curl_multi_remove_handle()`.

If you remove the last easy handle from the multi handle so there are no more
transfers going on, you can close the multi handle like this:

    curl_multi_cleanup( multi_handle );

### easy handle

When the easy handle is done serving its purpose, you can close it. If you
intend to do another transfer you are however advised to rather reuse the
handle for the next transfer rather than to close it and create a new one.

If you don't intend to do another transfer with the easy handle, you simply
ask libcurl to cleanup:

    curl_easy_cleanup( easy_handle );
