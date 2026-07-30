# Known hosts

A secure network client needs to make sure that the remote host is exactly the
host that it thinks it is communicating with. With TLS based protocols, it is
done by the client verifying the server's certificate.

With SSH protocols there are no server certificates, but instead each server
can provide its unique key. Unlike TLS, SSH has no certificate authorities or
anything so the client has to make sure that the host's key matches what it
already knows (via other means) it should look like.

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

## Custom known hosts file

By default, curl attempts to find and read the standard `known_hosts` file in
the user's SSH directory (such as `~/.ssh/known_hosts` on Linux and macOS).

If you store host keys in a different location, or if you want to use a
specific known hosts file for a particular script or project, you can pass the
file path to curl using the `--knownhosts` option:

    curl --knownhosts /path/to/my_known_hosts sftp://example.com/file.txt

When you provide `--knownhosts`, curl reads host keys exclusively from the
specified file. The file must follow the standard OpenSSH `known_hosts`
format.

This option is particularly useful in automated environments, containerized
setups, or isolated build pipelines where a global SSH configuration directory
is absent or when you need strict host verification without modifying your
personal SSH configuration. If the remote host key does not match an entry in
the specified file, curl refuses the connection to ensure security.
