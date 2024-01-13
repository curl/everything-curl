# Certificate pinning

TLS certificate pinning is a way to verify that the public key used to sign
the servers certificate has not changed. It is *pinned*.

When negotiating a TLS or SSL connection, the server sends a certificate
indicating its identity. A public key is extracted from this certificate and
if it does not exactly match the public key provided to this option, curl
aborts the connection before sending or receiving any data.

You tell curl a filename to read the sha256 value from, or you specify the
base64 encoded hash directly in the command line with a `sha256//` prefix. You
can specify one or more hashes like that, separated with semicolons (;).

    curl --pinnedpubkey "sha256//83d34tasd3rt…" https://example.com/

This feature is not supported by all TLS backends.
