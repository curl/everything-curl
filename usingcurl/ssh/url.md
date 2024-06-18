# URLs

SFTP and SCP URLs are similar to other URLs and you download files using these
protocols the same as with others:

    curl sftp://example.com/file.zip -u user

and:

    curl scp://example.com/file.zip -u user

SFTP (but not SCP) supports getting a file listing back when the URL ends with
a trailing slash:

    curl sftp://example.com/ -u user

Note that both these protocols work with "users" and you do not ask for a file
anonymously or with a standard generic name. Most systems require that users
authenticate, as outlined below.

When requesting a file from an SFTP or SCP URL, the file path given is
considered to be the absolute path on the remote server unless you
specifically ask for the path relative to the user's home directory. You do that by
making sure the path starts with `/~/`. This is quite the opposite to how FTP
URLs work and is a common cause for confusion among users.

For user `daniel` to transfer `todo.txt` from his home directory, it would
look similar to this:

    curl sftp://example.com/~/todo.txt -u daniel

or for SCP

    curl scp://example.com/~/todo.txt -u daniel:secret
