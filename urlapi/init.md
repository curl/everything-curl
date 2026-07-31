# Create

The first step when using this API is to create a `CURLU *` handle that holds
URL info and resources. The handle is a reference to an associated data object
that holds information about a single URL and all its different components.

The API allows you to set or get each URL component separately or as a full
URL.

Create a URL handle like this:

    CURLU *h = curl_url();

You can also create a new handle by [duplicating](duplicate.md) an existing
one.
