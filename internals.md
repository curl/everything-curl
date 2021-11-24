# libcurl internals

libcurl is never finished and is not just an off-the-shelf product. It is a
living project that is improved and modified on almost a daily basis. We
depend on skilled and interested hackers to fix bugs and to add features.

This chapter is meant to describe internal details to aid keen libcurl hackers
to learn some basic concepts on how libcurl works internally and thus possibly
where to look for problems or where to add things when you want to make the
library do something new.

## Easy handle and connections

When reading the source code there are some useful basics that are good to
know and keep in mind:

 - 'data' is the variable name we use all over to refer to the easy handle
   (`struct Curl_easy`) for the transfer being worked on. No other name should
   be used for this and nothing else should use this name. The easy handle is
   the main object identifying a transfer. A transfer typically uses a
   connection at some point and typically only one at a time. There's a
   `data->conn` pointer that identifies the connection that is currently used
   by this transfer. A single connection can be used over time and even
   concorrently by several transfers (and thus easy handles) when multiplexed
   connections are used.

 - `conn` is the variable name we use all over the internals to refer to the
   current *connection* the code works on (`struct connectdata`).

 - `result` is the usual name we use for a `CURLcode` variable to hold the
   return values from functions and if that return value is different than
   zero, it is an error and the function should clean up and return (usually
   passing on the same error code to its parent function).

## Everything is multi

libcurl offers a few different APIs to do transfers; where the primary
differences are the synchronous easy interface versus the non-blocking multi
interface. The multi interface itself can then be further used either by using
the event-driven socket interface or the "normal" perform interface.

Internally however, everything is written for the event-driven interface.
Everything needs to be written in non-blocking fashion so that functions are
never waiting for data in loop or similar. Unless they are the "surface"
functions that have that expressed functionality.

The function `curl_easy_perform()` which performs a single transfer
synchronously, is itself just a wrapper function that internally will setup
and use the multi interface itself.

## Everything is state machines

To facilitate that non-blocking nature, the curl source is full of state
machines. Work on as much data as there is and drive the state machine to
where it can go based on what's available and allow the functions to continue
from that point later on when more data arrives that then might drive the
state machine further.

There are such states in many different levels for a given transfer and the
code for each particular protocol may have its own set of state machines.

One of the primary states is the main transfer "mode" the easy handle holds,
which says if the current transfer is resolving, waiting for a resolve,
connecting, waiting for a connect, issuing a request, doing a transfer etc
(see the `CURLMstate` enum in `lib/multihandle.h`). Every transfer done with
libcurl has an associated easy handle and every easy handle will exercise that
state machine.
