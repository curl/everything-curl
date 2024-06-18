# Compression

Automatic compression of data before it gets sent can help getting the data to
the other end faster due to the reduced bandwidth needed.

curl offers automatic compression and decompression for SFTP, SCP and HTTP(S).
With HTTP(S) it is only possible to do it for downloads, while SFTP and SCP
offer it for both directions.

## For HTTP

See [HTTP compression](../../http/modify/compression.md) for the details.

## For SFTP/SCP

Provide the `--compressed-ssh` option on the command line and the transfer
will automatically and transparently use compression if it can. Like:

    curl -O --compressed-ssh sftp://example.com/bigfile
