# Name resolving

Most transfers libcurl can do involves a name that first needs to be
translated to an Internet address. That is name resolving. Using a numerical
IP address directly in the URL usually avoids the name resolve phase, but in
many cases it is not easy to manually replace the name with the IP address.

libcurl tries hard to [re-use an existing connection](reuse.md) rather than to
create a new one. The function that checks for an existing connection to use
is based purely on the name and is performed before any name resolving is
attempted. That is one of the reasons the re-use is so much faster. A transfer
using a reused connection does not resolve the hostname again.

If no connection can be reused, libcurl resolves the hostname to the set of
addresses it resolves to. Typically this means asking for both IPv4 and IPv6
addresses and there may be a whole set of those returned to libcurl. That set
of addresses is then tried until one works, or it returns failure.

An application can force libcurl to use only an IPv4 or IPv6 resolved address
by setting `CURLOPT_IPRESOLVE` to the preferred value. For example, ask to
only use IPv6 addresses:

    curl_easy_setopt(easy, CURLOPT_IPRESOLVE, CURL_IPRESOLVE_V6);

## Name resolver backends

libcurl can be built to do name resolves in one out of these three different
ways and depending on which backend way that is used, it gets a slightly
different feature set and sometimes modified behavior.

1. The default backend is invoking the normal libc resolver functions in a new
helper-thread, so that it can still do fine-grained timeouts if wanted and
there is no blocking calls involved.

2. On older systems, libcurl uses the standard synchronous name resolver
functions. They unfortunately make all transfers within a multi handle block
during its operation and it is much harder to time out nicely.

3. There is also support for resolving with the c-ares third party library,
which supports asynchronous name resolving without the use of threads. This
scales better to huge number of parallel transfers but it is not always 100%
compatible with the native name resolver functionality.

### DNS over HTTPS

Independently of what resolver backend that libcurl is built to use, since
7.62.0 it also provides a way for the user to ask a specific DoH (DNS over
HTTPS) server for the address of a name. This avoids using the normal, native
resolver method and server and instead asks a dedicated separate one.

A DoH server is specified as a full URL with the `CURLOPT_DOH_URL` option like
this:

    curl_easy_setopt(easy, CURLOPT_DOH_URL, "https://example.com/doh");

The URL passed to this option *must* be using https:// and it is generally
recommended that you have HTTP/2 support enabled so that libcurl can perform
multiple DoH requests multiplexed over the connection to the DoH server.

## Caching

When a name has been resolved, the result is stored in libcurl's in-memory
cache so that subsequent resolves of the same name are instant for as long the
name is kept in the DNS cache. By default, each entry is kept in the cache for
60 seconds, but that value can be changed with `CURLOPT_DNS_CACHE_TIMEOUT`.

The DNS cache is kept within the easy handle when `curl_easy_perform` is used,
or within the multi handle when the multi interface is used. It can also be
made shared between multiple easy handles using the
[share interface](../../helpers/sharing.md).

## Custom addresses for hosts

Sometimes it is handy to provide fake, custom addresses for real hostnames so
that libcurl connects to a different address instead of one an actual name
resolve would suggest.

With the help of the
[CURLOPT_RESOLVE](https://curl.se/libcurl/c/CURLOPT_RESOLVE.html) option,
an application can pre-populate libcurl's DNS cache with a custom address for
a given hostname and port number.

To make libcurl connect to 127.0.0.1 when example.com on port 443 is
requested, an application can do:

    struct curl_slist *dns;
    dns = curl_slist_append(NULL, "example.com:443:127.0.0.1");
    curl_easy_setopt(curl, CURLOPT_RESOLVE, dns);

Since this puts the fake address into the DNS cache, it works even when
following redirects etc.

## Name server options

For libcurl built to use c-ares, there is a few options available that offer
fine-grained control of what DNS servers to use and how. This is limited to
c-ares build purely because these are powers that are not available when the
standard system calls for name resolving are used.

 - With `CURLOPT_DNS_SERVERS`, the application can select to use a set of
   dedicated DNS servers.

 - With `CURLOPT_DNS_INTERFACE` it can tell libcurl which network interface to speak
   DNS over instead of the default one.

 - With `CURLOPT_DNS_LOCAL_IP4` and `CURLOPT_DNS_LOCAL_IP6`, the application
   can specify which specific network addresses to bind DNS resolves to.

## No global DNS cache

The option called `CURLOPT_DNS_USE_GLOBAL_CACHE` once told curl to use a
global DNS cache. This functionality has been removed since 7.65.0, so while
this option still exists it does nothing.
