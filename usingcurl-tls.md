# TLS

TLS stands for Transport Layer Security and is the name for the techology that
was formerly called SSL. The term SSL hasn't really died though so these days
both the terms TLS and SSL are often used interchangably to describe the same
thing.

TLS is a cryptographic security layer "on top" of TCP that makes the data
tamper proof and guarantees server authenticity, based on strong public key
cryptography and digital signatures.

## Ciphers

When curl connections to a TLS server, it negotiates how to speak the protocol
and that negotiation involves several parameters and variables that both
parties need to agree to. One of the parameters is which cryptography
algorithms to use, the so called cipher. Over time, security researchers
figure out flaws and weaknesses in existing ciphers and they are gradually
phased out over time.

Using the verbose option, `-v`, you can get information about which cipher and
TLS version are negotiated. By using the `--ciphers` option, you can change
what cipher to prefer in the negotation, but mind you, this is a power feature
that takes knowledge to know how to use in ways that don't just make things
worse.

## Enable TLS

curl supports the TLS version for a large amount of protocols. HTTP has HTTPS,
FTP has FTPS, LDAP has LDAPS, POP3 has POP3S, IMAP has IMAPS and SMTP has
SMTPS.

If the server side supports it, you cana use the TLS version of these
protocols with curl.

There are two general approaches to do TLS with protocols. One of them is to
speak TLS already from the first connection handshake while the other is to
"upgrade" the connection from plain-text to TLS using protocol specific
instructions.

With curl, if you specify the "S version" of the protocol (the one that has a
name that ends with an 'S' character) in the URL, curl will try to connect
with TLS from start while if you uses the non-S version you can _usually_
upgrade the connection to TLS-based with the `--ssl` option.

The support table looks like this:

| Scheme | S-version | --ssl   |
|--------|-----------|---------|
| HTTP   | HTTPS     | no      |
| LDAP   | LDAPS     | no      |
| FTP    | FTPS      | **yes** |
| POP3   | POP3S     | **yes** |
| IMAP   | IMAPS     | **yes** |
| SMTP   | SMTPS     | **yes** |

Those protocols that _can_ do `--ssl` all usually favors that method. `--ssl`
only means that curl will attempt to upgrade the connection to TLS but if that
fails, it will still continue with the tranfer using the plain-text version of
the protocol. To make the `--ssl` option **require** TLS to continue, there's
instead the `--ssl-reqd` option which will make the transfer fail if curl
cannot successfully negotiate TLS.

Connecting directly with TLS (to HTTPS://, LDAPS://, FTPS:// etc) means that
TLS is mandatory and curl will return an error if TLS isn't negotiated.

## SSL and TLS versions

SSL was invented in the mid 90s and has developed ever since. SSL version 2
was the first widespread version used on the Internet but that was deeemd
insecure already a very long time ago. SSL version 3 took over from there, and
it too has been deemed not safe enough for use.

TLS version 1.0 was the first "standard". RFC 2246 was published 1999. After
that, TLS 1.1 came and and in November 2016 TLS 1.2 is the gold standard. TLS
1.3 is in the works and we expect to see it finalized and published as a
standard by the IETF at some point during 2017.

curl is designed to use a "safe version" of SSL/TLS by default. It means that
it will not negotiate SSLv2 or SSLv3 unless specifically told to, and in fact
several TLS libraries no longer provide support for those protocols so in many
cases curl is not even able to speak those protocol versions unless you make a
serious effort.

| Option    | Use                |
|-----------|--------------------|
| --sslv2   | SSL version 2      |
| --sslv3   | SSL version 3      |
| --tlsv1   | TLS >= version 1.0 |
| --tlsv1.0 | TLS version 1.0    |
| --tlsv1.1 | TLS version 1.1    |
| --tlsv1.2 | TLS version 1.2    |
| --tlsv1.3 | TLS version 1.3    |

**NOTE:** TLS version 1.3 support is only supported in selected very recent
development versions of certain TLS libraries and requires curl 7.52.0 or
later.

### Verifying server certificates

TBD

### Certificate pinning

TBD

### OCSP stapling

TBD

### Client certificates

TBD

### TLS auth

TBD

### Different TLS backends

TBD
