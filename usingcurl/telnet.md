# TELNET

Telnet is an ancient application protocol for bidirectional **clear-text**
communication. It was designed for interactive text-oriented communications
and *there is no encrypted or secure version* of Telnet.

TELNET is not a perfect match for curl. The protocol is not done to handle
plain uploads or downloads so the usual curl paradigms have had to be
stretched somewhat to make curl deal with it appropriately.

curl sends received data to stdout and it reads input to send on stdin. The
transfer is complete when the connection is dropped or when the user presses
control-c.

## Historic TELNET

Once upon the time, systems provided telnet access for login. Then you could
connect to a server and login to it, much like how you would do it with SSH
today. That practice has fortunately now mostly been moved into the museum
cabinets due to the insecure nature of the protocol.

The default port number for telnet is 23.

## Debugging with TELNET

The fact that TELNET is basically just a simple clear-text TCP connection to
the target host and port makes it somewhat useful to debug other protocols and
services at times.

Example, connect to your local HTTP server on port 80 and send a (broken)
request to it by manually entering `GET /` and press return twice:

    curl telnet://localhost:80

Your web server most probably returns something like this back:

    HTTP/1.1 400 Bad Request
    Date: Tue, 07 Dec 2021 07:41:16 GMT
    Server: softeare/7.8.9
    Content-Length: 31
    Connection: close
    Content-Type: text/html

    [message]

## Options

When curl sets up a TELNET connection to a server, you can ask it to pass on
options. You do this with `--telnet-option` (or `-t`), and there are three
options available to use:

- `TTYPE=<term>` sets the "terminal type" for the session to be `<term>`.
- `XDISPLOC=<X display>` sets the X display location
- `NEW_ENV=<var,val>` sets the environment variable `var` to the value `val`
  in the remote session

Login to your local machine's telnet server and tell it you use a `vt100`
terminal:

    curl --telnet-option TTYPE=vt100 telnet://localhost

You need to manually enter your name and password when prompted.
