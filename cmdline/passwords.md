# Passwords

Passwords are tricky and sensitive. Leaking a password can make someone other
than you access the resources and the data otherwise protected.

curl offers several ways to receive passwords from the user and then
subsequently pass them on or use them to something else.

The most basic curl authentication option is `-u / --user`. It accepts an
argument that is the username and password, colon separated. Like when `alice`
wants to request a page requiring HTTP authentication and her password is
`12345`:

    $ curl -u alice:12345 http://example.com/

## Command line leakage

Several potentially bad things are going on here. First, we are entering a
password on the command line and the command line might be readable for other
users on the same system (assuming you have a multi-user system). curl helps
minimize that risk by trying to blank out passwords from process listings.

One way to avoid passing the username and password on the command line is to
instead use a [.netrc file](../usingcurl/netrc.md) or a [config file](configfile.md).
You can also use the `-u` option without specifying the password, and then
curl instead prompts the user for it when it runs.

## Network leakage

Secondly, this command line sends the user credentials to an HTTP server,
which is a clear-text protocol that is open for man-in-the-middle or other
snoopers to spy on the connection and see what is sent. In this command line
example, it makes curl use HTTP Basic authentication and that is completely
insecure.

There are several ways to avoid this, and the key is, of course, then to avoid
protocols or authentication schemes that send credentials in plain text over
the network. Easiest is perhaps to make sure you use encrypted versions of
protocols. Use HTTPS instead of HTTP, use FTPS instead of FTP and so on.

If you need to stick to a plain text and insecure protocol, then see if you
can switch to using an authentication method that avoids sending the
credentials in the clear. If you want HTTP, such methods would include Digest
(`--digest`), Negotiate (`--negotiate.`) and NTLM (`--ntlm`).
