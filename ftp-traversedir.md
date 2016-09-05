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

