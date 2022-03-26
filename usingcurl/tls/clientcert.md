# Client certificates

TLS client certificates are a way for clients to cryptographically prove to
servers that they are truly the right peer (also sometimes known as Mutual TLS
or mTLS). A command line that uses a client certificate specifies the
certificate and the corresponding key, and they are then passed on the TLS
handshake with the server.

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

