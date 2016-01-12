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
most common ways.

#### POST

POST is the HTTP method that was invented to send data to a receving web
application, and it is for example how most common HTML forms on the web
works. It usually sends a chunk of relatively small amounts of data to the
receiver.

Read the detailed description on how to do this with curl in the [HTTP POST
with curl chapter](http-post.md).

#### multipart formpost.

TBD

#### PUT

TBD

### FTP uploads

TBD

### SMTP uploads

TBD
