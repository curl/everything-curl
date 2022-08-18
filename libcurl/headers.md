# Header files

There is only ever one header your libcurl using application needs to include:

    #include <curl/curl.h>

That file in turn includes a few other public header files but you can pretend
they do not exist. (Historically speaking, we started out slightly different
but over time we have stabilized around this form of only using a single one
for includes.)

