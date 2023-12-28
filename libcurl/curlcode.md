# CURLcode return codes

Many libcurl functions return a CURLcode. That is a special libcurl typedefed
variable for error codes. It returns `CURLE_OK` (which has the value zero) if
everything is fine and dandy and it returns a non-zero number if a problem was
detected. There are almost one hundred `CURLcode` errors in use, and you can
find them all in the `curl/curl.h` header file and documented in the
libcurl-errors man page.

You can convert a CURLcode into a human readable string with the
`curl_easy_strerror()` function—but be aware that these errors are rarely
phrased in a way that is suitable for anyone to expose in a UI or to an end
user:

    const char *str = curl_easy_strerror( error );
    printf("libcurl said %s\n", str);

Another way to get a slightly better error text in case of errors is to set
the `CURLOPT_ERRORBUFFER` option to point out a buffer in your program and
then libcurl stores a related error message there before it returns an error:

    char error[CURL_ERROR_SIZE]; /* needs to be at least this big */
    CURLcode ret = curl_easy_setopt(handle, CURLOPT_ERRORBUFFER, error);

