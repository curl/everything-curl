# IMAP

There are two dominant protocols on the Internet for reading/downloading email
from servers (at least if we do not count web based reading), and they are
IMAP and [POP3](pop3.md). The former being the slightly more modern
alternative. curl supports both.

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
upgrade is required to work or curl will fail the transfer. There is also the
not-recommended insecure alternative `--ssl` that *attempts* to use TLS but
that continues even if the upgrade fails.

*Implicit SSL* means that the connection gets secured already at first
connect, which you make curl attempt by specifying a scheme in the URL that
uses SSL. In the case of secure IMAP that means `imaps://`. For such
connections, curl insists on connecting and negotiating a TLS connection
already from the start, or it fails its operation.

The previous explicit examples done with implicit SSL:

    curl imaps://mail.example.com/inbox
