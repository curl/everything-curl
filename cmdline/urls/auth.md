# Name and password

Following the scheme in a URL, there can be a possible user name and password
field embedded. The use of this syntax is usually frowned upon these days
since you easily leak this information in scripts or otherwise. For example,
listing the directory of an FTP server using a given name and password:

    curl ftp://user:password@example.com/

The presence of user name and password in the URL is completely optional. curl
also allows that information to be provide with normal command-line options,
outside of the URL.

