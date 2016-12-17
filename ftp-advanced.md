# More advanced FTP

## Directory listing

You can list a remote FTP directory with curl by making sure the URL ends with
a trailing slash. If the URL ends with a slash, curl presumes that is a
directory you want to list. If it actually isn't a directory, you will most
likely instead get an error returned.

    curl ftp://ftp.example.com/directory/

With FTP there is no standard syntax for the directory output that is returned
for this sort of command that uses the standard FTP command `LIST`. The
listing is usually humanly readable and perfectly understandable but you will
see that different servers will return the listing in slightly different ways.

One to get just a listing of all the names in a directory and thus to avoid
the special formatting of the regular directory listings, is to tell curl to
`--list-only` (or just `-l`). curl then issues the `NLST` FTP command instead:

    curl --list-only ftp://ftp.example.com/directory/

NLST has its own quirks though, as some FTP servers list only actual *files*
in their response to NLST; they do not include directories and symbolic links!

## Uploading

TBD

## Custom commands

TBD

## FTPS

TBD

## Common FTP problems

TBD
