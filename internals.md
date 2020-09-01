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
   be used for this and nothing else should use this name.

 - `conn` is the variable name we use all over the internals to refer to the
   current *connection* the code works on (`struct connectdata`). A transfer
   typically uses a connection at some point and typically only one at a
   time. There's a `conn->data` pointer that identifies the transfer that is
   currently working on this connection. A single connection can be reused
   over time by several transfers (and thus easy handles) and a single
   connection can also be used by several easy handles simultaneously when
   multiplexed connections are used. When muliplexing are used, the
   `conn->data` pointer has to be updated accordingly quite frequently.

 - `result` is the usual name we use for a `CURLcode` variable to hold the
   return values from functions and if that return value is different than
   zero, it is an error and the function should clean up and return
   (usually passing on the same error code to its parent function).

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

## Different protocols "hooked in"

libcurl is a multi-protocol transfer library. The core of the code is a set of
generic functions that are used for transfers in general and will mostly work
the same for all protocols. The main state machine described above for example
is there and works for all protocols - even though some protocols may not make
use of all states for all transfers.

However, each different protocol libcurl speaks also has its unique
particularities and specialties. In order to not have the code littered with
conditions in the style "if the protocol is XYZ, then do...", we instead have
the concept of `Curl_handler`. Each supported protocol defines one of those in
`lib/url.c` there's an array of pointers to such handlers called
`protocols[]`.

When a transfer is about to be done, libcurl parses the URL it is about to
operate on and among other things it figures out what protocol to use.
Normally this can be done by looking at the scheme part of the URL. For
`https://example.com` that is `https` and for `imaps://example.com` it is
`imaps`. Using the provided scheme, libcurl sets the `conn->handler` pointer
to the handler struct for the protocol that handles this URL.

The handler struct contains a set of function pointers that can be NULL or set
to point to a protocol specific function to do things necessary for that
protocol to work for a transfer. Things that not all other protocols need. The
handler struct also sets up the name of the protocol and describes its feature
set with a bitmask.

A libcurl transfer is built around a set of different "actions" and the
handler can extend each of them. Here are some example function pointers in
this struct and how they are used:

### Setup connection

If a connection cannot be reused for a transfer, it needs to setup a connection
to the host given in the URL and when it does, it can also call the protocol
handler's function for it. Like this:

    if(conn->handler->setup_connection)
      result = conn->handler->setup_connection(conn);

### Connect

After a connection has been established, this function gets called

    if(conn->handler->connect_it)
      result = conn->handler->connect_it(conn, &done);

### Do

"Do" is simply the action that issues a request for the particular resource
the URL identifies. All protocol has a do action so this function must be
provided:

    result = conn->handler->do_it(conn, &done);

### Done

When a transfer is completed, the "done" action is taken:

    result = conn->handler->done(conn);

### Disconnect

The connection is about to be taken down.

    result = conn->handler->disconnect(conn, dead_connection);
