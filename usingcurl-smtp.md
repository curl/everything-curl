# SMTP

SMTP stands for [Simple Mail Transfer Protocol](https://en.wikipedia.org/wiki/Simple_Mail_Transfer_Protocol).

curl supports sending data to a an SMTP server, which combined with the right
set of command line options makes an email get sent to a set of receivers of
your choice.

When sending SMTP with curl, there are a two necessary command line options
that **must** be used.

 - You need to tell the server at least one recepient with `--mail-rcpt`. You
   can use this option several times and then curl will tell the server that all
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

A basic command line to send an email:

    curl smtp://mail.example.com --mail-from myself@example.com --mail-rcpt
    receiver@example.com --upload-file email.txt

## Example email.txt

    From: John Smith <john@example.com>
    To: Joe Smith <smith@example.com>
    Subject: an example.com example email
    Date: Mon, 7 Nov 2016 08:45:16
    
    Dear Joe,
    Welcome to this example email. What a lovely day.
