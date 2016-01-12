## HTTP POST

POST is the HTTP method that was invented to send data to a receving web
application, and it is for example how most common HTML forms on the web
works. It usually sends a chunk of relatively small amounts of data to the
receiver.

When the data is sent by a browser after data have been filled in a form, it
will send it "URL encoded", as a serialized name=value pairs separated with
ampersand symbols ('&'). You send such data with curl's `-d` or `--data`
option like this:

    curl -d name=admin&shoesize=12 http://example.com/

When specifying multiple `-d` options on the command line, curl will
concatenate them and insert ampersands in between, so the above example could
also be made like this:

    curl -d name=admin -d shoesize=12 http://example.com/

If the amount of data to send isn't really fit to put in a mere string on the
command line, you can also read it off a file name in standard curl style:

    curl -d @filename http://example.com

### POSTing binary

When reading from a file, `-d` will strip out carriage return and
newlines. Use `--data-binary` if you want curl to read and use the given file
in binary exactly as given:

    curl --data-binary @filename http://example.com/

### URL encoding

TBD

### Converting an HTML form

TBD
