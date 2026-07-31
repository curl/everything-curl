# What to share

`CURL_LOCK_DATA_COOKIE` - set this bit to share cookie jar. Note that each
easy handle still needs to get its cookie "engine" started properly to start
using cookies. It is not supported to use this option with multiple concurrent
threads.

`CURL_LOCK_DATA_DNS` - the DNS cache is where libcurl stores addresses for
resolved hostnames for a while to make subsequent lookups faster.

`CURL_LOCK_DATA_SSL_SESSION` - the SSL session ID cache is where libcurl stores
resume information for SSL connections to be able to resume a previous
connection faster.

`CURL_LOCK_DATA_CONNECT` - when set, this handle uses a shared connection
cache and thus is more likely to find existing connections to re-use etc,
which may result in faster performance when doing multiple transfers to the
same host in a serial manner. It is not supported to use this option with
multiple concurrent threads.

`CURL_LOCK_DATA_PSL` - this bit shares the Public Suffix List between handles.
The list of public suffixes, aka top-level Internet domains, is used to help
manage the security of cookies. Sharing the list prevents overhead from having
to process multiple copies of the list.

`CURL_LOCK_DATA_HSTS` - this bit shares the in-memory HSTS (HTTP Strict
Transport Security) cache. HSTS is used by websites to indicate that HTTP
requests should instead be accessed securely using HTTPS. It is not supported
to use this option with multiple concurrent threads.

