# .netrc

Unix systems have for a long time offered a way for users to store their user
name and password for remote FTP servers. ftp clients have supported this for
decades and this way allowed users to quickly login to known servers without
manually having to reenter the credentials each time. The `.netrc` file is
typically stored in a user's home directory. (On Windows, curl looks for it
with the name `_netrc`).

This being a widespread and well used concept, curl also supports it—if you ask it to. curl does not, however, limit this feature to FTP, but can get credentials for machines for any protocol with this. See further below for how.

## The .netrc file format

The .netrc file format is simple: you specify lines with a machine name and follow that with the login and password that are associated with that machine.

Each field is provided as a sequence of letters that ends with a space or
newline. Since 7.84.0, curl also supports quoted strings. They start and end
with double quotes (`"`) and support the escaped special letters `\"`,
(newline), (carriage return), and (TAB). Quoted strings are the only way a
space character can be used in a username or password.

**machine name**

Identifies a remote machine name. curl searches the .netrc file for a machine token that matches the remote machine specified in the URL. Once a match is made, the subsequent .netrc tokens are processed, stopping when the end of file is reached or another machine is encountered.

**default**

This is the same as machine name except that `default` matches any name. There can be only one default token, and it must be after all machine tokens. To provide a default anonymous login for hosts that are not otherwise matched, add a line similar to this in the end:

    default login anonymous password user@domain

**login name**

The username string for the remote machine. You cannot use a space in the
name.

**password string**

Supply a password. If this token is present, curl supplies the specified
string if the remote server requires a password as part of the login
process. Note that if this token is present in the .netrc file you really
**should** make sure the file is not readable by anyone besides the user. You
cannot use a space when you enter the password.

**macdef name**

Define a macro. This is **not supported by curl**. In order for the rest of
the `.netrc` to still work fine, curl properly skips every definition done
with `macdef` that it finds.

An example .netrc for the host example.com with a user named 'daniel', using
the password 'qwerty' would look like:

    machine example.com
    login daniel
    password qwerty

It can also be written on a single line with the same functionality:

    machine example.com login daniel password qwerty

## Username matching

When a URL is provided with a username and .netrc is used, then curl tries to
find the matching password for that machine and login combination.

## Enable netrc

`-n, --netrc` tells curl to look for and use the .netrc file.

`--netrc-file [file]` is similar to `--netrc`, except that you also provide
the path to the actual file to use. This is useful when you want to provide
the information in another directory or with another filename.

`--netrc-optional` is similar to `--netrc`, but this option makes the .netrc usage optional and not mandatory as the `--netrc` option.
