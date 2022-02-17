# Windows vs Unix

There are a few differences in how to program curl the Unix way compared to
the Windows way. Perhaps the four most notable details are:

## Different function names for socket operations

  In curl, this is solved with defines and macros, so that the source looks
  the same in all places except for the header file that defines them. The
  macros in use are `sclose()`, `sread()` and `swrite()`.

## Init calls

  Windows requires a couple of init calls for the socket stuff.

  That is taken care of by the `curl_global_init()` call, but if other libs
  also do it etc there might be reasons for applications to alter that
  behavior.

  We require WinSock version 2.2 and load this version during global init.

## File descriptors

  File descriptors for network communication and file operations are not as
  easily interchangeable as in Unix.

  We avoid this by not trying any funny tricks on file descriptors.

## Stdout

  When writing data to stdout, Windows makes end-of-lines the DOS way, thus
  destroying binary data, although you do want that conversion if it is text
  coming through... (sigh)

  We set stdout to binary under windows

## Ifdefs

Inside the source code, We make an effort to avoid `#ifdef [Your OS]`. All
conditionals that deal with features *should* instead be in the format
`#ifdef HAVE_THAT_WEIRD_FUNCTION`. Since Windows cannot run configure scripts,
we maintain a `curl_config-win32.h` file in the lib directory that is supposed
to look exactly like a `curl_config.h` file would have looked like on a
Windows machine.

Generally speaking: curl is frequently compiled on several dozens of operating
systems. Do not walk on the edge.
