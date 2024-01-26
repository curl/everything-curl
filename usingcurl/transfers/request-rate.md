# Request rate limiting

When told to do multiple transfers in a single command line, there might be
times when a user would rather have those multiple transfers done
slower than as fast as possible. We call that *request rate limiting*.

With the `--rate` option, you specify the maximum transfer frequency you allow
curl to use - in number of transfer starts per time unit (sometimes called
request rate). Without this option, curl starts the next transfer as fast as
possible.

If given several URLs and a transfer completes faster than the allowed rate,
curl delays starting the next transfer to maintain the requested rate. This
option is for serial transfers and has no effect when
[--parallel](../../cmdline/urls/parallel.md) is used.

The request rate is provided as **N/U** where N is an integer number and U is
a time unit. Supported units are `s` (second), `m` (minute), `h` (hour) and
`d` (day, as in a 24 hour unit). The default time unit, if no **/U** is
provided, is number of transfers per hour.

If curl is told to allow 10 requests per minute, it does not start the next
request until 6 seconds have elapsed since the previous transfer was started.

This function uses millisecond resolution. If the allowed frequency is set
more than 1000 per second, it instead runs unrestricted.

When retrying transfers, enabled with [--retry](../downloads/retry.md), the
separate retry delay logic is used and not this setting.

If this option is used several times, the last one is used.

For example, make curl download 100 images but doing it no faster than 2
transfers per second:

    curl --rate 2/s -O https://example.com/[1-100].jpg
    
Make curl download 10 images but doing it no faster than 3 transfers per hour:
  
    curl --rate 3/h -O https://example.com/[1-10].jpg

Make curl download 200 images but not faster than 14 transfers per minute:

    curl --rate 14/m -O https://example.com/[1-200].jpg
