# Verifying server certificates

Having a secure connection to a server is not worth a lot if you cannot also
be certain that you are communicating with the **correct** host. If we do not
know that, we could just as well be talking with an impostor that just
*appears* to be who we think it is.

To check that it communicates with the right TLS server, curl uses a CA
store - a set of certificates to verify the signature of the server's
certificate. All servers provide a certificate to the client as part of the
TLS handshake and all public TLS-using servers have acquired that certificate
from an established Certificate Authority.

After some applied crypto magic, curl knows that the server is in fact the
correct one that acquired that certificate for the hostname that curl used to
connect to it. Failing to verify the server's certificate is a TLS handshake
failure and curl exits with an error.

In rare circumstances, you may decide that you still want to communicate with
a TLS server even if the certificate verification fails. You then accept the
fact that your communication may be subject to Man-In-The-Middle attacks. You
lower your guards with the `-k` or `--insecure` option.

## Native CA stores

Operating systems like Windows and macOS tend to have their own CA stores.

If you run curl with Schannel on Windows, curl uses Windows' own CA store by
default.

If you run curl with Secure Transport on macOS, curl uses macOS' own CA store
by default.

If you use curl with any other TLS backend than Schannel or Secure Transport,
it uses a CA store provided in a separate file or directory, independently of
the native CA store. However, for some of them you can still ask curl to
instead prefer the native CA store using the `--ca-native` command line
option. This option is supported with OpenSSL (and forks), wolfSSL and GnuTLS.

For HTTPS proxies, the corresponding option is called `--proxy-ca-native`.

## CA store in file(s)

If curl is not built to use a TLS library that is native to your platform
(like Schannel or Secure Transport), it has to either have been built to know
where the local CA store is, or users need to provide a path to the CA store
when curl is invoked.

You can point out a specific CA bundle to use in the TLS handshake with the
`--cacert` command line option. That bundle needs to be in PEM format. You can
also set the environment variable `CURL_CA_BUNDLE` to the full path.

## CA store on windows

curl built on windows that is not using the native TLS library (Schannel),
have an extra sequence for how the CA store can be found and used.

curl searches for a CA cert file named `curl-ca-bundle.crt` in these
directories and in this order:

 1. application's directory
 2. current working directory
 3. Windows System directory (e.g. `C:\windows\system32`)
 4. Windows Directory (e.g. `C:\windows`)
 5. all directories along `%PATH%`
