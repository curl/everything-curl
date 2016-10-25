## HTTP Upload

Uploads over HTTP can be done in many different ways and it is important to
notice the differences. They can use different methods, like POST or PUT, and
when using POST the body formatting can differ.

In addition to those HTTP differences, libcurl offers different ways to
provide the data to upload.

### HTTP POST

POST is typically the HTTP method to pass data to a remote web application. A
very common way to do that in browsers is by filling in a HTML form and pressing
submit. It is the standard way for a HTTP request to pass on data to the
server. With libcurl you normally provide that data as a pointer and a length:

    curl_easy_setopt(easy, CURLOPT_POSTFIELDS, dataptr);
    curl_easy_setopt(easy, CURLOPT_POSTFIELDSIZE, (long)datalength);

Or you tell libcurl that it is a post but would prefer to have libcurl instead
get the data by using the regular [read callback](callback-read.md):

    curl_easy_setopt(easy, CURLOPT_POST, 1L);
    curl_easy_setopt(easy, CURLOPT_READFUNCTION, read_callback);

This "normal" POST will also set the request header `Content-Type:
application/x-www-form-urlencoded`.

### HTTP multipart formposts

A multipart formpost is still using the same HTTP method POST; the difference
is only in the formatting of the request body. A multipart formpost is
basically a series of separate "parts", separated by MIME-style boundary
strings. There's no limit to how many parts you can send.

Each such part has a name, a set of headers and a few other properties.

libcurl offers a convenience function for constructing such a series of parts
and to send that off to the server. `curl_formadd` is the function to build a
formpost. Invoke it once for each part, and pass in arguments to it
detailing the specifics and characteristics of that part. When all parts you
want to send have been added, you pass in the handle `curl_formadd` returned
like this:

    curl_easy_setopt(easy, CURLOPT_HTTPPOST, formposthandle);

### HTTP PUT

TBD

