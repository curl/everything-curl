# Connection control

When doing a transfer with libcurl there is typically a *connection*
involved. A connection done using an Internet transport protocol like TCP or
QUIC. Transfers are done *over* connections and libcurl offers a lot of
concepts for connections and options to control how it works with them.

  * [How libcurl connects](conn/how.md)
  * [Connection reuse](conn/reuse.md)
  * [Name resolving](conn/names.md)
  * [Proxies](conn/proxies.md)
