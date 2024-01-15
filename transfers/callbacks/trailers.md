# Sending trailers

"Trailers" is an HTTP/1 feature where headers can be passed on *at the end of
a transfer*. This callback is used for when you want to send trailers with
curl after an upload has been performed. An upload in the form of a chunked
encoded POST.

The callback set with `CURLOPT_TRAILERFUNCTION` is called and the function can
then append headers to a list. One or many. When done, libcurl sends off those
as trailers to the server.
