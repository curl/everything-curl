## Callbacks

Lots of operations within libcurl are controlled with the use of *callbacks*.
A callback is a function pointer provided to libcurl that libcurl then calls
at some point to get a particular job done.

Each callback has its specific documented purpose and it requires that you
write it with the exact function prototype to accept the correct arguments and
return the documented return code and return value so that libcurl will
perform the way you want it to.

Each callback option also has a companion option that sets the associated
"user pointer". This user pointer is a pointer that libcurl does not touch or
care about, but just passes on as an argument to the callback. This allows you
to, for example, pass in pointers to local data all the way through to your
callback function.

Unless explicitly stated in a libcurl function documentation, it is not
legal to invoke libcurl functions from within a libcurl callback.

 * [Write data](callbacks/write.md)
 * [Read data](callbacks/read.md)
 * [Progress information](callbacks/progress.md)
 * [Header data](callbacks/header.md)
 * [Debug](callbacks/debug.md)
 * [sockopt](callbacks/sockopt.md)
 * [SSL context](callbacks/sslcontext.md)
 * [Seek and ioctl](callbacks/seek.md)
 * [Network data conversion](callbacks/conversions.md)
 * [Opensocket and closesocket](callbacks/openclosesocket.md)
 * [SSH key](callbacks/sshkey.md)
 * [RTSP interleaved data](callbacks/rtsp.md)
 * [FTP wildcard matching](callbacks/ftpmatch.md)
 * [Resolver start](callbacks/resolver.md)
 * [Sending trailers](callbacks/trailers.md)
 * [HSTS](callbacks/hsts.md)
 * [Prereq](callbacks/prereq.md)
