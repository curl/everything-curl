# Resuming and ranges

Resuming a download means first checking the size of what is already present
locally and then asking the server to send the rest of it so it can be
appended.  curl also allows resuming the transfer at a custom point without
actually having anything already locally present.

curl supports resumed downloads on several protocols. Tell it where to start
the transfer with the `-C, --continue-at` option that takes either a plain
numerical byte counter offset where to start or the string `-` that asks curl
to figure it out itself based on what it knows. When using `-`, curl will use
the destination file name to figure out how much data that is already present
locally and ask use that as an offset when asking for more data from the
server.

To start downloading an FTP file from byte offset 100:

    curl --continue-at 100 ftp://example.com/bigfile

Continue downloading a previously interrupted download:

    curl --continue-at - http://example.com/bigfile -O

If you instead just want a specific byte range from the remote resource
transferred, you can ask for only that. For example, when you only want 1000
bytes from offset 100 to avoid having to download the entire huge remote file:

    curl --range 100-1099 http://example.com/bigfile
