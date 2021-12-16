# Posting binary

When reading data to post from a file, `-d` will strip out carriage return and
newlines. Use `--data-binary` if you want curl to read and use the given file
in binary exactly as given:

    curl --data-binary @filename http://example.com/
