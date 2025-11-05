# Writing cookies to file

The place where cookies are stored is sometimes referred to as the cookie
jar. When you enable the cookie engine in curl and it has received cookies,
you can instruct curl to write down all its known cookies to a file, the
cookie jar, before it exits. It is important to remember that curl only
updates the output cookie jar on exit and not during its lifetime, no matter
how long the handling of the given input takes.

You point out the cookie jar output with `-c`:

    curl -c cookie-jar.txt http://example.com

`-c` is the instruction to *write* cookies to a file, `-b` is the instruction
to *read* cookies from a file. Oftentimes you want both.

When curl writes cookies to this file, it saves all known cookies including
those that are session cookies (without a given lifetime). curl itself has no
notion of a session and it does not know when a session ends so it does not
flush session cookies unless you tell it to.
