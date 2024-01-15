# Command line FTP

FTP, the File Transfer Protocol, is probably the oldest network protocol that
curl supports—it was created in the early 1970s. The official spec that
still is the go-to documentation is [RFC 959](https://www.ietf.org/rfc/rfc959.txt),
from 1985, published well over a decade before the first curl release.

FTP was created in a different era of the Internet and computers and as such
it works a little bit differently than most other protocols. These differences
can often be ignored and things just works, but they are also important to
know at times when things do not run as planned.

## Ping-pong

The FTP protocol is a command and response protocol; the client sends a
command and the server responds. If you use curl's `-v` option you get to see
all the commands and responses during a transfer.

For an ordinary transfer, there are something like 5 to 8 commands necessary
to send and as many responses to wait for and read. Perhaps needlessly to say,
if the server is in a remote location there is a lot of time waiting for the
ping pong to go through before the actual file transfer can be set up and get
started. For small files, the initial commands can take longer time than the
actual data transfer.

## Transfer mode

When an FTP client is about to transfer data, it specifies to the server which
transfer mode it would like the upcoming transfer to use. The two transfer
modes curl supports are 'ASCII' and 'BINARY'. Ascii is for text and usually
means that the server sends the files with converted newlines while binary
means sending the data unaltered and assuming the file is not text.

curl defaults to binary transfer mode for FTP, and you ask for ascii mode
instead with `-B, --use-ascii` or by making sure the URL ends with `;type=A`.

## Authentication

FTP is one of the protocols you normally do not access without a user name and
password. It just happens that for systems that allow anonymous FTP access you
can login with pretty much any name and password you like. When curl is used
on an FTP URL to do transfer without any given user name or password, it uses
the name `anonymous` with the password `ftp@example.com`.

If you want to provide another user name and password, you can pass them on to
curl either with the `-u, --user` option or embed the info in the URL:

    curl --user daniel:secret ftp://example.com/download

    curl ftp://daniel:secret@example.com/download

  * [FTP Directory listing](dirlist.md)
  * [Uploading with FTP](upload.md)
  * [Custom FTP commands](cmds.md)
  * [Two connections](twoconnections.md)
  * [Directory traversing](traversedir.md)
  * [FTPS](ftps.md)
