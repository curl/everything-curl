# FTP

FTP, the File Transfer Protocol, is probably the oldest network protocol that
curl supports - it was created in the early 1970s and the official spec that
still is the goto documention is [RFC 959](http://www.ietf.org/rfc/rfc959.txt)
from 1985. Published well over a decade before the first curl release.

FTP was created in a different era of Internet and computers and as such it
works a little bit differently than most other protocols. These differences
can often be ignored and things will just work, but similarly they are also
important to know at times when things don't run as planned.

## Ping-pong

The FTP protocol is a command and response protocol. The client sends a
command and the server responds. If you use curl's `-v` option you'll get to
see all the commands and responses during a transfer.

For an ordinary transfer, there are something like 5 to 8 commands necessary
to send and as many responses to wait for and read. Perhaps needlessly to say,
but if the server is in a remote location there will be a lot of time waiting
for the ping pong to go through before the actual file transfer can be set up
and get started. For small files, the initial commands can very well take
longer time than the actual data transfer.

## How to traverse directories

When doing FTP commands to traverse the remote file system, there are a few
different ways curl can proceed to reach the target file. The file the user
wants to transfers.

### multicwd

curl can do one change-directory (CWD) command for every individual directory
down the file tree hierarchy. If the full path is `one/two/three/file.txt`,
that method means doing three `CWD` commands before asking for the `file.txt`
file to get transfered. This method thus creates quite a large number of
commands if the path is many levels deep. This method is mandated by an early
spec (RFC 1738) and is how curl acts by default.

    curl --ftp-method multicwd ftp://example.com/one/two/three/file.txt

### nocwd

The opposite to doing one CWD for each directory part is to not change
directory at all. This method asks the server using the entire path at once
and is thus very fast. Occasionally servers have a problem with this and it
isn't purely standards compliant.

    curl --ftp-method nocwd ftp://example.com/one/two/three/file.txt

### singlecwd

This is the inbetween the other two FTP methods. This makes a single `CWD`
command to the target directory and then it asks for the given file.

    curl --ftp-method singlecwd ftp://example.com/one/two/three/file.txt

## Transfer mode

When an FTP client is about to transfer data, it specifies to the server which
"transfer mode" it likes the upcoming transfer to use. The two transfer modes
curl supports are 'ASCII' and 'BINARY'. Ascii is basically for text and
usually means that the server will send the files with converted newlines
while binary means sending the data unaltered and assuming the file is not
text.

curl will default to binary transfer mode for FTP, and you ask for ascii mode
instead with `-B, --use-ascii` or making sure the URL ends with `;type=A`.

## Authentication

TBD

## Directory listing

TBD

## Uploading

TBD

## Custom commands

TBD

## FTPS

TBD

## Common FTP problems

TBD
