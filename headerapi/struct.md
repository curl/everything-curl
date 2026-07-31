# Header struct

The header struct pointer the header API functions return, points to memory
associated with the easy handle and subsequent calls to the functions clobber
that struct. Applications need to copy the data if they want to keep it
around. The memory used for the struct gets freed with calling
`curl_easy_cleanup()`.

## The struct

    struct curl_header {
       char *name;
       char *value;
       size_t amount;
       size_t index;
       unsigned int origin;
       void *anchor;
    };

**name** is the name of header. It uses the casing used for the first instance
of the header with this name.

**value** is the content. It comes exactly as delivered over the network but
with leading and trailing whitespace and newlines stripped off. The data is
always null-terminated.

**amount** is the number of headers using this name that exist, within the
asked origin and request context.

**index** is the zero based entry number of this particular header name, which
in case this header was used more than once in the requested scope can be
larger than 0 but is always less than **amount**.

**origin** has (exactly) one of the origin bits set, indicating where from the
header originates.

**anchor** is a private handle used by libcurl internals. Do not modify. Do
not assume anything about it.
