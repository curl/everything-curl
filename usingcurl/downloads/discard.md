# Discard received data

Sometimes it is convenient to run a transfer but not actually store the data
anywhere. This can be done in several ways.

- You can opt to save it to a file and then delete the file after completion.

- You can redirect the output to `/dev/null` or its equivalent. Unfortunately
  different systems have different ways to do this which makes such a curl
  command line system specific.

- Use `--out-null` as a portable option to silently discard the received data
  without storing it anywhere.

Example to view the verbose output for a full transfer:

    curl -v https://download.example/ --out-null

If you use an older curl version that does not support `--out-null`, use the
platform-specific null device instead:

Unix-like systems:

    curl -v https://download.example/ -o /dev/null

Windows:

    curl -v https://download.example/ -o NUL
