# Reading email

There are two dominant protocols on the Internet for reading/downloading email
from servers (at least if we don't count web based reading), and they are IMAP
and POP3. The former being the slightly more modern alternative. curl supports
both.

## POP3

To list message numbers and sizes:

    curl pop3://mail.example.com/

To download message 1:

    curl pop3://mail.example.com/1

To delete message 1:

    curl --request DELE pop3://mail.example.com/1

## IMAP

TBD
