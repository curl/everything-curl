# More advanced FTP

## FTP Directory listing

You can list a remote FTP directory with curl by making sure the URL ends with
a trailing slash. If the URL ends with a slash, curl will presume that it is a
directory you want to list. If it is not actually a directory, you will most
likely instead get an error.

    curl ftp://ftp.example.com/directory/

With FTP there is no standard syntax for the directory output that is returned
for this sort of command that uses the standard FTP command `LIST`. The
listing is usually humanly readable and perfectly understandable but you will
see that different servers will return the listing in slightly different ways.

One way to get just a listing of all the names in a directory and thus to avoid
the special formatting of the regular directory listings is to tell curl to
`--list-only` (or just `-l`). curl then issues the `NLST` FTP command instead:

    curl --list-only ftp://ftp.example.com/directory/

NLST has its own quirks though, as some FTP servers list only actual *files*
in their response to NLST; they do not include directories and symbolic links!

## Uploading with FTP

To upload to an FTP server, you specify the entire target file path and name
in the URL, and you specify the local file name to upload with `-T,
--upload-file`. Optionally, you end the target URL with a slash and then the
file component from the local path will be appended by curl and used as the
remote file name.

Like:

    curl -T localfile ftp://ftp.example.com/dir/path/remote-file

or to use the local file name as the remote name:

    curl -T localfile ftp://ftp.example.com/dir/path/

curl also supports [globbing](cmdline-globbing.md) in the -T argument so you
can opt to easily upload a range or a series of files:

    curl -T 'image[1-99].jpg' ftp://ftp.example.com/upload/

or

    curl -T '{Huey,Dewey,Louie}.jpg' ftp://ftp.example.com/nephews/

## Custom FTP commands

TBD

## FTPS

TBD

## Common FTP problems

TBD
