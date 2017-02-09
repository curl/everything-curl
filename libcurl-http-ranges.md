## HTTP ranges

The HTTP protocol allows a client to ask for only a specific data range to get
returned. If the client only wants the first 200 bytes out of a remote
resource or why not 300 bytes somewhere in the middle? It then asks the server
for the specific range with a start offset and an end offset. It can even
combine things and ask for several ranges in the same request by just listing
up a bunch of pieces next to each other. When a server sends back multiple
independent pieces to such a reuest, you will get them separated with mime
boundary strings and it will be up to the user application to handle that
accordingly. libcurl will not split up such a response in any way.

A byte range is however only an ask to the server. It does not have to respect
the ask and in many cases, like when the server automatically genarates the
contents on the fly when it is being asked, it will simply refuse to do it and
it then insteads responds with the full contents anyway. In spite of the
request possibly asking for only a little piece out of it.

You can make libcurl ask for a range with `CURLOPT_RANGE`. Like if you want
the first 200 bytes out of something:

    curl_easy_setopt(curl, CURLOPT_RANGE, "0-199");

Or everything in the file starting from index 200:

    curl_easy_setopt(curl, CURLOPT_RANGE, "200-");

Get 200 bytes from index 0 *and* 200 bytes from index 1000:

    curl_easy_setopt(curl, CURLOPT_RANGE, "0-199,1000-199");
