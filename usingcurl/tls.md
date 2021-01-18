# TLS

TLS stands for Transport Layer Security and is the name for the technology that
was formerly called SSL. The term SSL has not really died though so these days
both the terms TLS and SSL are often used interchangeably to describe the same
thing.

TLS is a cryptographic security layer "on top" of TCP that makes the data
tamper proof and guarantees server authenticity, based on strong public key
cryptography and digital signatures.

## Ciphers

When curl connects to a TLS server, it negotiates how to speak the protocol
and that negotiation involves several parameters and variables that both
parties need to agree to. One of the parameters is which cryptography
algorithms to use, the so called cipher. Over time, security researchers
figure out flaws and weaknesses in existing ciphers and they are gradually
phased out over time.

Using the verbose option, `-v`, you can get information about which cipher and
TLS version are negotiated. By using the `--ciphers` option, you can change
what cipher to prefer in the negotiation, but mind you, this is a power feature
that takes knowledge to know how to use in ways that do not just make things
worse.

## Enable TLS

curl supports the TLS version of many protocols. HTTP has HTTPS,
FTP has FTPS, LDAP has LDAPS, POP3 has POP3S, IMAP has IMAPS and SMTP has
SMTPS.

If the server side supports it, you can use the TLS version of these protocols
with curl.

There are two general approaches to do TLS with protocols. One of them is to
speak TLS already from the first connection handshake while the other is to
"upgrade" the connection from plain-text to TLS using protocol specific
instructions.

With curl, if you explicitly specify the TLS version of the protocol (the one
that has a name that ends with an 'S' character) in the URL, curl will try to
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
that curl will *attempt* to upgrade the connection to TLS but if that fails,
it will still continue with the transfer using the plain-text version of the
protocol. To make the `--ssl` option **require** TLS to continue, there's
instead the `--ssl-reqd` option which will make the transfer fail if curl
cannot successfully negotiate TLS.

Require TLS security for your FTP transfer:

    curl --ssl-reqd ftp://ftp.example.com/file.txt

Suggest TLS to be used for your FTP transfer:

    curl --ssl ftp://ftp.example.com/file.txt

Connecting directly with TLS (to HTTPS://, LDAPS://, FTPS:// etc) means that
TLS is mandatory and curl will return an error if TLS is not negotiated.

Get a file over HTTPS:

    curl https://www.example.com/

## SSL and TLS versions

SSL was invented in the mid 90s and has developed ever since. SSL version 2
was the first widespread version used on the Internet but that was deemed
insecure already a long time ago. SSL version 3 took over from there, and it
too has been deemed not safe enough for use.

TLS version 1.0 was the first "standard". RFC 2246 was published 1999. TLS 1.1
came out in 2006, further improving security, followed by TLS 1.2 in 2008. TLS
1.2 came to be the gold standard for TLS for a decade.

TLS 1.3 (RFC 8446) was finalized and published as a standard by the IETF in
August 2018. This is the most secure and fastest TLS version as of date. It is
however so new that a lot of software, tools and libraries do not yet support
it.

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
| --tlsv1.0 | TLS >= version 1.0 |
| --tlsv1.1 | TLS >= version 1.1 |
| --tlsv1.2 | TLS >= version 1.2 |
| --tlsv1.3 | TLS >= version 1.3 |

## Verifying server certificates

Having a secure connection to a server is not worth a lot if you cannot also
be certain that you are communicating with the **correct** host. If we do not
know that, we could just as well be talking with an impostor that just
*appears* to be who we think it is.

To check that it communicates with the right TLS server, curl uses a set of
locally stored CA certificates to verify the signature of the server's
certificate. All servers provide a certificate to the client as part of the
TLS handshake and all public TLS-using servers have acquired that certificate
from an established Certificate Authority.

After some applied crypto magic, curl knows that the server is in fact the
correct one that acquired that certificate for the host name that curl used to
connect to it. Failing to verify the server's certificate is a TLS handshake
failure and curl exits with an error.

In rare circumstances, you may decide that you still want to communicate with
a TLS server even if the certificate verification fails. You then accept the
fact that your communication may be subject to Man-In-The-Middle attacks. You
lower your guards with the `-k` or `--insecure` option.

## CA store

curl needs a "CA store", a collection of CA certificates, to verify the TLS
server it talks to.

If curl is built to use a TLS library that is "native" to your platform,
chances are that library will use the native CA store as well. If not, curl
has to either have been built to know where the local CA store is, or users
need to provide a path to the CA store when curl is invoked.

You can point out a specific CA bundle to use in the TLS handshake with the
`--cacert` command line option. That bundle needs to be in PEM format. You can
also set the environment variable `CURL_CA_BUNDLE` to the full path.

### CA store on windows

curl built on windows that is not using the native TLS library (Schannel), have
an extra sequence for how the CA store can be found and used.

curl will search for a CA cert file named "curl-ca-bundle.crt" in these
directories and in this order:

 1. application's directory
 2. current working directory
 3. Windows System directory (e.g. `C:\windows\system32`)
 4. Windows Directory (e.g. `C:\windows`)
 5. all directories along `%PATH%`

## Certificate pinning

TLS certificate pinning is a way to verify that the public key used to sign
the servers certificate has not changed. It is "pinned".

When negotiating a TLS or SSL connection, the server sends a certificate
indicating its identity. A public key is extracted from this certificate and
if it does not exactly match the public key provided to this option, curl will
abort the connection before sending or receiving any data.

You tell curl a file name to read the sha256 value from, or you specify the
base64 encoded hash directly in the command line with a `sha256//` prefix. You
can specify one or more hashes like that, separated with semicolons (;).

    curl --pinnedpubkey "sha256//83d34tasd3rt..." https://example.com/

This feature is not supported by all TLS backends.

## OCSP stapling

This uses the TLS extension called Certificate Status Request to ask the
server to provide a fresh "proof" from the CA in the handshake, that the
certificate that it returns is still valid. This is a way to make really sure
the server's certificate has not been revoked.

If the server does not support this extension, the test will fail and curl
returns an error. And it is still far too common that servers do not support
this.

Ask for the handshake to use the status request like this:

    curl --cert-status https://example.com/

This feature is only supported by the OpenSSL, GnuTLS and NSS backends.

## Client certificates

TLS client certificates are a way for clients to cryptographically prove to
servers that they are truly the right peer. A command line that uses a client
certificate specifies the certificate and the corresponding key, and they are
then passed on the TLS handshake with the server.

You need to have your client certificate already stored in a file when doing
this and you should supposedly have gotten it from the right instance via a
different channel previously.

The key is typically protected by a password that you need to provide or get
prompted for interactively.

curl offers options to let you specify a single file that is both the client
certificate and the private key concatenated using `--cert`, or you can
specify the key file independently with `--key`:

    curl --cert mycert:mypassword https://example.com
    curl --cert mycert:mypassword --key mykey https://example.com

For some TLS backends you can also pass in the key and certificate using
different types:

    curl --cert mycert:mypassword --cert-type PEM \
         --key mykey --key-type PEM https://example.com

## TLS auth

TLS connections offer a (rarely used) feature called Secure Remote
Passwords. Using this, you authenticate the connection for the server using a
name and password and the command line flags for this are `--tlsuser <name>`
and `--tlspassword <secret>`. Like this:

    curl --tlsuser daniel --tlspassword secret https://example.com

## Different TLS backends

When curl is built, it gets told to use a specific TLS library. That TLS
library is the engine that provides curl with the powers to speak TLS over the
wire. We often refer to them as different "backends" as they can be seen as
different plugglable pieces into the curl machine. curl can be built to be
able to use one or more of these backends.

Sometimes features and behaviors differ slightly when curl is built with
different TLS backends, but the developers work hard on making those
differences as small and unnoticable as possible.

Showing the curl version information with [curl
--version](usingcurl-version.md) will always include the TLS library and
version in the first line of output.

## Multiple TLS backends

When curl is built with *multiple* TLS backends, it can be told which one to use
each time it is started. It is always built to use a specific one by default
unless one is asked for.

If you invoke `curl --version` for a curl with multiple backends it will
mention `MultiSSL` as a feature in the last line. The first line will then
include all the supported TLS backends with the non-default ones within
parentheses.

To set a specific one to get used, set the environment variable
`CURL_SSL_BACKEND` to the name of it!
