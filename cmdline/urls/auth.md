# Name and password

Following the scheme in a URL, there can be a possible user name and password
field embedded. The use of this syntax is usually frowned upon these days
since you easily leak this information in scripts or otherwise. For example,
listing the directory of an FTP server using a given name and password:

    curl ftp://user:password@example.com/

The presence of user name and password in the URL is completely optional. curl
also allows that information to be provided with normal command-line options,
outside of the URL.

If you want a non-ASCII letter or maybe a `:` or `@` as part of the user name
and/or password, remember to URL encode that letter: write it as `%HH` where
`HH` is the hexadecimal byte value. `:` is `%3a` and `@` is `%40`.
