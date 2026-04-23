# Discard recveived data

Sometimes it is convenient to run a transfer but not actually store the data
anywhere. This can be done in several ways.

- You can opt to save it to a file and then delete the file after completion.

- You can redirect the output to `/dev/null` or its equivalent. Unfortunately
  different systems have different ways to do this which makes such a curl
  command line system specific.

- Use `--out-null` as a portable option to silently discard the received data
  without storing it anywhere.
