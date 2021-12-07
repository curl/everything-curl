# Rate limiting

When curl transfers data, it will attempt to do that as fast as possible. It
goes for both uploads and downloads. Exactly how fast that will be depends on
several factors, including your computer's ability, your own network
connection's bandwidth, the load on the remote server you are transferring
to/from and the latency to that server. And your curl transfers are also
likely to compete with other transfers on the networks the data travels
over, from other users or just other apps by the same user.

In many setups, however, you will find that you can more or less saturate your
own network connection with a single curl command line. If you have a 10
megabit per second connection to the Internet, chances are curl can use all of
those 10 megabits to transfer data.

For most use cases, using as much bandwidth as possible is a good thing. It
makes the transfer faster, it makes the curl command complete sooner and it
will make the transfer use resources from the server for a shorter period
of time.

Sometimes you will, however, find that having curl starve out other
network functions on your local network connection is inconvenient. In these
situations you may want to tell curl to slow down so that other network users
get a better chance to get their data through as well. With `--limit-rate
[speed]` you can tell curl to not go faster than the given number of bytes per
second. The rate limit value can be given with a letter suffix using one of K,
M and G for kilobytes, megabytes and gigabytes.

To make curl not download data any faster than 200 kilobytes per second:

    curl https://example.com/ --limit-rate 200K

The given limit is the maximum *average speed* allowed, counted during the
entire transfer. It means that curl might use higher transfer speeds in short
bursts, but over time it uses no more than the given rate.

Also note that curl never knows what the maximum possible speed is—it will
simply go as fast as it can and is allowed. You may know your connection's
maximum speed, but curl does not.
