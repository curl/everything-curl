# HSTS

HTTP Strict Transport Security, HSTS, is a protocol mechanism that helps to
protect HTTPS servers against man-in-the-middle attacks such as protocol
downgrade attacks and cookie hijacking. It allows an HTTPS server to declare
that clients should automatically interact with this hostname using only
HTTPS connections going forward - and explicitly not use clear text protocols
with it.

## HSTS cache

The HSTS status for a certain server name is set in a response header and has
an expire time. The status for every HSTS hostname needs to be saved
in a file for curl to pick it up and to update the status and expire time.

Invoke curl and tell it which file to use as a hsts cache:

    curl --hsts hsts.txt https://example.com

curl only updates the hsts info if the header is read over a secure transfer,
so not when done over a clear text protocol.

## Use HSTS to update insecure protocols

If the cache file now contains an entry for the given hostname, it
automatically switches over to a secure protocol even if you try to connect to
it with an insecure one:

    curl --hsts hsts.txt http://example.com
