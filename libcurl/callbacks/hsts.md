# HSTS

For HSTS, HTTP Strict Transport Security, libcurl provides two callbacks to
allow an allocation to implement the storage for rules. The callbacks are then
set to read and/or write the HSTS policies from a persistent storage.

With `CURLOPT_HSTSREADFUNCTION`, the application provides a function using
which HSTS data into libcurl is read. `CURLOPT_HSTSWRITEFUNCTION` is the
corresponding function that libcurl calls to write data.
