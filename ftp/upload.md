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

curl also supports [globbing](../cmdline/globbing.md) in the `-T` argument so
you can opt to easily upload a range or a series of files:

    curl -T 'image[1-99].jpg' ftp://ftp.example.com/upload/

or

    curl -T '{Huey,Dewey,Louie}.jpg' ftp://ftp.example.com/nephews/
