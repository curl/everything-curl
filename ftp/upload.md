# Uploading with FTP

To upload to an FTP server, you specify the entire target file path and name
in the URL, and you specify the local filename to upload with `-T,
--upload-file`. Optionally, you end the target URL with a slash and then the
file component from the local path is appended by curl and used as the remote
filename.

Like:

    curl -T localfile ftp://ftp.example.com/dir/path/remote-file

or to use the local filename as the remote name:

    curl -T localfile ftp://ftp.example.com/dir/path/

curl also supports [globbing](../cmdline/globbing.md) in the `-T` argument so
you can opt to easily upload a range of files:

    curl -T 'image[1-99].jpg' ftp://ftp.example.com/upload/

or a series of files:

    curl -T '{file1,file2}' ftp://ftp.example.com/upload/

or

    curl -T '{Huey,Dewey,Louie}.jpg' ftp://ftp.example.com/nephews/
