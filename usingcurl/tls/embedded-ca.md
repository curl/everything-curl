# Built-in certificate store

Historically, curl relies on an external file (usually named `cacert.pem` or
`curl-ca-bundle.crt`) or the system's native certificate store to verify the
identity of TLS servers. Using a built-in bundle, curl can get built as a
truly self-contained binary without any requirement on an external certificate
store.

The `--dump-ca-embed` option, introduced in **curl 8.10.0**, is a diagnostic
and utility option used to output the Certificate Authority (CA) bundle that
has been built into the curl executable.

## Why use it?

The primary purpose of this feature is to simplify deployments in environments
where you cannot guarantee the presence of a system CA store, such as minimal
Docker containers, embedded systems, or "portable" versions of curl that
need to work across different machines without external dependencies. By using
`--dump-ca-embed`, you can verify exactly which certificates your specific
version of curl is trusting or extract that bundle for use with other tools.

## See what is built-in

To use it, simply call curl with the flag. By default, it prints the entire
PEM-formatted CA bundle to your terminal's standard output (stdout):

    curl --dump-ca-embed

If you want to save this embedded bundle to a file for later use (perhaps to
pass to another tool using its own `--cacert` equivalent), redirect the
output:

    curl --dump-ca-embed > embedded-certs.pem

## Considerations

* **Build-Time Requirement**: This option only works if the curl binary was
  specifically compiled with the embedding feature enabled (using the
  `--with-ca-embed` build flag). If your version of curl was not built this
  way, the command typically produces no output or return an error.

* **Checking Support**: You can check if your curl build supports this by
  running `curl -V`. Look for `CAembed` in the list of features.

* **Time sensitive**: While embedding certificates makes the binary more
  portable, it also means the certificates are "frozen" at the time of the
  build. To update the set of certificates for trusted certificate
  authorities, you would typically need to replace the entire curl binary or
  override the embedded bundle using the standard `--cacert` or `--ca-native`
  options.
