## .netrc

Unix systems have for a long time offered a way for users to store their user
name and password for remote FTP servers. ftp clients have supported this for
decades and this way allowed users to quickly login to known servers without
manually having to reenter the credentials each time. The `.netrc` file is
typically stored in a user's home directory. (On Windows, curl will look for
it with the name `_netrc`).

This being a widespread and well used concept, curl also supports it—if you
ask it to. curl does not, however, limit this feature to FTP, but can get
credentials for machines for any protocol with this. See further below for
how.

### The .netrc file format

The .netrc file format is simple: you specify lines with a machine name and
follow that with lines for the login and password that are associated with that
machine.

**machine name**

Identifies a remote machine name.  curl searches the .netrc file for a machine
token that matches the remote machine specified in the URL. Once a match is
made, the subsequent .netrc tokens are processed, stopping when the end of
file is reached or another machine is encountered.

**login name**

The user name string for the remote machine.

**password string**

Supply a password. If this token is present, curl will supply the specified
string if the remote server requires a password as part of the login process.
Note that if this token is present in the .netrc file you really **should**
make sure the file is not readable by anyone besides the user.

An example .netrc for the host example.com with a user named 'daniel', using the
password 'qwerty' would look like:

    machine example.com
    login daniel
    password qwerty

### Enable netrc

`-n, --netrc` tells curl to look for and use the .netrc file.

`--netrc-file [file]` is similar to `--netrc`, except that you also provide
the path to the actual file to use. This is useful when you want to provide
the information in another directory or with another file name.

`--netrc-optional` is similar to `--netrc`, but this option makes the .netrc
usage optional and not mandatory as the `--netrc` option.
