# HTTP/0.9

The HTTP version used before HTTP/1.0 was made available is often referred to
as HTTP/0.9. Back in those days, HTTP responses had no headers as they would
only return a response body and then immediately close the connection.

curl can be told to support such responses but by default it does not
recognize them, for security reasons. Almost anything bad looks like an
HTTP/0.9 response to curl so the option needs to be used with caution.

The HTTP/0.9 option to curl is different than the other HTTP command line
options for HTTP versions mentioned above as this controls what response to
accept, while the others are about what HTTP protocol version to try to use.

Tell curl to accept an HTTP/0.9 response like this:

    curl --http0.9 https://example.com/
