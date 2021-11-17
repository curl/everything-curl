# FTPS

FTPS is FTP secure by TLS. It negotiates fully secured TLS connections where
plain FTP uses clear text unsafe connections.

There are two ways to do FTPS with curl. The *implicit* way and the *explicit*
way. (These terms orignate from the FTPS RFC). Usually the server you work
with dictates which of these methods you can and shall use against it.

## Implicit FTPS

The *implicit* way is when you use `ftps://` in your URL. This makes curl
connect to the host and do a TLS handshake immediately, without doing anything
in the clear. If no port number is specified in the URL, curl will use port
990 for this. This is usually not how FTPS is done.

## Explicit FTPS

The *explicit* way of doing FTPS is to keep using an `ftp://` URL, but
instruct curl to upgrade the connection into a secure one using the `STARTTLS`
FTP command.

You can tell curl to either *attempt* an upgrade and continue as usual if the
upgrade fails with `--ssl`, or you can force curl to either upgrdae or fail
the whole thing hard if the upgrade fails by using `--ssl-reqd`. We strongly
recommand using the latter, so that you can be sure that a secure transfer is
done - if any.

## Common FTPS problems

TBD
