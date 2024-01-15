# Callbacks

Lots of operations within libcurl are controlled with the use of *callbacks*.
A callback is a function pointer provided to libcurl that libcurl then calls
at some point to get a particular job done.

Each callback has its specific documented purpose and it requires that you
write it with the exact function prototype to accept the correct arguments and
return the documented return code and return value so that libcurl performs
the way you want it to.

Each callback option also has a companion option that sets the associated user
pointer. This user pointer is a pointer that libcurl does not touch or care
about, but just passes on as an argument to the callback. This allows you to,
for example, pass in pointers to local data all the way through to your
callback function.

Unless explicitly stated in a libcurl function documentation, it is not
legal to invoke libcurl functions from within a libcurl callback.

 * [Write data](write.md)
 * [Read data](read.md)
 * [Progress information](progress.md)
 * [Header data](header.md)
 * [Debug](debug.md)
 * [sockopt](sockopt.md)
 * [SSL context](sslcontext.md)
 * [Seek and ioctl](seek.md)
 * [Network data conversion](conversions.md)
 * [Opensocket and closesocket](openclosesocket.md)
 * [SSH key](sshkey.md)
 * [RTSP interleaved data](rtsp.md)
 * [FTP wildcard matching](ftpmatch.md)
 * [Resolver start](resolver.md)
 * [Sending trailers](trailers.md)
 * [HSTS](hsts.md)
 * [Prereq](prereq.md)
