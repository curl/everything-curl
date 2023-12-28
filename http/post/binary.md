# Posting binary

When reading data to post from a file, `-d` strips out carriage returns and
newlines. Use `--data-binary` if you want curl to read and use the given file
in binary exactly as given:

    curl --data-binary @filename http://example.com/
