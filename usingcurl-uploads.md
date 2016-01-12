## Uploads

Uploading is a term for sending data to a remote server. Uploading is done
differently for each protocol, and several protocols may even allow different
ways of uploading data.

### Protocols allowing upload

You can upload data using one of these protocols: FILE, FTP, FTPS, HTTP,
HTTPS, IMAP, IMAPS, SCP, SFTP, SMB, SMBS, SMTP, SMTPS and TFTP.

### HTTP offers several "uploads"

HTTP (and its bigger brother HTTPS) provides several different ways to upload
data to a server and curl offers easy command line options to do it the three
most common ways, described below.

An interesting detail with HTTP is also that an upload can also be a download,
in the same operation and in fact many downloads are initiated with a HTTP
POST.

#### POST

POST is the HTTP method that was invented to send data to a receving web
application, and it is for example how most common HTML forms on the web
works. It usually sends a chunk of relatively small amounts of data to the
receiver.

This upload kind is usually done with the `-d` or `--data` options, but there
are a few additional alterations.

Read the detailed description on how to do this with curl in the [HTTP POST
with curl](http-post.md) chapter.

#### multipart formpost

Multipart formposts are also used in HTML forms on web sites; typically when
there's a file upload involved. This type of upload is also a HTTP POST but it
sends the data formatted according to some special rules, which is what the
"multipart" name means.

Since it sends the data formatted completely differently, you cannot select
which type of POST to use at your own whim but it entirely depends on what the
receiving server end expects and can handle.

HTTP multipart formposts are done with `-F`. See the detailed description in
the [HTTP multipart formposts](http-multipart.md) chapter.

#### PUT

HTTP PUT is the sort of upload that was designed to send a complete resource
that is meant to be put as-is on the remote site or even replace an existing
resource there. That said, this is also the least used upload method for HTTP
on the web today and lots, if not most, web servers don't even have PUT
enabled.

You send off a HTTP upload with the -T option and you specify which file to
upload:

    curl -T uploadthis http://example.com/

### FTP uploads

Working with FTP, you get to see the remote file system you will be
accessing. You tell the server exactly in which directory you want the upload
to be placed and which file name to use. If you specify the upload URL with a
trailing slash, curl will append the locally used file name to the URL and
then that will be the file name used when stored remotely:

    curl -T uploadthis ftp://example.com/this/directory/

So if you prefer to select a different file name on the remote side than what
you've used locally, you specify it in the URL:

    curl -T uploadthis ftp://example.com/this/directory/remotename

### SMTP uploads

TBD

### Progress meter for uploads

TBD
