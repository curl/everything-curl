# Performance

This section collects general advice on what you can do as an application
author to get the maximum performance out of libcurl.

libcurl is designed and intended to run as fast as possible by default. You
are expected to get top performance already without doing anything extra in
particular. There are however some common things to look at or perhaps
mistakes to avoid.

## reuse handles

This is a general mantra whenever libcurl is discussed. If you use the easy
interface, the *primary* key to high performance is to reuse the handles when
doing subsequent transfers. That lets libcurl reuse connections, reuse TLS
sessions, use its DNS cache as much as possible and more.

## buffer sizes

If you download data, set the `CURLOPT_BUFFERSIZE` to a suitable size. It is
on the smaller size from start and especially on high speed transfers, you
might be able to get more out of libcurl by increase its size. We encourage
you to try out a few sizes in a benchmark with your use case.

Similarly, if you upload data you might want to adjust the
`CURLOPT_UPLOAD_BUFFERSIZE` for the same reasons.

## pool size

The number of live connections kept in the connection pool that you set with
`CURLOPT_MAXCONNECTS` can be interesting to tweak. Depending of course how
your application uses connections, but if it for example iterates over N
hostnames in a short period of time, it could make sense for you to make sure
that libcurl can keep all those connections alive.

## make callbacks as fast as possible

In high speed data downloads, the write callback is called many times. If this
function is not written to execute the fastest possible way, there is a risk
that this function alone makes *all* transfers slower than they otherwise
could be.

The same of course goes for the read callback for uploads.

Avoid doing complicated logic or use locks/mutexes in your libcurl callbacks.

## share data

If you use multiple easy handles, you can still share data and caches between
them in order to increase performance. Take a closer look at
[the share API](../helpers/sharing.md).

## threads

If your transfer thread ends up consuming 100% CPU, then you might benefit
from distributing the load onto multiple threads to increase bandwidth.

Normally then, you want to make each thread do transfers as independently as
possible to avoid them interfering with each other's performance or risk
getting into thread-safe problems due to shared handles. Try to make the same
hostnames get transferred on the same thread so that connection reuse can be
optimized.

## `curl_multi_socket_action`

If your application performs many parallel transfers, like more than a hundred
concurrent ones or so, then you *must* consider switching to the
`curl_multi_socket_action()` and the event based API instead of the "regular"
multi API. That allows and pushes you to use an event based approach which
lets your application avoid both `poll()` and `select()`, which is key to high
performance combined with a high degree of parallelism.
