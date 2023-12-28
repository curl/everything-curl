# TLS options

At the time of writing this, there are no less than **forty** different
options for curl_easy_setopt that are dedicated for controlling how libcurl
does SSL and TLS.

Transfers done using TLS use safe defaults but since curl is used in many
different scenarios and setups, chances are you end up in situations where you
want to change those behaviors.

## Protocol version

With `CURLOPT_SSLVERSION' and `CURLOPT_PROXY_SSLVERSION`you can specify which
SSL or TLS protocol range that is acceptable to you. Traditionally SSL and TLS
protocol versions have been found detect and unsuitable for use over time and
even if curl itself raises its default lower version over time you might want
to opt for only using the latest and most security protocol versions.

These options take a lowest acceptable version and optionally a maximum. If
the server cannot negotiate a connection with that condition, the transfer
fails.

Example:

    curl_easy_setopt(easy, CURLOPT_SSLVERSION, CURL_SSLVERSION_TLSv1_2);

## Protocol details and behavior

You can select what ciphers to use by setting `CURLOPT_SSL_CIPHER_LIST` and
`CURLOPT_PROXY_SSL_CIPHER_LIST`.

You can ask to enable SSL "False Start" with `CURLOPT_SSL_FALSESTART`, and
there are a few other behavior changes to tweak using `CURLOPT_SSL_OPTIONS`.

## Verification

A TLS-using client needs to verify that the server it speaks to is the correct
and trusted one. This is done by verifying that the server's certificate is
signed by a Certificate Authority (CA) for which curl has a public key for and
that the certificate contains the server's name. Failing any of these checks
cause the transfer to fail.

For development purposes and for experimenting, curl allows an application to
switch off either or both of these checks for the server or for an HTTPS
proxy.

- `CURLOPT_SSL_VERIFYPEER` controls the check that the certificate is signed
  by a trusted CA.

- `CURLOPT_SSL_VERIFYHOST` controls the check for the name within the certificate.

- `CURLOPT_PROXY_SSL_VERIFYPEER` is the proxy version of `CURLOPT_SSL_VERIFYPEER`.

- `CURLOPT_PROXY_SSL_VERIFYHOST` is the proxy version of `CURLOPT_SSL_VERIFYHOST`.

Optionally, you can tell curl to verify the certificate's public key against a
known hash using `CURLOPT_PINNEDPUBLICKEY` or `CURLOPT_PROXY_PINNEDPUBLICKEY`.
Here too, a mismatch causes the transfer to fail.

## Authentication

### TLS Client certificates

When using TLS and the server asks the client to authenticate using
certificates, you typically specify the private key and the corresponding
client certificate using `CURLOPT_SSLKEY` and `CURLOPT_SSLCERT`. The password
for the key is usually also required to be set, with `CURLOPT_SSLKEYPASSWD`.

Again, the same set of options exist separately for connections to HTTPS
proxies: `CURLOPT_PROXY_SSLKEY`, `CURLOPT_PROXY_SSLCERT` etc.

### TLS auth

TLS connections offer a (rarely used) feature called Secure Remote
Passwords. Using this, you authenticate the connection for the server using a
name and password and the options are called `CURLOPT_TLSAUTH_USERNAME` and
`CURLOPT_TLSAUTH_PASSWORD`.

## STARTTLS

For protocols that are using the STARTTLS method to upgrade the connection to
TLS (FTP, IMAP, POP3, and SMTP), you usually tell curl to use the non-TLS
version of the protocol when specifying a URL and then ask curl to enable TLS
with the `CURLOPT_USE_SSL` option.

This option allows a client to let curl continue if it cannot upgrade to TLS, but that is not a recommend path to walk as then you might be using an insecure
protocol without properly noticing.

    /* require use of SSL for this, or fail */
    curl_easy_setopt(curl, CURLOPT_USE_SSL, CURLUSESSL_ALL);
