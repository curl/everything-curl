# Compression

curl allows you to ask HTTP and HTTPS servers to provide compressed versions
of the data and then perform automatic decompression of it on arrival. In
situations where bandwidth is more limited than CPU this helps you receive
more data in a shorter amount of time.

HTTP compression can be done using two different mechanisms, one which might
be considered "The Right Way" and the other that is the way that everyone
actually uses and is the widespread and popular way to do it. The common way
to compress HTTP content is using the **Content-Encoding** header. You ask
curl to use this with the `--compressed` option:

    curl --compressed http://example.com/

With this option enabled (and if the server supports it) it delivers the data
in a compressed way and curl decompresses it before saving it or sending it to
stdout. This usually means that as a user you do not really see or experience
the compression other than possibly noticing a faster transfer.

The `--compressed` option asks for Content-Encoding compression using one of
the supported compression algorithms. There is also the rare
**Transfer-Encoding** method, which is the request header that was created for
this automated method but was never really widely adopted. You can tell curl
to ask for Transfer-Encoded compression with `--tr-encoding`:

    curl --tr-encoding http://example.com/

In theory, there is nothing that prevents you from using both in the same
command line, although in practice, you may then experience that some servers
get a little confused when ask to compress in two different ways. It is
generally safer to just pick one.

For SCP and SFTP transfers, there is `--compressed-ssh`. It compresses all
traffic in either direction.

## HTTP headers

HTTP/1.x headers cannot be compressed. HTTP/2 and HTTP/3 headers on the other
hands are always compressed and cannot be sent uncompressed. However, as a
convenience to users, curl always shows the headers uncompressed in a style
similar to how they look for HTTP/1.x to make the output and look consistent.

## Uploads

For HTTP there is no standard way to do compression. The above mentioned HTTP
compression methods only work for downloads.
