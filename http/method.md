# Method

In every HTTP request, there is a method. Sometimes called a verb. The most
commonly used ones are `GET`, `POST`, `HEAD` and `PUT`.

Normally however you do not specify the method in the command line, but
instead the exact method used depends on the specific options you use. `GET`
is default, using `-d` or `-F` makes it a `POST`, `-I` generates a `HEAD` and
`-T` sends a `PUT`.

More about this in the [Modify the HTTP request](modify/) section.
