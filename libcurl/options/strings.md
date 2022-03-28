# Set string options

There are currently over 80 options for `curl_easy_setopt()` that accept a
string as its third argument.

When a string is set in a handle, libcurl immediately copies that data so that
the application does not have to keep the data around for the time the
transfer is being done - **with one notable exception**: `CURLOPT_POSTFIELDS`.

Set a URL in the handle:

    curl_easy_setopt(handle, CURLOPT_URL, "https://example.com");

## `CURLOPT_POSTFIELDS`

The exeception to the rule that libcurl always copies data,
`CURLOPT_POSTFIELDS` only stores the pointer to the data, meaning an
appliction using this option **must** keep the memory around for the entire
duration of the associated transfer.

If that is problematic, an alternative is to instead use
`CURLOPT_COPYPOSTFIELDS` which copies the data. If the data is binary and
doesn't stop at the first present of a null byte, make sure that
`CURLOPT_POSTFIELDSIZE` is set *before* this option is used.

## C++

If you use libcurl from a C++ program, it is important to remember that you
cannot pass in a string object where libcurl expects a string. It has to be a
null terminated C string. Usually you can make this happen with the `c_str()`
method.

For example, keep the URL in a string object and set that in the handle:

    std::string url("https://example.com/");
    curl_easy_setopt(curl, CURLOPT_URL, url.c_str());
