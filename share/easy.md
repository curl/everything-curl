# Sharing between easy handles

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
