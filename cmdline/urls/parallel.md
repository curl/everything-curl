# Parallel transfers

The default behavior of getting the specified URLs one by one in a serial
fashion makes it easy to understand exactly when each URL is fetched but it
can be slow.

curl offers the `-Z` (or `--parallel`) option that instead instructs curl to
attempt to do the specified transfers in a parallel fashion. When this is
enabled, curl performs a lot of transfers simultaneously instead of
serially. It does up to 50 transfers at the same time by default and as soon
as one of them completes, the next one is kicked off.

For cases where you want to download many files from different sources and a
few of them might be slow, a few fast, this can speed things up tremendously.

If 50 parallel transfers is wrong for you, the `--parallel-max` option is there
to allow you to change that amount.

## Parallel transfer progress meter

Naturally, the ordinary progress meter display that shows file transfer
progress for a single transfer is not that useful for parallel transfers so
when curl performs parallel transfers, it shows a different progress meter
that displays information about all the current ongoing transfers in a single
line.

## Connection before multiplex

When curl is asked to do parallel transfers, it prioritizes having the
additional transfer reuse and multiplexing happen over pre-existing
connections. This can potentially lower the total amount of connections (and
thereby resources) necessary, but it might be slightly slower at start-up.

With `--parallel-immediate`, curl is instructed to reverse the prioritization
and instead prefer creating a new connection immediately rather than risk
waiting a little to see if the transfer can be multiplexed on another
connection.
