# POP3

There are two dominant protocols on the Internet for reading/downloading email
from servers (at least if we do not count web based reading), and they are
[IMAP](imap.md) and POP3. The former being the slightly more modern
alternative. curl supports both.

## Basics

To list message numbers and sizes:

    curl pop3://mail.example.com/

To download message 1:

    curl pop3://mail.example.com/1

To delete message 1:

    curl --request DELE pop3://mail.example.com/1

## TLS for POP3

POP3 can be done over a secure connection and it can be done using either
explicit or implicit TLS. The *explicit* method is probably the most common
approach and it means that the client connects to the server using an insecure
connection and *upgrades* it to TLS as it goes, using the `STARTTLS` command.

You tell curl to use this upgrade approach with `--ssl-reqd`. It says that the
upgrade is required to work or curl will fail the transfer. There is also the
not-recommended insecure alternative `--ssl` that *attempts* to use TLS but
that continues even if the upgrade fails.

Like this:

    curl pop3://mail.example.com/ --ssl-reqd

or the insecure and opportunistic approach:

    curl --ssl imap://mail.example.com/inbox

*Implicit SSL* means that the connection gets secured already at first
connect, which you make curl do by specifying a scheme in the URL that uses
SSL. In the case of secure POP3 that means `pop3s://`. For such connections,
curl insists on connecting and negotiating a TLS connection already from the
start, or it fails its operation.

The previous explicit examples done with implicit SSL:

    curl pop3s://mail.example.com/
