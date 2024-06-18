# Known hosts

A secure network client needs to make sure that the remote host is exactly the
host that it thinks it is communicating with. With TLS based protocols, it is
done by the client verifying the server's certificate.

With SSH protocols there are no server certificates, but instead each server
can provide its unique key. Unlike TLS, SSH has no certificate authorities or
anything so the client simply has to make sure that the host's key matches
what it already knows (via other means) it should look like.

The matching of keys is typically done using hashes of the key and the file
that the client stores the hashes for known servers is often called
`known_hosts` and is put in a dedicated SSH directory. On Linux systems that
is usually called `~/.ssh`.

When curl connects to a SFTP and SCP host, it makes sure that the host's key
hash is already present in the known hosts file or it denies continued
operation because it cannot trust that the server is the right one. Once the
correct hash exists in `known_hosts` curl can perform transfers.

To force curl to skip checking and obeying to the `known_hosts` file, you can
use the `-k / --insecure` command-line option. You must use this option with
extreme care since it makes it possible for man-in-the-middle attacks not to
be detected.
