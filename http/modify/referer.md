# Referer

When a user clicks on a link on a webpage and the browser takes the user away
to the next URL, it sends the new URL a `Referer:` header in the new request
telling it where it came from. That is the referer header. The `Referer:` is
misspelled but that is how it is supposed to be.

With curl you set the referer header with `-e` or `--referer`, like this:

    curl --referer http://comes-from.example.com https://www.example.com/
