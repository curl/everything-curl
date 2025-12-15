# Reading email

There are two dominant protocols on the Internet for reading/downloading email
from servers (at least if we do not count web based reading), and they are IMAP
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

For clarity, server authentication with `--username` / `-u` is elided, and
(while usually not required) IMAP commands and their arguments are upper-cased.
For reasons noted below, you will probably want to include curl's `-v` or
`--verbose` option when initially tinkering with its IMAP support.

List (sub)mailboxes in the main inbox:

    curl imap://server.example.com

List (sub)mailboxes in the mailbox `boring`, with the IMAP server on a
non-standard port number:

    curl imap://server.example.com:1143/boring

List all emails in the inbox:

    # use quotes appropriate to your shell here to preserve internal whitespace
    curl imap://server.example.com:1143/INBOX -X 'FETCH 1:* FAST'

This produces output similar to what's below; the numbers after the asterisks
are the **mailbox indices** of the messages, counting from 1:

    * 1 FETCH (FLAGS (\Flagged \Deleted \Seen) INTERNALDATE " 3-Dec-2025 12:02:39 -0500" RFC822.SIZE 15163)
    * 2 FETCH (FLAGS (\Deleted \Seen) INTERNALDATE " 6-Dec-2025 09:01:30 -0500" RFC822.SIZE 26862)
    * 3 FETCH (FLAGS (\Seen nonjunk $label1) INTERNALDATE "10-Sep-2025 12:09:16 -0400" RFC822.SIZE 11713)
    ...

To retrieve message UIDs, needed for `FETCH` and
[similar commands](#imap-fetch-message), try this:

    curl imap://server.example.com:1143/INBOX -X 'FETCH 1:* UID'

See IETF [RFC 3501](https://datatracker.ietf.org/doc/html/rfc3501) or later
RFCs for details and other available commands.

### Fetching individual messages from IMAP {#imap-fetch-message}

Get the message having UID 57 from mailbox `stuff`. Many shells will require
you to quote or escape the semicolon, thus:

    curl 'imap://server.example.com/stuff;UID=57'

Get the 57<sup>th</sup> message from the mailbox `fun`:

    curl 'imap://server.example.com/fun;MAILINDEX=57'

Be aware that deleted but not "expunged" messages still have an index!
   
Note that `FETCH`es will probably not do what you initially expect; see
[bug #536](https://github.com/curl/curl/issues/536). For example:

    curl 'imap://server.example.com/stuff' -X 'FETCH 1 BODY.PEEK[]'

yields only

    * 1 FETCH (BODY[] {11713}

…rather than the full message body you were expecting. As a workaround, add the
`-v` / `--verbose` option to your `curl` invocation, which prints the `BODY` to
standard error.

Here are a few handy other handy `FETCH` commands:

    # get flags, date, and message size for all messages in 'stuff'
    curl -sv 'imap://server.example.com/stuff' -X 'FETCH 1 FAST'

    # get UID, size, and 1024 bytes of message body (which includes headers)
    curl -sv 'imap://server.example.com/stuff' -X 'FETCH 1 (UID RFC822.SIZE BODY.PEEK[]<0.1024>)'

See [RFC 3501 § 6.4.5](https://datatracker.ietf.org/doc/html/rfc3501#section-6.4.5)
for details of the `FETCH` command.

## TLS for emails

POP3 and IMAP can both be done over a secure connection and both can be done
using either explicit or implicit TLS. The "explicit" method is probably the
most common approach and it means that the client connects to the server using
an insecure connection and *upgrades* it to TLS as it goes, using the
`STARTTLS` command. You tell curl to attempt this with `--ssl` or if you want
to *insist* on a secure connection you use `--ssl-reqd`. Like this:

    curl pop3://mail.example.com/ --ssl-reqd

or

    curl --ssl imap://mail.example.com/inbox

"Implicit" SSL means that the connection gets secured already at first
connect, which you make curl attempt by specifying a scheme in the URL that
uses SSL. In this case either `pop3s://` or `imaps://`. For such connections,
curl insists on connecting and negotiating a TLS connection already from the
start, or it fails its operation.

The previous explicit examples done with implicit SSL:

    curl pop3s://mail.example.com/

or

    curl imaps://mail.example.com/inbox
