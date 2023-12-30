# HTML and charsets

curl downloads the exact binary data that the server sends. This might be of
importance to you in case, for example, you download an HTML page or other
text data that uses a certain character encoding that your browser then
displays as expected. curl does not translate the arriving data.

A common example where this causes some surprising results is when a user
downloads a webpage with something like:

    curl https://example.com/ -o storage.html

…and when inspecting the `storage.html` file after the fact, the user realizes
that one or more characters look funny or downright wrong. This might occur
because the server sent the characters using charset X, while your editor and
environment use charset Y. In an ideal world, we would all use UTF-8
everywhere but unfortunately, that is still not the case.

A common work-around for this issue that works decently is to use the
common `iconv` utility to translate a text file to and from different
charsets.
