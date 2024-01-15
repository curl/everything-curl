# How libcurl connects

When libcurl is about to do an Internet transfer, it first *resolves* the host
name to get a number of IP addresses for the host. A hostname needs to have
at least one address for libcurl to be able to connect to it.

A hostname can have both IPv4 addresses and IPv6 addresses and they can have
a set of both.

If the host only returned addresses of a single IP family, libcurl iterates
over each address and tries to connect. If the connect attempt fails for an
IP, libcurl continues to try the next entry until the entire list is
exhausted.

An application can limit which IP versions libcurl uses by setting
`CURLOPT_IPRESOLVE`.

## Happy Eyeballs

When it has received both IPv4 and IPv6 addresses for a host, libcurl first
tries to connect to an IPv6 address and after a short delay it tries
connecting to the first IPv4 address - at the same time and in parallel. Once
one of the attempts succeeds, the others are discarded. This method of
attempting to connect using both families at the same time is called **Happy
Eyeballs** and is the widely accepted best practice for Internet clients.

An application can set the delay with which the second family connect attempt
starts in the Happy Eyeball procedure by using
`CURLOPT_HAPPY_EYEBALLS_TIMEOUT_MS`.

## Timeout and halving

The connection phase has a maximum allowed time (set with
`CURLOPT_CONNECTTIMEOUT_MS`), which defaults to 300 seconds. The entire
connect procedure is deemed failed if no connect has succeeded within that
time.

When libcurl has multiple addresses left to try to connect to, and there is
more than 600 millisecond left, it will at most allow half the remaining time
for this attempt. This is to avoid a single sink-hole address make libcurl
spend its entire timeout on that bad entry.

For example: if there are 1000 milliseconds left of the timeout and there are
two IP addresses left to try to connect to, libcurl then only allows 500
milliseconds on the next attempt.

If there instead only are 600 milliseconds left of the timeout and there are
two IP addresses left to try to connect to, libcurl allows the entire
remaining timeout period on the next attempt, in order to not make it too
short to succeed. The timeout halving approach is only done as long as there
is more than 600 milliseconds remaining.

## HTTP/3

For applications that ask libcurl to use HTTP/3, it adds another layer of
Happy Eyeballs. HTTP/3 works over QUIC and QUIC is a different transport
protocol than TCP and a mechanism that sometimes is blocked or otherwise does
not work as well as TCP. In an effort to smooth out the problems this brings,
libcurl performs QUIC connects *in parallel* with regular TCP connects in
addition to the different IP version connects described above.

When libcurl get both IPv4 and IPv6 addresses for a host, and it wants to do
HTTP/3 with the host, it proceeds like this:

1. Start an IPv6 QUIC connect attempt, iterate over the IPv6 addresses
2. After a short delay, start an IPv4 QUIC connect attempt, iterate over the IPv4 addresses
3. After a short delay, start an IPv6 TCP connect attempt, iterate over the IPv6 addresses
4. After a short delay, start an IPv4 TCP connect attempt, iterate over the IPv4 addresses

Once a connect attempt is successful, all the other ones are immediately
discarded.

The HTTP/3 happy eyeballing is done when libcurl is asked to use
`CURL_HTTP_VERSION_3` but not if set to `CURL_HTTP_VERSION_3ONLY`.
