# Keep alive

Once a TCP connection has been established, that connection is defined to be
valid until one side closes it. Once the connection has entered the connected
state, it will remain connected indefinitely. In reality, the connection will
not last indefinitely. Many firewalls or NAT systems close connections if
there has been no activity in some time period. The Keep Alive signal can be
used to refrain intermediate hosts from closing idle connection due to
inactivity.

libcurl offers several options to enable and control TCP Keep alive for
connections it creates. There is one main boolean option to switch the feature
on/off, and there are *three* separate options for the counters and timeouts
involved.

It can be noted that while this method tries to defeat middle boxes closing
down idle connections, there are also such boxes that plain simply ignore keep
alive probes. There are no guarantees that this actually works.

## Enable keep alive

Set the `CURLOPT_TCP_KEEPALIVE` long to 1 to enable, 0 to disable. If enabled,
libcurl will set TCP Keep Alive options on any new TCP connection it creates
using this handle. If it creates connections using other protocols, like UDP
or QUIC, those connections will not be affected.

## Idle time

You set the `CURLOPT_TCP_KEEPIDLE` long to the number of seconds you want the
connection to be idle before sending the first keep alive probe. The default
value is 60 seconds. It makes sense to try to set this to a time slightly
lower than the time limit in your strictest middle box.

## Probe interval

Set `CURLOPT_TCP_KEEPINTVL` to a long for the number of seconds to wait
between subsequent keep alive probes. The probes that follow once the first
keep alive probe has been sent. Default is 60 seconds.

## Probe count

Sometimes referred as keep alive retry. Set `CURLOPT_TCP_KEEPCNT` to a long
holding the number of retransmissions to be carried out before declaring that
remote end is not available and closing the connection. Default is 9. This
libcurl option was added in 8.9.0, long after the previous options.

## Example

A tiny example of libcurl application doing a transfer using TCP keep alive.

    int main(void)
    {
      CURL *curl = curl_easy_init();
      if(curl) {
        curl_easy_setopt(curl, CURLOPT_URL, "https://example.com");

        /* enable TCP keep-alive for this transfer */
        curl_easy_setopt(curl, CURLOPT_TCP_KEEPALIVE, 1L);

        /* keep-alive idle time to 120 seconds */
        curl_easy_setopt(curl, CURLOPT_TCP_KEEPIDLE, 120L);

        /* interval time between keep-alive probes: 60 seconds */
        curl_easy_setopt(curl, CURLOPT_TCP_KEEPINTVL, 60L);

        /* maximum number of keep-alive probes: 3 */
        curl_easy_setopt(curl, CURLOPT_TCP_KEEPCNT, 3L);

        curl_easy_perform(curl);
      }
    }

## HTTP `Keep-Alive`

There was this old keyword called `Keep-Alive` used for HTTP/1.0 in the
`Connection:` header. It has an entirely separate functionality and is not
related to TCP Keep Alive: it meant that the connection should be kept alive
for persistent use in subsequent transfers. That became default for HTTP in
1.1.

## QUIC and HTTP/2

Both QUIC and HTTP/2 have PING frames that can be sent between two peers
involved in the communication that then have similar effects as TCP Keep
Alive. These options do however not control libcurl's use of PING frames.
