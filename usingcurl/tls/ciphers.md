# Ciphers

When curl connects to a TLS server, it negotiates how to speak the protocol
and that negotiation involves several parameters and variables that both
parties need to agree to. One of the parameters is which cryptography
algorithms to use, the so called cipher. Over time, security researchers
figure out flaws and weaknesses in existing ciphers and they are gradually
phased out over time.

Using the verbose option, `-v`, you can get information about which cipher and
TLS version are negotiated. By using the `--ciphers` option, you can change
what cipher to prefer in the negotiation, but mind you, this is a power feature
that takes knowledge to know how to use in ways that do not just make things
worse.
