# Duplicate

When you need a copy of a handle, duplicate it:

    CURLU *copy = curl_url_dup(h);

This makes a new handle that holds an identical URL to the source handle.
duplicate.

Both URL handles need to be [cleaned up](cleanup.md) separately.
