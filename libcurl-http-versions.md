# HTTP versions

As any other Internet protocol, the HTTP protocol has kept evolving over the
years and now there are clients and servers distributed over the world and
over time that speak different versions with varying levels of success. So in
order to get libcurl to work with the URLs you pass in libcurl offers ways for
you to specify which HTTP version that request and transfer should
use. libcurl is designed in a way so that it tries to use the most common, the
most sensible if you want, default values first but sometimes that isn't
enough and then you may need to instruct libcurl what to do.

Since perhaps mid 2016, libcurl will default to use HTTP/1.1 for HTTP
servers. If you connect to HTTPS and you have a libcurl that has HTTP/2
abilities built-in, libcurl will attempt to use HTTP/2 automatically or fall
down to 1.1 in case the negotiation failed. Non-HTTP/2 capable libcurls get
1.1 over HTTPS by default.

If the default isn't good enough for your transfer, the `CURLOPT_HTTP_VERSION`
option is there for you.

| Option                              | Description |
|-------------------------------------|-------------|
| CURL_HTTP_VERSION_NONE              | fill in
| CURL_HTTP_VERSION_1_0               | fill in
| CURL_HTTP_VERSION_1_1               | fill in
| CURL_HTTP_VERSION_2_0               | fill in
| CURL_HTTP_VERSION_2TLS              | fill in
| CURL_HTTP_VERSION_2_PRIOR_KNOWLEDGE | fill in
