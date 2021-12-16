# Fragment

URLs offer a fragment part. That is usually seen as a hash symbol (#) and a
name for a specific name within a web page in browsers. An example of such a
URL might look like:

    https://www.example.com/info.html#the-plot

curl supports fragments fine when a URL is passed to it, but the fragment part
is never actually sent over the wire so it does not make a difference to
curl's operations whether it is present or not.

If you want to make the `#` character as part of the path and not separating
the fragment, make sure to pass it URL-encoded, as `%23`:

    curl https://www.example.com/info.html%23the-plot
