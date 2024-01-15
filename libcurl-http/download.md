# Download

The GET method is the default method libcurl uses when an HTTP URL is requested
and no particular other method is asked for. It asks the server for a
particular resource—the standard HTTP download request:

    easy = curl_easy_init();
    curl_easy_setopt(easy, CURLOPT_URL, "http://example.com/");
    curl_easy_perform(easy);

Since options set in an easy handle are sticky and remain until changed, there
may be times when you have asked for another request method than GET and then
want to switch back to GET again for a subsequent request. For this purpose,
there is the `CURLOPT_HTTPGET` option:

    curl_easy_setopt(easy, CURLOPT_HTTPGET, 1L);

## Download headers too

An HTTP transfer also includes a set of response headers. Response headers are
metadata associated with the actual payload, called the response body. All
downloads get a set of headers too, but when using libcurl you can select
whether you want to have them downloaded (seen) or not.

You can ask libcurl to pass on the headers to the same stream as the regular
body is, by using `CURLOPT_HEADER`:

    easy = curl_easy_init();
    curl_easy_setopt(easy, CURLOPT_HEADER, 1L);
    curl_easy_setopt(easy, CURLOPT_URL, "http://example.com/");
    curl_easy_perform(easy);

Or you can opt to store the headers in a separate download file, by relying on
the default behaviors of the [write](../transfers/callbacks/write.md) and
[header callbacks](../transfers/callbacks/header.md):

    easy = curl_easy_init();
    FILE *file = fopen("headers", "wb");
    curl_easy_setopt(easy, CURLOPT_HEADERDATA, file);
    curl_easy_setopt(easy, CURLOPT_URL, "http://example.com/");
    curl_easy_perform(easy);
    fclose(file);

If you only want to casually browse the headers, you may even be happy enough
with just setting verbose mode while developing as that shows both outgoing
and incoming headers sent to stderr:

    curl_easy_setopt(easy, CURLOPT_VERBOSE, 1L);
