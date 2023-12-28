# SSL context

libcurl offers a special TLS related callback called
`CURLOPT_SSL_CTX_FUNCTION`. This option only works for libcurl powered by
OpenSSL, wolfSSL or mbedTLS and it does nothing if libcurl is built with
another TLS backend.

This callback gets called by libcurl just before the initialization of a TLS
connection after having processed all other TLS related options to give a last
chance to an application to modify the behavior of the TLS initialization. The
`ssl_ctx parameter` passed to the callback in the second argument is actually
a pointer to the SSL library's `SSL_CTX` for OpenSSL or wolfSSL, and a pointer
to `mbedtls_ssl_config` for mbedTLS. If an error is returned from the callback
no attempt to establish a connection is made and the operation returns the
callback's error code. Set the `userptr` argument with the
`CURLOPT_SSL_CTX_DATA` option.

This function gets called on all new connections made to a server, during the
TLS negotiation. The TLS context points to a newly initialized object each
time.
