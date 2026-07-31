# Duplicate

When you need a copy of a handle, duplicate it:

    CURLU *copy = curl_url_dup(source);

This makes a new handle that holds an identical URL that the source handle
has. The URL parts set in the source URL will be set exactly the same in the
duplicate.

Both URL handles need to be [cleaned up](cleanup.md) separately.
