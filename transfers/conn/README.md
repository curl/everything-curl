# Connection control

When doing a transfer with libcurl there is typically a *connection*
involved. A connection done using an Internet transport protocol like TCP or
QUIC. Transfers are done *over* connections and libcurl offers a lot of
concepts for connections and options to control how it works with them.

  * [How libcurl connects](how.md)
  * [Local address and port number](local.md)
  * [Connection reuse](reuse.md)
  * [Name resolving](names.md)
  * [Proxies](proxies.md)
