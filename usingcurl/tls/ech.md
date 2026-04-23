# ECH

The `--ech` option in `curl` (added as an experimental feature in version
8.8.0) is used to enable **Encrypted Client Hello**, a TLS 1.3 extension
designed to improve privacy. In a standard TLS handshake, the domain name you
are visiting (the SNI or Server Name Indication) is sent in plaintext,
allowing network observers and Internet service providers to see exactly which
hostname you are connecting to. ECH fixes this by encrypting the hostname
using a public key retrieved from the server’s DNS records.

## Using the `--ech` Flag

The `--ech` option accepts several keywords or specific configurations to
control how strictly `curl` handles the encryption:

* **`--ech true`**: This is the "opportunistic" mode. `curl` attempts to use
  ECH if it can find the necessary configuration (usually via DNS), but if ECH
  fails or is unavailable, it falls back to a standard, unencrypted handshake.

* **`--ech hard`**: This is the "strict" mode. If you use this, `curl`
  requires a successful ECH handshake to proceed. If ECH is not supported by
  the server or the configuration cannot be found, the connection fails
  entirely.

* **`--ech grease`**: This sends a "fake" ECH extension (GREASE) to test
  server compatibility without actually encrypting the SNI. It helps ensure
  that middleboxes on the network do not break when they see ECH-related data.

* **`--ech ecl:<base64>`**: If you already have the server’s ECH configuration
  (an `ECHConfigList`), you can provide it directly as a base64-encoded string
  instead of relying on DNS discovery.

## Requirements and Dependencies

For `--ech` to work, your environment must meet specific criteria. First, ECH
is strictly a **TLS 1.3** feature. Second, because ECH requires the client to
fetch a public key from DNS before the handshake even begins, it is almost
always used in conjunction with **DNS over HTTPS (DoH)**. A typical command
might look like this:

    curl --ech hard --doh-url https://1.1.1.1/dns-query https://example.com

curl can also get the necessary public key over clear-text DNS if built
accordingly, but as the DNS traffic is then not encrypted the security
properties are weaker.

Finally, your version of `curl` must be built against a TLS library that
supports ECH, such as **OpenSSL**, **BoringSSL**, **AWS-LC**, or **wolfSSL**.
You can check if your build supports it by running `curl -V` and looking for
`ECH` in the features list. Since it is still considered an experimental
feature, you may need a custom-built version of the tool.
