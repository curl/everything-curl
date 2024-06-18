# Authentication

Authentication with curl against an SSH server (when you specify an SCP or
SFTP URL) is done like this:

1. curl connects to the server and learns which authentication methods that
   this server offers
2. curl then tries the offered methods one by one until one works or they all
   failed

curl attempts to use your public key as found in the `.ssh` subdirectory in
your home directory if the server offers public key authentication. When doing
so, you still need to tell curl which username to use on the server. For
example, the user 'john' lists the entries in his home directory on the remote
SFTP server called 'sftp.example.com':

    curl -u john: sftp://sftp.example.com/

If curl cannot authenticate with the public key for any reason, it instead
attempts to use the username + password if the server allows it and the
credentials are passed on the command line.

For example, the same user from above has the password `RHvxC6wUA` on a remote
system and can download a file via SCP like this:

    curl -u john:RHvxC6wUA -O scp://ssh.example.com/file.tar.gz
