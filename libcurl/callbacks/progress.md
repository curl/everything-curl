# Progress information

The progress callback is what gets called regularly and repeatedly for each
transfer during the entire lifetime of the transfer. The old callback was set
with `CURLOPT_PROGRESSFUNCTION` but the modern and preferred callback is set
with `CURLOPT_XFERINFOFUNCTION`:

    curl_easy_setopt(handle, CURLOPT_XFERINFOFUNCTION, xfer_callback);

The `xfer_callback` function must match this prototype:

    int xfer_callback(void *clientp, curl_off_t dltotal, curl_off_t dlnow,
                      curl_off_t ultotal, curl_off_t ulnow);

If this option is set and `CURLOPT_NOPROGRESS` is set to 0 (zero), this
callback function gets called by libcurl with a frequent interval. While data
is being transferred it gets called frequently, and during slow periods like
when nothing is being transferred it can slow down to about one call per
second.

The **clientp** pointer points to the private data set with
`CURLOPT_XFERINFODATA`:

    curl_easy_setopt(handle, CURLOPT_XFERINFODATA, custom_pointer);

The callback gets told how much data libcurl is about to transfer and has
transferred, in number of bytes:

 - `dltotal` is the total number of bytes libcurl expects to download in
   this transfer.
 - `dlnow` is the number of bytes downloaded so far.
 - `ultotal` is the total number of bytes libcurl expects to upload in this
   transfer.
 - `ulnow` is the number of bytes uploaded so far.

Unknown/unused argument values passed to the callback are set to zero (like if
you only download data, the upload size remains zero). Many times the callback
is called one or more times first, before it knows the data sizes, so a
program must be made to handle that.

Returning a non-zero value from this callback causes libcurl to abort the
transfer and return `CURLE_ABORTED_BY_CALLBACK`.

If you transfer data with the multi interface, this function is not called
during periods of idleness unless you call the appropriate libcurl function
that performs transfers.

(The deprecated callback `CURLOPT_PROGRESSFUNCTION` worked identically but
instead of taking arguments of type `curl_off_t`, it used `double`.)
