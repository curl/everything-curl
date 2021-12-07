# Shell redirects

When you invoke curl from a shell or some other command-line prompt system,
that environment generally provides you with a set of output redirection
abilities. In most Linux and Unix shells and with Windows' command prompts,
you direct stdout to a file with `> filename`. Using this, of course, makes the
use of -o or -O superfluous.

    curl http://example.com/ > example.html

Redirecting output to a file redirects all output from curl to that file, so
even if you ask to transfer more than one URL to stdout, redirecting the output
will get all the URLs' output stored in that single file.

    curl http://example.com/1 http://example.com/2 > files

Unix shells usually allow you to redirect the *stderr* stream separately. The
stderr stream is usually a stream that also gets shown in the terminal, but you
can redirect it separately from the stdout stream. The stdout stream is for
the data while stderr is metadata and errors, etc., that are not data. You can
redirect stderr with `2>file` like this:

    curl http://example.com > files.html 2>errors
