# API compatibility

libcurl promises API stability and guarantees that your program written today
remains working in the future. We do not break compatibility.

Over time, we add features, new options and new functions to the APIs but we
do not change behavior in a non-compatible way or remove functions.

The last time we changed the API in an non-compatible way was for 7.16.0 in
2006 and we plan to never do it again.

## Version numbers

Curl and libcurl are individually versioned, but they mostly follow each other
rather closely.

The version numbering is always built up using the same system:

    X.Y.Z

 - X is main version number
 - Y is release number
 - Z is patch number

## Bumping numbers

One of these X.Y.Z numbers gets bumped in every new release. The numbers to
the right of a bumped number are reset to zero.

The main version number X is bumped when *really* big, world colliding changes
are made. The release number Y is bumped when changes are performed or
things/features are added. The patch number Z is bumped when the changes are
mere bugfixes.

It means that after a release 1.2.3, we can release 2.0.0 if something really
big has been made, 1.3.0 if not that big changes were made or 1.2.4 if mostly
bugs were fixed.

Bumping, as in increasing the number with 1, is unconditionally only affecting
one of the numbers (and the ones to the right of it are set to zero). 1
becomes 2, 3 becomes 4, 9 becomes 10, 88 becomes 89 and 99 becomes 100. So,
after 1.2.9 comes 1.2.10. After 3.99.3, 3.100.0 might come.

All original curl source release archives are named according to the libcurl
version (not according to the curl client version that, as said before, might
differ).

## Which libcurl version

As a service to any application that might want to support new libcurl
features while still being able to build with older versions, all releases
have the libcurl version stored in the `curl/curlver.h` file using a static
numbering scheme that can be used for comparison. The version number is
defined as:

    #define LIBCURL_VERSION_NUM 0xXXYYZZ

Where `XX` , `YY` and `ZZ` are the main version, release and patch numbers in
hexadecimal. All three number fields are always represented using two digits
(eight bits each). 1.2.0 would appear as `0x010200` while version 9.11.7
appears as `0x090b07`.

This 6-digit hexadecimal number is always a greater number in a more recent
release. It makes comparisons with greater than and less than work.

This number is also available as three separate defines:
`LIBCURL_VERSION_MAJOR`, `LIBCURL_VERSION_MINOR` and `LIBCURL_VERSION_PATCH`.

These defines are, of course, only suitable to figure out the version number
built *just now* and do not help you figuring out which libcurl version that
is used at runtime three years from now.

## Which libcurl version runs

To figure out which libcurl version that your application is using *right
now*, `curl_version_info()` is there for you.

Applications should use this function to judge if things are possible to do or
not, instead of using compile-time checks, as dynamic/DLL libraries can be
changed independent of applications.

curl_version_info() returns a pointer to a struct with information about
version numbers and various features and in the running version of
libcurl. You call it by giving it a special age counter so that libcurl knows
the age of the libcurl that calls it. The age is a define called
`CURLVERSION_NOW` and is a counter that is increased at irregular intervals
throughout the curl development. The age number tells libcurl what struct set
it can return.

You call the function like this:

    curl_version_info_data *version = curl_version_info( CURLVERSION_NOW );

The data then points to struct that has or at least can have the following
layout:

    struct {
      CURLversion age;          /* see description below */

      /* when 'age' is 0 or higher, the members below also exist: */
      const char *version;      /* human readable string */
      unsigned int version_num; /* numeric representation */
      const char *host;         /* human readable string */
      int features;             /* bitmask, see below */
      char *ssl_version;        /* human readable string */
      long ssl_version_num;     /* not used, always zero */
      const char *libz_version; /* human readable string */
      const char * const *protocols; /* protocols */

      /* when 'age' is 1 or higher, the members below also exist: */
      const char *ares;         /* human readable string */
      int ares_num;             /* number */

      /* when 'age' is 2 or higher, the member below also exists: */
      const char *libidn;       /* human readable string */

      /* when 'age' is 3 or higher (7.16.1 or later), the members below also
         exist  */
      int iconv_ver_num;       /* '_libiconv_version' if iconv enabled */

      const char *libssh_version; /* human readable string */

      /* when 'age' is 4 or higher, the member below also exists: */
      unsigned int brotli_ver_num; /* Numeric Brotli version
                                      (MAJOR << 24) | (MINOR << 12) | PATCH */
      const char *brotli_version; /* human readable string. */

      /* when 'age' is 5 or higher, the member below also exists: */
      unsigned int nghttp2_ver_num; /* Numeric nghttp2 version
                                       (MAJOR << 16) | (MINOR << 8) | PATCH */
      const char *nghttp2_version; /* human readable string. */
      const char *quic_version;    /* human readable quic (+ HTTP/3) library +
                                      version or NULL */

      /* when 'age' is 6 or higher, the member below also exists: */
      const char *cainfo;          /* built-in default CURLOPT_CAINFO, might
                                      be NULL */
      const char *capath;          /* built-in default CURLOPT_CAPATH, might
                                      be NULL */

      /* when 'age' is 7 or higher, the member below also exists: */
      unsigned int zstd_ver_num; /* Numeric Zstd version
                                      (MAJOR << 24) | (MINOR << 12) | PATCH */
      const char *zstd_version; /* human readable string. */

      /* when 'age' is 8 or higher, the member below also exists: */
      const char *hyper_version; /* human readable string. */

    } curl_version_info_data;
