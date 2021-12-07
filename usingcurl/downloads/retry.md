# Retrying failed attempts

Normally curl will only make a single attempt to perform a transfer and return
an error if not successful. Using the `--retry` option you can tell curl to
retry certain failed transfers.

If a transient error is returned when curl tries to perform a transfer, it
will retry this number of times before giving up. Setting the number to 0
makes curl do no retries (which is the default). Transient error means
either: a timeout, an FTP 4xx response code or an HTTP 5xx response code.

## Tweak your retries

When curl is about to retry a transfer, it will first wait one second and then
for all forthcoming retries it will double the waiting time until it reaches
10 minutes which then will be the delay between the rest of the retries. Using
`--retry-delay` you can disable this exponential backoff algorithm and set
your own delay between the attempts. With `--retry-max-time` you cap the total
time allowed for retries. The `--max-time` option will still specify the
longest time a single of these transfers is allowed to spend.

## Retry even more

TBD
