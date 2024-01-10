# URL encode data

Percent-encoding, also known as URL encoding, is technically a mechanism for
encoding data so that it can appear in URLs. This encoding is typically used
when sending POSTs with the `application/x-www-form-urlencoded` content type,
such as the ones curl sends with `--data` and `--data-binary` etc.

The command-line options mentioned above all require that you provide properly
encoded data, data you need to make sure already exists in the right format.
While that gives you a lot of freedom, it is also a bit inconvenient at times.

To help you send data you have not already encoded, curl offers the
`--data-urlencode` option. This option offers several different ways to URL
encode the data you give it.

You use it like `--data-urlencode data` in the same style as the other --data
options. To be CGI-compliant, the **data** part should begin with a name
followed by a separator and a content specification. The **data** part can be
passed to curl using one of the following syntaxes:

 - `content`: URL encode the content and pass that on. Just be careful so that
   the content does not contain any `=` or `@` symbols, as that then makes the
   syntax match one of the other cases below.

 - `=content`: URL encode the content and pass that on. The initial `=` symbol
   is not included in the data.

 - `name=content`: URL encode the content part and pass that on. Note that the
   name part is expected to be URL encoded already.

 - `@filename`: load data from the given file (including any newlines), URL
   encode that data and pass it on in the POST.

 - `name@filename`: load data from the given file (including any newlines),
   URL encode that data and pass it on in the POST. The name part gets an
   equal sign appended, resulting in `name=urlencoded-file-content`. Note that
   the name is expected to be URL encoded already.

As an example, you could POST a name to have it encoded by curl:

    curl --data-urlencode "name=John Doe (Junior)" http://example.com

…which would send the following data in the actual request body:

    name=John%20Doe%20%28Junior%29

If you store the string `John Doe (Junior)` in a file named `contents.txt`,
you can tell curl to send that contents URL encoded using the field name
'user' like this:

    curl --data-urlencode user@contents.txt http://example.com

In both these examples above, the field name is not URL encoded but is passed
on as-is. If you want to URL encode the field name as well, like if you want
to pass on a field name called `user name`, you can ask curl to encode the
entire string by prefixing it with an equals sign (that does not get sent):

    curl --data-urlencode "=user name=John Doe (Junior)" http://example.com
