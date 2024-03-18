# libcurl internals

libcurl is never finished and is not just an off-the-shelf product. It is a
living project that is improved and modified on almost a daily basis. We
depend on skilled and interested hackers to fix bugs and to add features.

This chapter is meant to describe internal details to aid keen libcurl hackers
to learn some basic concepts on how libcurl works internally and thus possibly
where to look for problems or where to add things when you want to make the
library do something new.

 * [Easy handles and connections](easy.md)
 * [Everything is multi](multi.md)
 * [State machines](statemachines.md)
 * [Protocol handler](handler.md)
 * [Backends](backends.md)
 * [Caches and state](caches.md)
 * [Timeouts](timeouts.md)
 * [Windows vs Unix](windows-vs-unix.md)
 * [Memory debugging](memory-debugging.md)
 * [Content Encoding](content-encoding.md)
 * [Structs](structs.md)
 * [Resolving host names](resolving.md)
 * [Tests](tests/)
