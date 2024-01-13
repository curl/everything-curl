# Everything is multi

libcurl offers a few different APIs to do transfers; where the primary
differences are the synchronous easy interface versus the non-blocking multi
interface. The multi interface itself can then be further used either by using
the event-driven socket interface or the normal perform interface.

Internally however, everything is written for the event-driven interface.
Everything needs to be written in non-blocking fashion so that functions are
never waiting for data in loop or similar. Unless they are the surface
functions that have that expressed functionality.

The function `curl_easy_perform()` which performs a single transfer
synchronously, is itself just a wrapper function that internally setups and
uses the multi interface itself.
