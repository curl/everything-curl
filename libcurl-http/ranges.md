# Ranges

What if the client only wants the first 200 bytes out of a remote resource or
perhaps 300 bytes somewhere in the middle? The HTTP protocol allows a client
to ask for only a specific data range. The client asks the server for the
specific range with a start offset and an end offset. It can even combine
things and ask for several ranges in the same request by just listing a bunch
of pieces next to each other. When a server sends back multiple independent
pieces to answer such a request, you get them separated with mime boundary
strings and it is up to the user application to handle that accordingly. curl
does not further separate such a response.

However, a byte range is only a request to the server. It does not have to
respect the request and in many cases, like when the server automatically
generates the contents on the fly when it is being asked, it simply refuses to
do it and it then instead respond with the full contents anyway.

You can make libcurl ask for a range with `CURLOPT_RANGE`. Like if you want
the first 200 bytes out of something:

    curl_easy_setopt(curl, CURLOPT_RANGE, "0-199");

Or everything in the file starting from index 200:

    curl_easy_setopt(curl, CURLOPT_RANGE, "200-");

Get 200 bytes from index 0 *and* 200 bytes from index 1000:

    curl_easy_setopt(curl, CURLOPT_RANGE, "0-199,1000-199");
