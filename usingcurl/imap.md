# IMAP

There are two dominant protocols on the Internet for reading/downloading email
from servers (at least if we do not count web based reading), and they are
IMAP and [POP3](pop3.md). The former is the slightly more modern alternative.
curl supports both. IMAP also allows emails to get uploaded, which POP3 does
not.

## Basics

Get the mail using the UID 57 from mailbox 'stuff':

    curl imap://server.example.com/stuff;UID=57

Instead, get the mail with index 57 from the mailbox 'fun':

    curl imap://server.example.com/fun;MAILINDEX=57

List the mails in the mailbox 'boring':

    curl imap://server.example.com/boring

List the mails in the mailbox 'boring' and provide user and password:

    curl imap://server.example.com/boring -u user:password

## TLS for IMAP

IMAP can be done over a secure connection and it can be done using either
explicit or implicit TLS. The *explicit* method is probably the most common
approach and it means that the client connects to the server using an insecure
connection and *upgrades* it to TLS as it goes, using the `STARTTLS` command.

You tell curl to use this upgrade approach with `--ssl-reqd`. It says that the
upgrade is required to work or curl fails the transfer. There is also the
not-recommended insecure alternative `--ssl` that *attempts* to use TLS but
that continues even if the upgrade fails.

Example use:

    curl --ssl-reqd imap://server.example.com/boring

*Implicit SSL* means that the connection gets secured already at first
connect, which you make curl attempt by specifying a scheme in the URL that
uses SSL. In the case of secure IMAP that means `imaps://`. For such
connections, curl insists on connecting and negotiating a TLS connection
already from the start, or it fails its operation.

The previous explicit examples done with implicit SSL:

    curl imaps://mail.example.com/inbox

## Upload

Uploading data to an IMAP server means putting an email into a remote specific
"mailbox".

    curl imap://imap.example/mailbox -T file.txt -u user:secret --ssl-reqd

When curl uploads an email to an IMAP mailbox, it will by default flag that
email as already read. As already *seen* to use IMAP language.

You can alter the default flags for IMAP uploads using the --upload-flags
option. Make the newly uploaded email appear as `answered`, `deleted`,
`draft`, `flagged` or `seen` by providing your set in a comma-separated list.

Negate a flag by prefixing it with a minus (`-`).

For example, mark the upload as not seen and a draft:

    curl imap://imap.example/mailbox -T email.txt --upload-flags "-seen,draft"
