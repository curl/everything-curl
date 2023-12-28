# Maximum filesize

When you want to make sure your curl command line does not download a
too-large file, instruct curl to stop before doing that, if it knows the size
before the transfer starts! Maybe that would use too much bandwidth, take too
long time or you do not have enough space on your hard drive:

    curl --max-filesize 100000 https://example.com/

Give curl the largest download you can accept in number of bytes and if curl
can figure out the size before the transfer starts it aborts before trying to
download something larger.

There are many situations in which curl cannot figure out the size at the time
the transfer starts. Such transfers thus are then aborted first when they
actually reach that limit.
