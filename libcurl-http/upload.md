# Upload

Uploads over HTTP can be done in many different ways and it is important to
notice the differences. They can use different methods, like POST or PUT, and
when using POST the body formatting can differ.

In addition to those HTTP differences, libcurl offers different ways to
provide the data to upload.

## HTTP POST

POST is typically the HTTP method to pass data to a remote web application. A
common way to do that in browsers is by filling in an HTML form and pressing
submit. It is the standard way for an HTTP request to pass on data to the
server. With libcurl you normally provide that data as a pointer and a length:

    curl_easy_setopt(easy, CURLOPT_POSTFIELDS, dataptr);
    curl_easy_setopt(easy, CURLOPT_POSTFIELDSIZE, (long)datalength);

Or you tell libcurl that it is a post but would prefer to have libcurl instead
get the data by using the regular [read callback](../transfers/callbacks/read.md):

    curl_easy_setopt(easy, CURLOPT_POST, 1L);
    curl_easy_setopt(easy, CURLOPT_READFUNCTION, read_callback);

This "normal" POST also sets the request header `Content-Type:
application/x-www-form-urlencoded`.

## HTTP multipart formposts

A multipart formpost is still using the same HTTP method POST; the difference
is only in the formatting of the request body. A multipart formpost is a
series of separate "parts", separated by MIME-style boundary strings. There is
no limit to how many parts you can send.

Each such part has a name, a set of headers and a few other properties.

libcurl offers a set of convenience functions for constructing such a series
of parts and to send that off to the server, all prefixed with
`curl_mime`. Create a multipart post and for each part in the data you set the
name, the data and perhaps additional meta-data. A basic setup might look like
this:

    /* Create the form */
    form = curl_mime_init(curl);

    /* Fill in the file upload field */
    field = curl_mime_addpart(form);
    curl_mime_name(field, "sendfile");
    curl_mime_filedata(field, "photo.jpg");

Then you pass that post to libcurl like this:

    curl_easy_setopt(easy, CURLOPT_MIMEPOST, form);

(`curl_formadd` is the former API to build multi-part formposts with but we no
longer recommend using that)


## HTTP PUT

A PUT with libcurl assumes you pass the data to it using the read callback, as
that is the typical "file upload" pattern libcurl uses and provides. You set
the callback, you ask for PUT (by asking for `CURLOPT_UPLOAD`), you set the
size of the upload and you set the URL to the destination:

    curl_easy_setopt(easy, CURLOPT_UPLOAD, 1L);
    curl_easy_setopt(easy, CURLOPT_INFILESIZE_LARGE, (curl_off_t) size);
    curl_easy_setopt(easy, CURLOPT_READFUNCTION, read_callback);
    curl_easy_setopt(easy, CURLOPT_URL, "https://example.com/handle/put");

If you for some reason do not know the size of the upload before the transfer
starts, and you are using HTTP 1.1 you can add a `Transfer-Encoding: chunked`
header with [CURLOPT_HTTPHEADER](requests.md). For HTTP 1.0 you must provide
the size before hand and for HTTP 2 and later, neither the size nor the extra
header is needed.

## Expect: headers

When doing HTTP uploads using HTTP 1.1, libcurl inserts an `Expect:
100-continue` header in some circumstances. This header offers the server a
way to reject the transfer early and save the client from having to send a lot
of data in vain before the server gets a chance to decline.

The header is added by libcurl if HTTP uploading is done with `CURLOPT_UPLOAD`
or if it is asked to do an HTTP POST for which the body size is either unknown
or known to be larger than 1024 bytes.

A libcurl-using client can explicitly disable the use of the `Expect:` header
with the [CURLOPT_HTTPHEADER](requests.md) option.

This header is not used with HTTP/2 or HTTP/3.

## Uploads also downloads

HTTP is a protocol that can respond with contents back even when you upload
data to it - it is up to the server to decide. The response data may even
start getting sent back to the client before the upload has completed.
