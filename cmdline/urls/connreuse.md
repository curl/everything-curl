# Connection reuse

Setting up a TCP connection and especially a TLS connection can be a slow
process, even on high bandwidth networks.

It can be useful to remember that curl has a connection pool internally which
keeps previously used connections alive and around for a while after they were
used so that subsequent requests to the same hosts can reuse an already
established connection.

Of course, they can only be kept alive for as long as the curl tool is
running. It is a good reason for trying to get several transfers done
within the same command line instead of running several independent curl
command line invocations.
