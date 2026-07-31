# Locking

If you want to have the share object shared by transfers in a multi-threaded
environment. Perhaps you have a CPU with many cores and you want each core to
run its own thread and transfer data, but you still want the different
transfers to share data. Then you need to set the mutex callbacks.

If you do not use threading and you *know* you access the shared object in a
serial one-at-a-time manner you do not need to set any locks. If there is ever
more than one transfer that access the share object at a time, it needs to get
mutex callbacks setup to prevent data destruction and possibly even crashes.

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
