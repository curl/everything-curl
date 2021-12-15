# Verifying server certificates

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
