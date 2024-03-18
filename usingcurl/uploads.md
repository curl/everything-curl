# Uploads

Uploading is a term for sending data to a remote server. Uploading is done
differently for each protocol, and several protocols may even allow different
ways of uploading data.

## Protocols allowing upload

You can upload data using one of these protocols: FILE, FTP, FTPS, HTTP,
HTTPS, IMAP, IMAPS, SCP, SFTP, SMB, SMBS, SMTP, SMTPS and TFTP.

## HTTP offers several uploads

HTTP, and its bigger brother HTTPS, offer several different ways to upload
data to a server, and curl provides easy command-line options to do it the
three most common ways, described below.

An interesting detail with HTTP is that an upload can also be a download,
in the same operation and in fact many downloads are initiated with an HTTP
POST.

### POST

POST is the HTTP method that was invented to send data to a receiving web
application, and it is, for example, how most common HTML forms on the web
work. It usually sends a chunk of relatively small amounts of data to the
receiver.

The upload kind is usually done with the `-d` or `--data` options, but there
are a few additional alterations.

Read the detailed description on how to do this with curl in the
[HTTP POST with curl](../http/post/) chapter.

### multipart formpost

Multipart formposts are also used in HTML forms on websites; typically when
there is a file upload involved. This type of upload is also an HTTP POST but
it sends the data formatted according to some special rules, which is what the
multipart name means.

Since it sends the data formatted completely differently, you cannot select
which type of POST to use at your own whim but it entirely depends on what the
receiving server end expects and can handle.

HTTP multipart formposts are done with `-F`. See the detailed description in
the [HTTP multipart formposts](../http/post/multipart.md) chapter.

### PUT

HTTP PUT is the upload method that was designed to send a complete resource
meant to be put as-is on the remote site or even replace an existing resource
there. That said, this is also the least used upload method for HTTP on the
web today and lots, if not most, web servers do not even have PUT enabled.

You send off an HTTP upload using the -T option with the file to upload:

    curl -T uploadthis http://example.com/

## FTP uploads

Working with FTP, you get to see the remote file system you are accessing.
You tell the server exactly in which directory you want the upload to be
placed and which filename to use. If you specify the upload URL with a
trailing slash, curl appends the locally used filename to the URL and then
that becomes the filename used when stored remotely:

    curl -T uploadthis ftp://example.com/this/directory/

So if you prefer to select a different filename on the remote side than what
you have used locally, you specify it in the URL:

    curl -T uploadthis ftp://example.com/this/directory/remotename

Learn much more about FTPing in the [FTP with curl](../ftp/) section.

## SMTP uploads

You may not consider sending an email to be uploading, but to curl it is. You
upload the mail body to the SMTP server. With SMTP, you also need to include
all the mail headers you need (`To:`, `From:`, `Date:`, etc.) in the mail body
as curl does not add any at all.

    curl -T mail smtp://mail.example.com/ --mail-from user@example.com

Learn more about using SMTP with curl in the [Sending email](smtp.md) section.

## Progress meter for uploads

The general progress meter curl provides (see the
[Progress meter](../cmdline/progressmeter.md) section) works fine for uploads as well.
What needs to be remembered is that the progress meter is automatically
disabled when you are sending output to stdout, and most protocols curl
support can output something even for an upload.

Therefore, you may need to explicitly redirect the downloaded data to a file
(using shell redirect '>', `-o` or similar) to get the progress meter
displayed for upload.
