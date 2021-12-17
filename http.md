# HTTP with curl

In all user surveys and during all curl's lifetime, HTTP has been the most
important and most frequently used protocol that curl supports. This chapter
will explain how to do effective HTTP transfers and general fiddling with
curl.

This will mostly work the same way for HTTPS, as they are really the same thing
under the hood, as HTTPS is HTTP with an extra security TLS layer. See also
the specific [HTTPS](#https) section below.

## HTTP methods

In every HTTP request, there is a method. Sometimes called a verb. The most
commonly used ones are GET, POST, HEAD and PUT.

Normally however you do not specify the method in the command line, but
instead the exact method used depends on the specific options you use. GET is
default, using `-d` or `-F` makes it a POST, `-I` generates a HEAD and `-T`
sends a PUT.

More about this in the [Modify the HTTP request](http/requests.md) section.
