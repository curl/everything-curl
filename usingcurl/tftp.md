# TFTP

Trivial File Transfer Protocol (TFTP) is a simple clear-text protocol that
allows a client to get a file from or put a file onto a remote host.

Primary use cases for this protocol have been to get the boot image over a
local network. TFTP also stands out a little next to many other protocols by
the fact that it is done over UDP as opposed to TCP which most other protocols
use.

There is no secure version or flavor of TFTP.

## Download

Download a file from the TFTP server of choice:

    curl -O tftp://localserver/file.boot

## Upload

Upload a file to the TFTP server of choice:

    curl -T file.boot tftp://localserver/

## TFTP options

The TFTP protocols transmits data to the other end of the communication using
"blocks". When a TFTP transfer is setup, both parties either agree on using
the default block size of 512 bytes or negotiate a different one. curl
supports block sizes between 8 to 65464 bytes.

You ask curl to use a different size than the default with
`--tftp-blksize`. Ask for 8192 bytes blocks like this:

    curl --tftp-blksize 8192 tftp://localserver/file

It has been shown that there are server implementations that do not handle option
negotiation at all, so curl also has the ability to completely switch off all
attempts of setting options. If you are in the unfortunate of working with
such a server, use the flag like this:

    curl --tftp-no-options tftp://localserver/file
