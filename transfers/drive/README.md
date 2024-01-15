# Drive transfers

libcurl provides three different ways to perform the transfer. Which way to
use in your case is entirely up to you and what you need.

1. The 'easy' interface lets you do a single transfer in a synchronous
fashion. libcurl does the entire transfer and return control back to your
application when it is completed—successful or failed.

2. The 'multi' interface is for when you want to do more than one transfer at
the same time, or you just want a non-blocking transfer.

3. The 'multi_socket' interface is a slight variation of the regular multi
one, but is event-based and is really the suggested API to use if you intend
to scale up the number of simultaneous transfers to hundreds or thousands
or so.

Let's look at each one a little closer…

* [Drive with easy](easy.md)
* [Drive with multi](multi.md)
* [Drive with multi\_socket](multi-socket.md)
