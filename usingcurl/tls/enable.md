# Enable TLS

curl supports the TLS version of many protocols. HTTP has HTTPS, FTP has FTPS,
LDAP has LDAPS, POP3 has POP3S, IMAP has IMAPS and SMTP has SMTPS.

If the server side supports it, you can use the TLS version of these protocols
with curl.

There are two general approaches to do TLS with protocols. One of them is to
speak TLS already from the first connection handshake while the other is to
upgrade the connection from plain-text to TLS using protocol specific
instructions.

With curl, if you explicitly specify the TLS version of the protocol (the one
that has a name that ends with an 'S' character) in the URL, curl tries to
connect with TLS from start, while if you specify the non-TLS version in the
URL you can _usually_ upgrade the connection to TLS-based with the `--ssl`
option.

The support table looks like this:

| Clear  | TLS version | --ssl   |
|--------|-------------|---------|
| HTTP   | HTTPS       | no      |
| LDAP   | LDAPS       | no      |
| FTP    | FTPS        | **yes** |
| POP3   | POP3S       | **yes** |
| IMAP   | IMAPS       | **yes** |
| SMTP   | SMTPS       | **yes** |

The protocols that _can_ do `--ssl` all favor that method. Using `--ssl` means
that curl *attempts* to upgrade the connection to TLS but if that fails, it
still continues with the transfer using the plain-text version of the
protocol. To make the `--ssl` option **require** TLS to continue, there is
instead the `--ssl-reqd` option which makes the transfer fail if curl cannot
successfully negotiate TLS.

Require TLS security for your FTP transfer:

    curl --ssl-reqd ftp://ftp.example.com/file.txt

Suggest TLS to be used for your FTP transfer:

    curl --ssl ftp://ftp.example.com/file.txt

Connecting directly with TLS (to `HTTPS://`, `LDAPS://`, `FTPS://` etc) means that
TLS is mandatory and curl returns an error if TLS is not negotiated.

Get a file over HTTPS:

    curl https://www.example.com/

