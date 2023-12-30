# Multiplexing

The HTTP versions 2 and 3 offer "multiplexing". Using this protocol feature,
an HTTP client can do several concurrent transfers to a server *over the same
single connection*. This feature does not exist in earlier versions of the
HTTP protocol. In earlier HTTP versions, the client would either have to
create multiple connections or do the transfers in a serial manner, one after
the other.

libcurl supports HTTP multiplexing for both HTTP/2 and HTTP/3.

Make sure you do multiple transfers using the multi interface to a server that
supports HTTP multiplexing. libcurl can only multiplex transfers when the same
hostname is used for subsequent transfers.

For all practical purposes and API behaviors, an application does not have
to care about if multiplexing is done or not.

libcurl enables multiplexing by default, but if you start multiple transfers
at the same time they prioritize short-term speed so they might then open new
connections rather than waiting for a connection to get created by another
transfer to be able to multiplex over. To tell libcurl to prioritize
multiplexing, set the `CURLOPT_PIPEWAIT` option for the transfer with
`curl_easy_setopt()`.

With `curl_multi_setopt()`'s option `CURLMOPT_PIPELINING`, you can disable
multiplexing for a specific multi handle.
