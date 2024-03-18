# Stop

An Internet transfer might be brief but can also take a long time. Maybe even
an infinite amount of time.

libcurl normally performs transfers until they are complete or until an error
occurs. If none of those events happen, the transfer continues.

At times, you might want to stop a libcurl transfer before it would otherwise
stop.

## easy API

As explained elsewhere, the `curl_easy_perform()` function is a synchronous
function call. It does the entire transfer before it returns.

There are a few different ways to stop a transfer before it would otherwise
end:

1. return an error from a callback
2. set an option that makes the transfer stop after a fixed period of time

Every [callback](../callbacks/) can return an error, and when an error is
returned from one of those functions the entire transfer is stopped. For
example the read, write or progress callbacks.

The second way is to set a timeout or other option that stops the transfer
after a time or at a particular condition. For example one or more of the
following:

1. `CURLOPT_TIMEOUT` - set a maximum time the entire transfer may take
2. `CURLOPT_CONNECTTIMEOUT` - set a maximum time "connection phase" may take
3. `CURLOPT_LOW_SPEED_LIMIT` - set the lowest acceptable transfer speed. The
   transfer stops if slower than this speed for `CURLOPT_LOW_SPEED_TIME`
   number of second.

There is no provided function that allows your application to stop an ongoing
`curl_easy_perform()` call from another thread. The common suggestion is then
that you signal that intent in a private way that you can detect in a callback
and have that callback return error when it happens.

## multi API

The multi interface is generally a non-blocking API, so in most situations you
can stop a transfer by removing its corresponding easy handle from the multi
handle using `curl_multi_remove_handle()`.

When you use the multi API, you might call libcurl to wait for activities or
traffic on sockets libcurl works with. A call that might sit blocking while
waiting for something to happen (or a timeout to expire), like
`curl_multi_poll()`.

An application can make a blocked call to `curl_multi_poll()` wake up and
return forcibly and immediately by calling `curl_multi_wakeup()` from another
thread.
