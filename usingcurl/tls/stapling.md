# OCSP stapling

This uses the TLS extension called Certificate Status Request to ask the
server to provide a fresh "proof" from the CA in the handshake, that the
certificate that it returns is still valid. This is a way to make really sure
the server's certificate has not been revoked.

If the server does not support this extension, the test fails and curl returns
an error. It is still common that servers do not support this.

Ask for the handshake to use the status request like this:

    curl --cert-status https://example.com/

This feature is only supported by the OpenSSL and GnuTLS backends.
