## libcurl HTTP download

The GET method is the default method libcurl uses when a HTTP URL is requested
and no particular other method is asked for. It asks the server for a
particular resource. The standard HTTP download request.

    easy = curl_easy_init();
    curl_easy_setopt(easy, CURLOPT_URL, "http://example.com/");
    curl_easy_perform(easy);

Since options set in an easy handle are sticky and remain until changed, there
may be times when you've asked for another request method than GET and then
want to switch back to GET again in a subsequent request. For this purpose,
there's the CURLOPT_HTTPGET option:

    curl_easy_setopt(easy, CURLOPT_HTTPGET, 1L);

### Download headers too

TBD
