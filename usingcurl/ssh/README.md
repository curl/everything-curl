# SCP and SFTP

curl supports the SCP and SFTP protocols if built with a prerequisite 3rd
party library: [libssh2](https://www.libssh2.org/),
[libssh](https://www.libssh.org/) or
[wolfSSH](https://www.wolfssl.com/products/wolfssh/).

SCP and SFTP are both protocols that are built on top of SSH, a secure and
encrypted data protocol that is similar to TLS but differs in a few important
ways. For example, SSH does not use certificates of any sort but instead it
uses public and private keys. Both SSH and TLS provide strong crypto and
secure transfers when used correctly.

The SCP protocol is generally considered to be the black sheep of the two
since it is not portable and usually only works between Unix systems.

 * [URL](url.md)
 * [Authentication](auth.md)
 * [Known hosts](knownhosts.md)
