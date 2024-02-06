# Resolving hostnames

 Aka `hostip.c` explained

 The main compile-time defines to keep in mind when reading the `host*.c`
 source file are these:

## `CURLRES_IPV6`

 this host has `getaddrinfo()` and family, and thus we use that. The host may
 not be able to resolve IPv6, but we do not really have to take that into
 account. Hosts that are not IPv6-enabled have `CURLRES_IPV4` defined.

## `CURLRES_ARES`

 is defined if libcurl is built to use c-ares for asynchronous name
 resolves. This can be Windows or \*nix.

## `CURLRES_THREADED`

 is defined if libcurl is built to use threading for asynchronous name
 resolves. The name resolve is done in a new thread, and the supported asynch
 API is be the same as for ares-builds. This is the default under (native)
 Windows.

 If any of the two previous are defined, `CURLRES_ASYNCH` is defined too. If
 libcurl is not built to use an asynchronous resolver, `CURLRES_SYNCH` is
 defined.

## `host*.c` sources

 The `host*.c` sources files are split up like this:

 - `hostip.c`      - method-independent resolver functions and utility functions
 - `hostasyn.c`    - functions for asynchronous name resolves
 - `hostsyn.c`     - functions for synchronous name resolves
 - `asyn-ares.c`   - functions for asynchronous name resolves using c-ares
 - `asyn-thread.c` - functions for asynchronous name resolves using threads
 - `hostip4.c`     - IPv4 specific functions
 - `hostip6.c`     - IPv6 specific functions

 The `hostip.h` is the single united header file for all this. It defines the
 `CURLRES_*` defines based on the `config*.h` and `curl_setup.h` defines.
