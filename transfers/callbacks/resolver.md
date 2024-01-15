# Resolver start

This callback function, set with `CURLOPT_RESOLVER_START_FUNCTION` gets called
by libcurl every time before a new resolve request is started, and it
specifies for which `CURL *` handle the resolve is intended.
