# Get option information

libcurl offers an API, a set of functions really, that allow applications to
get information about all currently support *easy options*. It does not return
*the values* for the options, but it rather informs about name, ID and type of
the option.

## Iterate over all options

Modern libcurl supports over 300 different options. With the use of
`curl_easy_option_by_next()` an application can iterate over all the known
options and return a pointer to a `struct curl_easyoption` for them.

This function only returns information about options that this exact libcurl
build knows about. Other options may exist in newer libcurl builds, or in
builds that enable/disable options differently at build-time.

Example, iterate over all available options:

    const struct curl_easyoption *opt;
    opt = curl_easy_option_by_next(NULL);
    while(opt) {
      printf("Name: %s\n", opt->name);
      opt = curl_easy_option_by_next(opt);
    }

## Find a specific option by name

Given a specific easy option name, you can ask libcurl to return a pointer to
a `struct curl_easyoption` for it. The name should be provided without the
`CURLOPT_` prefix.

As an example, an application can ask libcurl about the `CURLOPT_VERBOSE`
option like this:

    const struct curl_easyoption *opt = curl_easy_option_by_name("VERBOSE");
    if(opt) {
      printf("This option wants CURLoption %x\n", (int)opt->id);
    }

## Find a specific option by ID

Given a specific easy option ID, you can ask libcurl to return a pointer to a
`struct curl_easyoption` for it. The "ID" is the `CURLOPT_`-prefixed symbol as
provided in the public `curl/curl.h` header file.

An application can ask libcurl for the name of the `CURLOPT_VERBOSE` option
like this:

    const struct curl_easyoption *opt =
      curl_easy_option_by_id(CURLOPT_VERBOSE);
    if(opt) {
      printf("This option has the name: %s\n", opt->name);
    }

## The `curl_easyoption` struct

    struct curl_easyoption {
      const char *name;
      CURLoption id;
      curl_easytype type;
      unsigned int flags;
    };

There is only one bit with a defined meaning in 'flags': if
`CURLOT_FLAG_ALIAS` is set, it means that that option is an "alias". A name
provided for backwards compatibility that is nowadays rather served by an
option with another name. If you lookup the ID for an alias, you get the new
canonical name for that option.
