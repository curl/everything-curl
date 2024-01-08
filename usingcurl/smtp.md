# Sending email

Sending email with curl is done with the SMTP protocol. SMTP stands for
[Simple Mail Transfer
Protocol](https://en.wikipedia.org/wiki/Simple_Mail_Transfer_Protocol).

curl supports sending data to an SMTP server, which combined with the right
set of command line options makes an email get sent to a set of receivers of
your choice.

When sending SMTP with curl, there are two necessary command line options that
**must** be used.

 - You need to tell the server at least one recipient with `--mail-rcpt`. You
   can use this option several times and then curl tells the server that all
   those email addresses should receive the email.

 - You need to tell the server which email address that is the sender of the
   email with `--mail-from`. It is important to realize that this email
   address is not necessarily the same as is shown in the `From:` line of the
   email text.

Then, you need to provide the actual email data. This is a (text) file
formatted according to [RFC
5322](https://tools.ietf.org/html/rfc5322.html). It is a set of headers and a
body. Both the headers and the body need to be correctly encoded. The headers
typically include `To:`, `From:`, `Subject:`, `Date:` etc.

A basic command to send an email:

    curl smtp://mail.example.com --mail-from myself@example.com --mail-rcpt \
    receiver@example.com --upload-file email.txt

An example `email.txt` could look like this:

    From: John Smith <john@example.com>
    To: Joe Smith <smith@example.com>
    Subject: an example.com example email
    Date: Mon, 7 Nov 2016 08:45:16

    Dear Joe,
    Welcome to this example email. What a lovely day.

## Secure mail transfer

Some mail providers allow or require using SSL for SMTP. They may use a
dedicated port for SSL or allow SSL upgrading over a clear-text connection.

If your mail provider has a dedicated SSL port you can use smtps:// instead of
smtp://, which uses the SMTP SSL port of 465 by default and requires the entire
connection to be SSL. For example smtps://smtp.gmail.com/.

However, if your provider allows upgrading from clear-text to secure transfers
you can use one of these options:

    --ssl           Try SSL/TLS (FTP, IMAP, POP3, SMTP)
    --ssl-reqd      Require SSL/TLS (FTP, IMAP, POP3, SMTP)


You can tell curl to _try_ but not require upgrading to secure transfers by
adding `--ssl` to the command:

    curl --ssl smtp://mail.example.com --mail-from myself@example.com \
         --mail-rcpt receiver@example.com --upload-file email.txt \
         --user 'user@your-account.com:your-account-password'

You can tell curl to _require_ upgrading to using secure transfers by adding
`--ssl-reqd` to the command:

    curl --ssl-reqd smtp://mail.example.com --mail-from myself@example.com \
         --mail-rcpt receiver@example.com --upload-file email.txt \
         --user 'user@your-account.com:your-account-password'

## The SMTP URL

The path part of a SMTP request specifies the hostname to present during
communication with the mail server. If the path is omitted then curl attempts
to figure out the local computer's hostname and use that. However, this may
not return the fully qualified domain name that is required by some mail
servers and specifying this path allows you to set an alternative name, such
as your machine's fully qualified domain name, which you might have obtained
from an external function such as gethostname or getaddrinfo.

To connect to the mail server at `mail.example.com` and send your local
computer's hostname in the `HELO` or `EHLO` command:

    curl smtp://mail.example.com

You can of course as always use the `-v` option to get to see the
client-server communication.

To instead have curl send `client.example.com` in the `HELO` / `EHLO` command
to the mail server at `mail.example.com`, use:

    curl smtp://mail.example.com/client.example.com

## No MX lookup!

When you send email with an ordinary mail client, it first checks for an MX
record for the particular domain you want to send email to. If you send an
email to `joe@example.com`, the client gets the MX records for `example.com`
to learn which mail server(s) to use when sending email to example.com users.

curl does no MX lookups by itself. If you want to figure out which server to
send an email to for a particular domain, we recommend you figure that out
first and then call curl to use those servers. Useful command line tools to
get MX records include 'dig' and 'nslookup'.
