# Set numerical options

Since `curl_easy_setopt()` is a vararg function where the 3rd argument can use
different types depending on the situation, normal C language type conversion
cannot be done. You **must** make sure that you truly pass a `long` and not an
`int` if the documentation tells you so. On architectures where they are the
same size, you may not get any problems but not all work like that. Similarly,
for options that accept a `curl_off_t` type, it is **crucial** that you pass
in an argument using that type and no other.

Enforce a `long`:

    curl_easy_setopt(handle, CURLOPT_TIMEOUT, 5L); /* 5 seconds timeout */

Enforce a `curl_off_t`:

    curl_off_t no_larger_than = 0x50000;
    curl_easy_setopt(handle, CURLOPT_MAXFILESIZE_LARGE, no_larger_than);
