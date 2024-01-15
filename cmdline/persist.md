# Persistent connections

When setting up connections to sites, curl keeps old connections around for a
while so that if the next transfer is done using the same host as a previous
transfer, it can reuse the same connection again and thus save a lot of
time. We call this persistent connections. curl always tries to keep
connections alive and reuses existing connections as far as it can.

Connections are kept in the *connection pool*, sometimes also called the
*connection cache*.

The curl command-line tool can, however, only keep connections alive for as
long as it runs, so as soon as it exits back to your command line it has to
close down all currently open connections (and also free and clean up all the
other caches it uses to decrease time of subsequent operations). We call the
pool of alive connections the *connection cache*.

If you want to perform N transfers or operations against the same host or same
base URL, you could gain a lot of speed by trying to do them in as few curl
command lines as possible instead of repeatedly invoking curl with one URL at
a time.
