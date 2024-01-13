# HTTP proxy

An HTTP proxy is a proxy that the client speaks HTTP with to get the transfer
done. curl does by default, assume that a host you point out with `-x` or
`--proxy` is an HTTP proxy, and unless you also specify a port number it
defaults to port 1080 (and the reason for that particular port number is
purely historical).

If you want to request the example.com webpage using a proxy on 192.168.0.1
port 8080, a command line could look like:

    curl -x 192.168.0.1:8080 http://example.com/

Recall that the proxy receives your request, forwards it to the real
server, then reads the response from the server and then hands that back to the
client.

If you enable verbose mode with `-v` when talking to a proxy, it shows that
curl connects to the proxy instead of the remote server, and might see that it
uses a slightly different request line.

## HTTPS with HTTP proxy

HTTPS was designed to allow and provide secure and safe end-to-end privacy
from the client to the server (and back). In order to provide that when
speaking to an HTTP proxy, the HTTP protocol has a special request that curl
uses to setup a tunnel through the proxy that it then can encrypt and
verify. This HTTP method is known as `CONNECT`.

When the proxy tunnels encrypted data through to the remote server after a
CONNECT method sets it up, the proxy cannot see nor modify the traffic without
breaking the encryption:

    curl -x proxy.example.com:80 https://example.com/

## Non-HTTP protocols over an HTTP proxy

An HTTP proxy means the proxy itself speaks HTTP. HTTP proxies are primarily
used to proxy HTTP but it is also fairly common that they support
other protocols as well. In particular, FTP is fairly commonly supported.

When talking FTP over an HTTP proxy, it is usually done by more or less
pretending the other protocol works like HTTP and asking the proxy to get this
URL even if the URL is not using HTTP. This distinction is important because
it means that when sent over an HTTP proxy like this, curl does not really
speak FTP even though given an FTP URL; thus FTP-specific features do not
work:

    curl -x http://proxy.example.com:80 ftp://ftp.example.com/file.txt

What you can do instead then, is to tunnel through the HTTP proxy.

## HTTP proxy tunneling

Most HTTP proxies allow clients to tunnel through it to a server on the other
side. That is exactly what's done every time you use HTTPS through the HTTP
proxy.

You tunnel through an HTTP proxy with curl using `-p` or `--proxytunnel`.

When you do HTTPS through a proxy you normally connect through to the default
HTTPS remote TCP port number 443. Most HTTP proxies white list and allow
connections only to hosts on that port number and perhaps a few others. Most
proxies deny clients from connecting to just any random port (for reasons only
the proxy administrators know).

Still, assuming that the HTTP proxy allows it, you can ask it to tunnel
through to a remote server on any port number so you can do other protocols
normally even when tunneling. You can do FTP tunneling like this:

    curl -p -x http://proxy.example.com:80 ftp://ftp.example.com/file.txt

You can tell curl to use HTTP/1.0 in its CONNECT request issued to the HTTP
proxy by using `--proxy1.0 [proxy]` instead of `-x`.
