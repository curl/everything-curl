# FTP

FTP, the File Transfer Protocol, is probably the oldest network protocol that
curl supports - it was created in the early 1970s and the official spec that
still is the goto documention is [RFC 959](http://www.ietf.org/rfc/rfc959.txt)
from 1985. Published well over a decade before the first curl release.

FTP was created in a different era of Internet and computers and as such it
works a little bit differently than most other protocols. These differences
can often be ignored and things will just work, but similarly they are also
important to know at times when things don't run as planned.

## Two connections

FTP uses two TCP connections! The first connection is setup by the client when
it connects to an FTP server, and is called the *control connection*. As the
intial connection, it gets to handle authentication and changing to the
correct directory on the remote server etc. When the client then is ready to
transfer a file, a second TCP connection is established and the data is
transfered over that.

This setting up of a second connection causes nuisances and headaches for
several reasons.

### Active connections

The client can opt to ask the server to connect to the client to set it up. A
so called "active" connection. This is done with the PORT or EPRT
commands. Allowing a remote host to connect back to a client on a port that
the client opens up requires that there's no firewall or other network
appliance in between that refuses that to go through - and that is far from
always the case. You ask for an active transfer using `curl -P [arg]` (also
known as `--ftp-port` in long form) and while the option allows you to specify
exactly which address to use, just setting the same as you come from is almost
always the correct choice and you do that with `-P -`. Like asking for a file:

    $ curl -P - ftp://example.com/foobar.txt

You can also explicitly ask curl to not use EPRT (which is a slightly newer
command than PORT) with the `--no-epsv` command line option.

### Passive connections

Curl defaults to asking for a "passive" connection, which means it sends a
PASV or EPSV command to the server and then the server opens up a new port for
the second connection that then curl connects to. Outgoing connections to a
new port are generally easier and less restricted for end users and clients,
but it then requires that the network in the server's end allows it.

Passive connections are enabled by default, but if you've switched on active
before, you can switch back to passive with `--ftp-pasv`.

You can also explicitly ask curl not to use EPSV (which is a slightly newer
command than PASV) with the `--no-epsv` command line option.

Sometimes the server is running a funky setup so that when curl issues the
PASV command and the server responds with an IP address for curl to connect
to, that address is wrong and then curl fails to setup the data
connection. For this (hopefully rare) situation, you can ask curl to ignore
the IP address mentioned in the PASV response (`--ftp-skip-pasv-ip`) and
instead use the same IP address it has for the control connection even for the
second connection.

### Firewall issues

Using either active or passive transfers, any existing firewalls in the
network path pretty much have to have stateful inspection of the FTP traffic
to figure out the new port to open that up and accept it for the second
connection.

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

## --ftp-method

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
