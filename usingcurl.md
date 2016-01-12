# Using curl

Previous chapters have described some basic details on what curl is and
something about the basic command lines. You use command line options and you
pass on URLs to work with.

In this chapter we are going to dive deeper into a variety of different
concepts of what curl can do and how to tell curl to use these features. You
should consider all these features as different tools that are here to help
you do your file transfer tasks as convenient as possible.

## Supported protocols

curl supports or can be made to support (if built so) the following protocols.

DICT, FILE, FTP, FTPS, GOPHER, HTTP, HTTPS, IMAP, IMAPS, LDAP, LDAPS, POP3,
POP3S, RTMP, RTSP, SCP, SFTP, SMB, SMTP, SMTPS, TELNET and TFTP

## Persistent connections

When setting up TCP connections to sites, curl will keep the old connection
around for a while so that if the next transfer is to the same host it can
reuse the same connection again and thus save a lot of time. We call this
persistent connections. curl will always try to keep connections alive and
reuse existing connections as far as it can.

The curl command line tool can however only keep connections alive for as long
as it runs so as soon as it exits back to your command line, it has to close
down all currently open connections (and also free and clean up all the other
caches it uses to increase subsequent operations). We call the pool of alive
connections the "connection cache" at times.

If you want to perform N transfers or operations against the same host or same
base URL, you could gain a lot of speed by trying to do them in as few curl
command lines as possible instead of repeatedly invoking curl with one URL at
a time.
