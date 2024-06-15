# Authentication

Doing transfers with libcurl usually allows the application to do it without
providing any credentials at all. You could perhaps call it *anonymously*.

For FTP transfers, libcurl then uses a default user and password as the
convention tells us, while with some other protocols like SFTP and SCP the
transfer is most likely to simply fail. Authentication is simply mandatory for
some transfers.

Authentication for libcurl means credentials (user + password) and in some
cases an additional method: letting the application select what authentication
method to use. Each protocol typically have their own sets.

Depending on the authentication method and if the transmission is perhaps not
using an authenticated security layer (such as TLS, QUIC or SSH) there is a
risk that sensitive information leaks over the network. The easiest way to
avoid this risk is to never use authentication with unauthenticated protocols.

For some protocols or methods, authentication is done per connection, for
others it is done per transfer. libcurl keeps track of that and makes sure
that connections are reused correctly. Meaning that sometimes it cannot reuse
connections for transfers done using different credentials but sometimes it
can.

## Username

Set the username with `CURLOPT_USERNAME`, as a plain null terminated C string.

The older option called `CURLOPT_USERPWD` is better avoided, for the simple
reason that it wants username and password in the same string, colon
separated, which easily cause problems if either the name or the password
contain a colon. Which can be tricky to guarantee never will happen.

## Password

Set the password to use with `CURLOPT_PASSWORD`, as a plain null terminated C
string.

## Method

The method selection depends on the protocol. For HTTP specifics, see the
[HTTP Authentication](../libcurl-http/auth.md) section.

# `.netrc`

Unix systems have for a long time offered a way for users to store their user
name and password for remote FTP servers. ftp clients have supported this for
decades and this way allowed users to quickly login to known servers without
manually having to reenter the credentials each time. The `.netrc` file is
typically stored in a user's home directory.

libcurl supports getting credentials from the `.netrc` file if you ask it to
it, with the `CURLOPT_NETRC` option.

This option has three different settings, with `CURL_NETRC_IGNORED` being the
default:

Setting it to `CURL_NETRC_OPTIONAL` means that the use of the *.netrc* file is
optional, and user information provided in the URL is to be preferred. The
file is scanned for the host and username to find the password.

`CURL_NETRC_REQUIRED` instead means that the use of the *.netrc* file is
required, and any credential information present in the URL is ignored.
