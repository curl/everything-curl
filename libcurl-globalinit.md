## Global initialization

Before you do anything libcurl related in your program, you should do a global
libcurl initialize call with `curl_global_init()`. This is necessary because
some underlying libraries that libcurl might be using need a call ahead to get
setup and inited properly.

curl_global_init() is unfortunately not thread safe so you must sure that you
only do it once and never simultaneously as another call. It initializes
global state so you should only call it once and once your program is
completely done using libcurl you can call `curl_global_cleanup()` to again
free and clean up the associated global resources the init call allocated.

libcurl is built to handle that you skip the `curl_global_init()` call, but it
does so by calling it itself instead if you didn't do it before any actual
file transfer starts and it then uses its own defaults. But beware that it is
still not thread safe even then so it might cause some "interesting" side
effects for you. It is much better to call curl_global_init() yourself in a
controlled manner.

