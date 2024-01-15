# Create, cleanup, duplicate

The first step when using this API is to create a `CURLU *` handle that holds
URL info and resources. The handle is a reference to an associated data object
that holds information about a single URL and all its different components.

The API allows you to set or get each URL component separately or as a full
URL.

Create a URL handle like this:

    CURLU *h = curl_url();

When you are done with it, clean it up:

    curl_url_cleanup(h);

When you need a copy of a handle, just duplicate it:

    CURLU *nh = curl_url_dup(h);
