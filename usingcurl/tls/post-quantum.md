# Post-quantum

Using post-quantum cryptography (PQC) with curl is primarily handled through
the underlying TLS library rather than with a dedicated flag. Because most PQC
implementations currently use **hybrid key exchanges** - which combine a
classical algorithm like X25519 with a quantum-resistant one like ML-KEM - you
can enable them explicitly by specifying the desired *group* or *curve*.

As long as the TLS library curl is built to use and the server you instruct
curl to speak to, both are PQC-ready and compatible, they can negotiate and
agree to a post-quantum-resistant algorithm without any extra options or
actions being needed.

## `--curves`

The most direct way to force a post-quantum handshake in curl is using the
`--curves` option. Modern versions of curl linked against PQC-ready libraries
recognize hybrid identifiers. For example, to request a connection using the
NIST-standardized ML-KEM (formerly Kyber) hybrid, you would run:

    curl -v --curves X25519MLKEM768 https://example.com

In the verbose output, you should see a line confirming the key exchange
algorithm:

    * SSL connection using TLSv1.3 / ... / X25519MLKEM768

## Debugging

Since PQC algorithms (like **ML-DSA** for signatures and **ML-KEM** for key
encapsulation) have much larger keys and signatures than classical RSA or ECC,
you might notice a slight increase in handshake latency. If a connection
fails, it is often due to "jumbo" TLS packets being blocked by older
middleboxes or firewalls that are not yet PQC-aware. Using `curl -v` is your
friend to see if the handshake hangs after the "Client Hello" is sent with the
larger PQC extension etc.
