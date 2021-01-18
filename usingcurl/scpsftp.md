## SCP and SFTP

curl supports the SCP and SFTP protocols if built with the correct
prerequisite 3rd party library, [libssh2](https://www.libssh2.org/).

SCP and SFTP are both protocols that are built on top of SSH, a secure and
encrypted data protocol that is similar to TLS but differs in a few important
ways. For example, SSH does not use certificates of any sort but instead it
uses public and private keys. Both SSH and TLS provide strong crypto and
secure transfers when used correctly.

The SCP protocol is generally considered to be the black sheep of the two
since it is not portable and usually only works between Unix systems.

### URLs

SFTP and SCP URLs are similar to other URLs and you download files using these
protocols the same as with others:

    curl sftp://example.com/file.zip -u user

and:

    curl scp://example.com/file.zip -u user

SFTP (but not SCP) supports getting a file listing back when the URL ends with
a trailing slash:

    curl sftp://example.com/ -u user

Note that both these protocols work with "users" and you do not ask for a file
anonymously or with a standard generic name. Most systems will require that
users authenticate, as outlined below.

When requesting a file from an SFTP or SCP URL, the file path given is
considered to be the absolute path on the remote server unless you
specifically ask for the path relative to the user's home directory. You do that by
making sure the path starts with `/~/`. This is quite the opposite to how FTP
URLs work and is a common cause for confusion among users.

For user `daniel` to transfer `todo.txt` from his home directory, it would
look similar to this:

    curl sftp://example.com/~/todo.txt -u daniel

### Auth

TBD

### Known hosts

A secure network client needs to make sure that the remote host is exactly the
host that it thinks it is communicating with. With TLS based protocols, it is
done by the client verifying the server's certificate.

With SSH protocols there are no server certificates, but instead each server
can provide its unique key. And unlike TLS, SSH has no certificate authorities
or anything so the client simply has to make sure that the host's key matches
what it already knows (via other means) it should look like.

The matching of keys is typically done using hashes of the key and the file
that the client stores the hashes for known servers is often called
`known_hosts` and is put in a dedicated SSH directory. On Linux systems that
is usually called `~/.ssh`.

When curl connects to a SFTP and SCP host, it will make sure that the host's
key hash is already present in the known hosts file or it will deny continued
operation because it cannot trust that the server is the right one. Once the
correct hash exists in `known_hosts` curl can perform transfers.

To force curl to skip checking and obeying to the `known_hosts` file, you can
use the `-k / --insecure` command-line option. You must use this option with
extreme care since it makes it possible for man-in-the-middle attacks not to
be detected.
