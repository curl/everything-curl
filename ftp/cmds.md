# Custom FTP commands

The FTP protocol offers a wide variety of different commands that allow the
client to perform actions, other than the plain file transfers that curl is
focused on.

A curl user can pass on such extra (custom) commands to the server as a step
in the file transfer sequence. curl even offers to have those commands run at
different points in the process.

## Quote

In the old days the standard old ftp client had a command called *quote*. It
was used to send commands verbatim to the server. curl uses the same name for
virtually the same functionality: send the specified command verbatim to the
server. Actually one or more commands. `-Q` or `--quote`.

To know what commands that are available and possible to send to a server, you
need to know a little about the FTP protocol, and possibly read up a bit on
RFC 959 on the details.

To send a simple `NOOP` to the server (which does nothing) **before** the
transfer starts, provide it to curl like this:

    curl -Q NOOP ftp://example.com/file

To instead send the same command immediately **after** the transfer, prefix
the FTP command with a dash:

    curl -Q -NOOP ftp://example.com/file

curl also offers to send commands after it changes the working directory, just
**before the commands** that kick off the transfer are sent. To send command
then, prefix the command with a '+' (plus).

## A series of commands

You can in fact send commands in all three different times by using multiple
`-Q` on the command line. You can also send multiple commands in the same
position by using more `-Q` options.

By default, if any of the given commands returns an error from the server,
curl stops its operations, abort the transfer (if it happens before transfer
has started) and not send any more of the custom commands.

Example, rename a file then do a transfer:

    curl -Q "RNFR original" -Q "RNTO newname" ftp://example.com/newname

## Fallible commands

You can opt to send individual quote commands that are allowed to fail, to get
an error returned from the server without causing everything to stop.

You make the command fallible by prefixing it with an asterisk (`*`). For
example, send a delete (`DELE`) after a transfer and allow it to fail:

    curl -Q "-*DELE file" ftp://example.com/moo
