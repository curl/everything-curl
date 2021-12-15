# Everything is state machines

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
