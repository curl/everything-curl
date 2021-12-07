# TLS auth

TLS connections offer a (rarely used) feature called Secure Remote
Passwords. Using this, you authenticate the connection for the server using a
name and password and the command line flags for this are `--tlsuser <name>`
and `--tlspassword <secret>`. Like this:

    curl --tlsuser daniel --tlspassword secret https://example.com
