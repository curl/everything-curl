# Timeouts

Network operations are by their nature rather unreliable or perhaps fragile
operations as they depend on a set of services and networks to be up and
working for things to work. The availability of these services can come and go
and the performance of them may also vary greatly from time to time.

The design of TCP even allows the network to get completely disconnected for
an extended period of time without it necessarily getting noticed by the
participants in the transfer.

The result of this is that sometimes Internet transfers take a long
time. Further, most operations in curl have no time-out by default.

## Maximum time allowed to spend

Tell curl with `-m / --max-time` the maximum time, in seconds, that you allow
the command line to spend before curl exits with a timeout error code
(28). When the set time has elapsed, curl exits no matter what is going on at
that moment—including if it is transferring data. It really is the maximum
time allowed.

The given maximum time can be specified with a decimal precision; `0.5` means
500 milliseconds and `2.37` equals 2370 milliseconds.

Example:

    curl --max-time 5.5 https://example.com/

(Your locale may use another symbol than a dot for expressing numerical
fractions.)

## Never spend more than this to connect

`--connect-timeout` limits the time curl spends trying to connect to the
host. All the necessary steps done before the connection is considered
complete have to be completed within the given time frame. Failing to connect
within the given time causes curl to exit with a timeout exit code (28).

The steps done before a connect is considered successful include DNS lookup
and subsequent TCP, TLS or QUIC handshakes.

The given maximum connect time can be specified with a decimal precision;
`0.5` means 500 milliseconds and `2.37` equals 2370 milliseconds:

    curl --connect-timeout 2.37 https://example.com/
