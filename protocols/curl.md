# curl protocols

curl supports about 28 protocols. We say *about* because it depends on how you
count and what you consider to be distinctly different protocols.

## DICT

DICT is a dictionary network protocol, it allows clients to ask dictionary
servers about a meaning or explanation for words. See RFC 2229. Dict servers
and clients use TCP port 2628.

## FILE

FILE is not actually a *network* protocol. It is a URL scheme that allows you
to tell curl to get a file from the local file system instead of getting it
over the network from a remote server. See RFC 1738.

## FTP

FTP stands for File Transfer Protocol and is an old (originates in the early
1970s) way to transfer files back and forth between a client and a server. See
RFC 959. It has been extended greatly over the years. FTP servers and clients
use TCP port 21 plus one more port, though the second one is usually
dynamically established during communication.

See the external page [FTP vs
HTTP](https://daniel.haxx.se/docs/ftp-vs-http.html) for how it differs from
HTTP.

## FTPS

FTPS stands for Secure File Transfer Protocol. It follows the tradition of
appending an 'S' to the protocol name to signify that the protocol is done
like normal FTP but with an added SSL/TLS security layer. See RFC 4217.

This protocol is problematic to use through firewalls and other network
equipment.

## GOPHER

Designed for "distributing, searching, and retrieving documents over the
Internet", Gopher is somewhat of the grandfather to HTTP as HTTP has mostly
taken over completely for the same use cases. See RFC 1436. Gopher servers and
clients use TCP port 70.

## GOPHERS

Gopher over TLS. A recent extension to the old protocol.

## HTTP

The Hypertext Transfer Protocol, HTTP, is the most widely used protocol for
transferring data on the web and over the Internet. See RFC 9110 for general
HTTP Semantics, RFC 9112 for HTTP/1.1, RFC 9113 for
[HTTP/2](../http/versions/http2.md) and RFC 9114 for HTTP/3. HTTP servers and
clients use TCP port 80.

## HTTPS

Secure HTTP is HTTP done over an SSL/TLS connection. See RFC 2818. HTTPS
servers and clients use TCP port 443, unless they speak
[HTTP/3](../http/versions/http3.md) which then uses QUIC (RFC 8999) and is
done over UDP.

## IMAP

The Internet Message Access Protocol, IMAP, is a protocol for accessing,
controlling and "reading" email. See RFC 3501. IMAP servers and clients use
TCP port 143. Whilst connections to the server start out as cleartext, SSL/TLS
communication may be supported by the client explicitly requesting to upgrade
the connection using the `STARTTLS` command. See RFC 2595.

## IMAPS

Secure IMAP is IMAP done over an SSL/TLS connection. Such connections
implicitly start out using SSL/TLS and as such servers and clients use TCP
port 993 to communicate with each other. See RFC 8314.

## LDAP

The Lightweight Directory Access Protocol, LDAP, is a protocol for accessing
and maintaining distributed directory information. Basically a database
lookup. See RFC 4511. LDAP servers and clients use TCP port 389.

## LDAPS

Secure LDAP is LDAP done over an SSL/TLS connection.

## MQTT

Message Queuing Telemetry Transport, MQTT, is a protocol commonly used in IoT
systems for interchanging data mostly involving smaller devices. It is a
so-called "publish-subscribe" protocol.

## POP3

The Post Office Protocol version 3 (POP3) is a protocol for retrieving email
from a server. See RFC 1939. POP3 servers and clients use TCP port 110. Whilst
connections to the server start out as cleartext, SSL/TLS communication may be
supported by the client explicitly requesting to upgrade the connection using
the `STLS` command. See RFC 2595.

## POP3S

Secure POP3 is POP3 done over an SSL/TLS connection. Such connections
implicitly start out using SSL/TLS and as such servers and clients use TCP
port 995 to communicate with each other. See RFC 8314.

## RTMP

The Real-Time Messaging Protocol (RTMP) is a protocol for streaming audio,
video and data. RTMP servers and clients use TCP port 1935.

## RTSP

The Real Time Streaming Protocol (RTSP) is a network control protocol to
control streaming media servers. See RFC 2326. RTSP servers and clients use
TCP and UDP port 554.

## SCP

The Secure Copy (SCP) protocol is designed to copy files to and from a remote
SSH server. SCP servers and clients use TCP port 22.

## SFTP

The SSH File Transfer Protocol (SFTP) that provides file access, file
transfer, and file management over a reliable data stream. SFTP servers and
clients use TCP port 22.

## SMB

The Server Message Block (SMB) protocol is also known as CIFS. It is an
application-layer network protocol mainly used for providing shared access to
files, printers, and serial ports and miscellaneous communications between
nodes on a network. SMB servers and clients use TCP port 445.

## SMBS

SMB done over TLS.

## SMTP

The Simple Mail Transfer Protocol (SMTP) is a protocol for email
transmission. See RFC 5321. SMTP servers and clients use TCP port 25. Whilst
connections to the server start out as cleartext, SSL/TLS communication may be
supported by the client explicitly requesting to upgrade the connection using
the `STARTTLS` command. See RFC 3207.

## SMTPS

Secure SMTP, is SMTP done over an SSL/TLS connection. Such connections
implicitly start out using SSL/TLS and as such servers and clients use TCP
port 465 to communicate with each other. See RFC 8314.

## TELNET

TELNET is an application layer protocol used over networks to provide a
bidirectional interactive text-oriented communication facility using a virtual
terminal connection. See RFC 854. TELNET servers and clients use TCP port 23.

## TFTP

The Trivial File Transfer Protocol (TFTP) is a protocol for doing simple file
transfers over UDP to get a file from or put a file onto a remote host. TFTP
servers and clients use UDP port 69.

## WS

WebSocket is a bidirectional TCP-like protocol, setup over an HTTP(S)
request. WS is the scheme for the clear text version done over plain HTTP.
Experimental support for this was added to curl 7.86.0.

## WSS

WebSocket is a bidirectional TCP-like protocol, setup over an HTTP(S)
request. WSS is the scheme for the secure version done over HTTPS.
Experimental support for this was added to curl 7.86.0.
