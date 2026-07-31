# Unshare

A transfer uses the share object during its transfer and shares what that
object has been specified to share with other handles sharing the same object.

In a subsequent transfer, `CURLOPT_SHARE` can be set to NULL to prevent a
transfer from continuing to share. In that case, the handle may start the next
transfer with empty caches for the data that was previously shared.

Between two transfers, a share object can also get updated to share a
different set of properties so that the handles that share that object share
a different set of data next time. You remove an item to share from a shared
object with the curl_share_setopt()'s `CURLSHOPT_UNSHARE` option like this
when unsharing DNS data:

    curl_share_setopt(share, CURLSHOPT_UNSHARE, CURL_LOCK_DATA_DNS);
