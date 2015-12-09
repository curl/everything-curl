## Header files

There is ever only one header your libcurl using application needs to include:

    #include <curl/curl.h>

That file in turn includes a few other public header files but you can
basically pretend they don't exist. (Historically speaking, we started out
slightly different but over time we've stabilized around this form of only
using a single one for includes.)

