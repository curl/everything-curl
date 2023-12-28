# Timeouts

All internals need to be written non-blocking and cannot just hang around and
wait for things to occur. At the same time, the multi interface allows users
to call libcurl to perform virtually at any time, even if no action has
happened or a timeout has triggered.

## Exposes just a single timeout to apps

In the external API libcurl provides a single timeout at a time, no matter how
many concurrent transfers and what options are set. An application can get the
timeout value it with `curl_multi_timeout()` or in a `CURLMOPT_TIMERFUNCTION`
callback, depending on what API it wants to use.

Internally, this is done like this:

- Every easy handle keeps an array of timeouts, in a sorted order. The closest
  (next-timeout) in time is first in the list.
- All easy handles are put in a *splay tree* which is binary self-balancing
  search tree that makes it fast to insert and remove nodes depending on their
  timeouts.
- As soon as any handle's next-timeout changes, the splay tree is re-balanced.

Extracting the easy handles with expired timeouts is a quick operation.

## Set a timeout

The internal function for *setting* a timeout is called `Curl_expire()`. It
asks that libcurl gets called again for this handle in a certain amount of
milliseconds into the future. A timeout is set with a specific ID, to make
sure that it overrides previous values set for the same timeout etc. The
existing timeout IDs are limited and the set is hard-coded.

A timeout can be removed again with `Curl_expire_clear()`, which then removes
that timeout from the list of timeouts for the given easy handle.

## Expired timeouts

Expiration of a timeout means that the application knows that it needs to call
libcurl again. When the *socket_action* API is used, it even knows to call
libcurl again for a specific given easy handle for which the timeout has
expired.

There is no other special action or activity happening when a timeout expires
than that the perform function is called. Each state or internal function
needs to know what times or states to check for and act accordingly when
called (again).
