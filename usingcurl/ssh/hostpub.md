# Public key verification

The `--hostpubsha256` and `--hostpubmd5` options in curl are security features
used specifically for **SFTP** or **SCP** transfers to verify the identity of
the remote host, as an alternative to using [known_hosts](knownhosts.md).

When you connect to a server via SSH-based protocols, the server presents a
public key to identify itself. These option allow you to provide a
**fingerprint** of that public key. curl then calculates the hash of the key
received from the server and compare it against the string you provided; if
they do not match, the connection is terminated immediately.

`--hostpubmd5` is the older legacy option for this, which uses the known weak
algorithm **MD5**.

`--hostpubsha256` is the appropriate and more secure option for this purpose.
Unfortunately it does not work yet if curl is built to use the **libssh**
backend, only the **libssh2** version supports this.

## Why Use It?

The primary purpose of these flags is to prevent **Man-in-the-Middle (MITM)
attacks**. In a typical SSH environment, host verification usually relies on a
`known_hosts` file. However, in automated scripts or environments where you do
not want to maintain a persistent state or a `known_hosts` file, the
`--hostpub*` options allow you to "pin" the expected fingerprint directly
within the command. This ensures that you are communicating with the specific
server you intended, even if you have never connected to it from that
particular machine before.

## Usage

To use it, you simply pass the hash as a string:

For MD5:

    curl --hostpubmd5 "[32 hex chars]" sftp://example.com/file.txt

For SHA256:

    curl --hostpubsha256 "[base64 text]" sftp://example.com/file.txt

While effective for legacy systems or specific compatibility requirements, it
is important to note:

## Protocol

These options only work for SFTP and SCP transfers.
