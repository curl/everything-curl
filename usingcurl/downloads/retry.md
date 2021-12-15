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

Make curl retry up to 5 times, but no less than two minutes:

    curl --retry 5 --retry-max-time 120 https://example.com

## Connection refused

The default retry mechanism only retries transfers for what are considered
transient errors. Those are errors that the server itself hints and qualifies
as being there right now but that might be gone at a later time.

Sometimes you as a user know more about the situation and you can then help
out curl to do better retries. For starters, you can tell curl to consider
"connection refused" to be a transient error. Maybe you know that the server
you communicate with is a flaky one or maybe you know that you sometimes try
to download from it when it reboots or similar. You use `--retry-connrefused`
for this.

For example: retry up to 5 times and consider `ECONNREFUSED` a reason for
retry:

    curl --retry 5 --retry-connrefused https://example.com

## Retry on any and all errors

The most aggressive form of retry is for the cases where you **know** that the
URL is supposed to work and you will not tolerate any failures. Using
`--retry-all-errors` makes curl treat all transfers failures as reason for
retry.

For example: retry up to 12 times for all errors:

    curl --retry 12 --retry-all-errors https://example.com

