# Share data between handles

Sometimes applications need to share data between transfers. All easy handles
added to the same multi handle automatically get a lot of sharing done between
the handles in that same multi handle, but sometimes that is not exactly what
you want.

## Multi handle

All easy handles added to the same multi handle automatically share
[connection cache](../transfers/conn/reuse.md) and
[dns cache](../transfers/conn/names.md).

## Sharing between easy handles

libcurl has a generic "sharing interface", where the application creates a
"share object" that then holds data that can be shared by any number of easy
handles. The data is then stored and read from the shared object instead of
kept within the handles that are sharing it.

    CURLSH *share = curl_share_init();

The shared object can be set to share all or any of cookies, connection cache,
dns cache and SSL session id cache.

For example, setting up the share to hold cookies and dns cache:

    curl_share_setopt(share, CURLSHOPT_SHARE, CURL_LOCK_DATA_COOKIE);
    curl_share_setopt(share, CURLSHOPT_SHARE, CURL_LOCK_DATA_DNS);

You then set up the corresponding transfer to use this share object:

    curl_easy_setopt(curl, CURLOPT_SHARE, share);

Transfers done with this `curl` handle uses and stores its cookie and dns
information in the `share` handle. You can set several easy handles to share
the same share object.

## What to share

`CURL_LOCK_DATA_COOKIE` - set this bit to share cookie jar. Note that each
easy handle still needs to get its cookie "engine" started properly to start
using cookies.

`CURL_LOCK_DATA_DNS` - the DNS cache is where libcurl stores addresses for
resolved hostnames for a while to make subsequent lookups faster.

`CURL_LOCK_DATA_SSL_SESSION` - the SSL session ID cache is where libcurl store
resume information for SSL connections to be able to resume a previous
connection faster.

`CURL_LOCK_DATA_CONNECT` - when set, this handle uses a shared connection
cache and thus is more likely to find existing connections to re-use etc,
which may result in faster performance when doing multiple transfers to the
same host in a serial manner.

## Locking

If you want have the share object shared by transfers in a multi-threaded
environment. Perhaps you have a CPU with many cores and you want each core to
run its own thread and transfer data, but you still want the different
transfers to share data. Then you need to set the mutex callbacks.

If you do not use threading and you *know* you access the shared object in a
serial one-at-a-time manner you do not need to set any locks. But if there is
ever more than one transfer that access share object at a time, it needs to
get mutex callbacks setup to prevent data destruction and possibly even
crashes.

Since libcurl itself does not know how to lock things or even what threading
model you are using, you must make sure to do mutex locks that only allows one
access at a time. A lock callback for a pthreads-using application could look
similar to:

    static void lock_cb(CURL *handle, curl_lock_data data,
                        curl_lock_access access, void *userptr)
    {
      pthread_mutex_lock(&lock[data]); /* uses a global lock array */
    }
    curl_share_setopt(share, CURLSHOPT_LOCKFUNC, lock_cb);

With the corresponding unlock callback could look like:

    static void unlock_cb(CURL *handle, curl_lock_data data,
                          void *userptr)
    {
      pthread_mutex_unlock(&lock[data]); /* uses a global lock array */
    }
    curl_share_setopt(share, CURLSHOPT_UNLOCKFUNC, unlock_cb);

## Unshare

A transfer uses the share object during its transfer and share what that
object has been specified to share with other handles sharing the same object.

In a subsequent transfer, `CURLOPT_SHARE` can be set to NULL to prevent a
transfer from continuing to share. It that case, the handle may start the next
transfer with empty caches for the data that was previously shared.

Between two transfers, a share object can also get updated to share a
different set of properties so that the handles that share that object shares
a different set of data next time. You remove an item to share from a shared
object with the curl_share_setopt()'s `CURLSHOPT_UNSHARE` option like this
when unsharing DNS data:

    curl_share_setopt(share, CURLSHOPT_UNSHARE, CURL_LOCK_DATA_DNS);
