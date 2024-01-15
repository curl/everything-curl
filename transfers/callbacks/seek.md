# Seek and ioctl

This callback is set with `CURLOPT_SEEKFUNCTION`.

The callback gets called by libcurl to seek to a certain position in the input
stream and can be used to fast forward a file in a resumed upload (instead of
reading all uploaded bytes with the normal read function/callback). It is also
called to rewind a stream when data has already been sent to the server and
needs to be sent again. This may happen when doing an HTTP PUT or POST with a
multi-pass authentication method, or when an existing HTTP connection is
reused too late and the server closes the connection. The function shall work
like fseek(3) or lseek(3) and it gets `SEEK_SET`, `SEEK_CUR` or `SEEK_END` as
argument for origin, although libcurl currently only passes `SEEK_SET`.

The custom `userp` sent to the callback is the pointer you set with
`CURLOPT_SEEKDATA`.

The callback function must return `CURL_SEEKFUNC_OK` on success,
`CURL_SEEKFUNC_FAIL` to cause the upload operation to fail or
`CURL_SEEKFUNC_CANTSEEK` to indicate that while the seek failed, libcurl is
free to work around the problem if possible. The latter can sometimes be done
by instead reading from the input or similar.

If you forward the input arguments directly to fseek(3) or lseek(3), note that
the data type for offset is not the same as defined for `curl_off_t` on many
systems.
