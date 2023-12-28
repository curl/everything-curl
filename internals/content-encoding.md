# Content Encoding

## About content encodings

 [HTTP/1.1][4] specifies that a client may request that a server encode its
 response. This is usually used to compress a response using one (or more)
 encodings from a set of commonly available compression techniques. These
 schemes include `deflate` (the zlib algorithm), `gzip`, `br` (brotli) and
 `compress`. A client requests that the server perform an encoding by
 including an `Accept-Encoding` header in the request document. The value of
 the header should be one of the recognized tokens `deflate`, ... (there is a
 way to register new schemes/tokens, see sec 3.5 of the spec). A server MAY
 honor the client's encoding request. When a response is encoded, the server
 includes a `Content-Encoding` header in the response. The value of the
 `Content-Encoding` header indicates which encodings were used to encode the
 data, in the order in which they were applied.

 It is also possible for a client to attach priorities to different schemes so
 that the server knows which it prefers. See sec 14.3 of RFC 2616 for more
 information on the `Accept-Encoding` header. See sec [3.1.2.2 of RFC
 7231](https://datatracker.ietf.org/doc/html/rfc7231#section-3.1.2.2) for more
 information on the `Content-Encoding` header.

## Supported content encodings

 The `deflate`, `gzip`, `zstd` and `br` content encodings are supported by
 libcurl. Both regular and chunked transfers work fine. The zlib library is
 required for the `deflate` and `gzip` encodings, the brotli decoding library
 is for the `br` encoding and not too surprisingly libzstd does `zstd`.

## The libcurl interface

 To cause libcurl to request a content encoding use:

  [`curl_easy_setopt`][1](curl, [`CURLOPT_ACCEPT_ENCODING`][5], string)

 where string is the intended value of the `Accept-Encoding` header.

 Currently, libcurl does support multiple encodings but only understands how
 to process responses that use the `deflate`, `gzip`, `zstd` and/or `br`
 content encodings, so the only values for [`CURLOPT_ACCEPT_ENCODING`][5] that
 work (besides `identity`, which does nothing) are `deflate`, `gzip`, `zstd`
 and `br`. If a response is encoded using the `compress` or methods, libcurl
 returns an error indicating that the response could not be decoded. If
 `<string>` is NULL no `Accept-Encoding` header is generated. If `<string>` is
 a zero-length string, then an `Accept-Encoding` header containing all
 supported encodings is generated.

 The [`CURLOPT_ACCEPT_ENCODING`][5] must be set to any non-NULL value for
 content to be automatically decoded. If it is not set and the server still
 sends encoded content (despite not having been asked), the data is returned
 in its raw form and the `Content-Encoding` type is not checked.

## The curl interface

 Use the [`--compressed`][6] option with curl to cause it to ask servers to
 compress responses using any format supported by curl.
