# RTSP interleaved data

The callback with the `CURLOPT_INTERLEAVEFUNCTION` option.

This callback gets called by libcurl as soon as it has received interleaved
RTP data when doing an RTSP transfer. It gets called for each `$` block and
therefore contains exactly one upper-layer protocol unit (e.g. one RTP
packet). libcurl writes the interleaved header as well as the included data
for each call. The first byte is always an ASCII dollar sign. The dollar sign
is followed by a one byte channel identifier and then a 2 byte integer length
in network byte order. See RFC2326 Section 10.12 for more information on how
RTP interleaving behaves. If unset or set to NULL, curl uses the default write
function.

The `CURLOPT_INTERLEAVEDATA` pointer is passed in the userdata argument in the
callback.
