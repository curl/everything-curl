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

This feature is only supported by the OpenSSL, GnuTLS and NSS back-ends.
