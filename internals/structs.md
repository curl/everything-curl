# Structs

This section documents internal structs. Since they are truly internal, we
change them occasionally which might make this section slightly out of date at
times.

## Curl_easy

  The `Curl_easy` struct is the one returned to the outside in the external
  API as an opaque `CURL *`. This pointer is usually known as an easy handle
  in API documentations and examples.

  Information and state that is related to the actual connection is in the
  `connectdata` struct. When a transfer is about to be made, libcurl either
  creates a new connection or re-uses an existing one. The current connectdata
  that is used by this handle is pointed out by `Curl_easy->conn`.

  Data and information that regard this particular single transfer is put in
  the `SingleRequest` sub-struct.

  When the `Curl_easy` struct is added to a multi handle, as it must be in
  order to do any transfer, the `->multi` member points to the `Curl_multi`
  struct it belongs to. The `->prev` and `->next` members are then used by the
  multi code to keep a linked list of `Curl_easy` structs that are added to
  that same multi handle. libcurl always uses multi so `->multi` points to a
  `Curl_multi` when a transfer is in progress.

  `->mstate` is the multi state of this particular `Curl_easy`. When
  `multi_runsingle()` is called, it acts on this handle according to which
  state it is in. The mstate is also what tells which sockets to return for a
  specific `Curl_easy` when [`curl_multi_fdset()`][12] is called etc.

  The libcurl source code generally use the name `data` everywhere for the
  local variable that points to the `Curl_easy` struct.

  When doing multiplexed HTTP/2 transfers, each `Curl_easy` is associated with
  an individual stream, sharing the same connectdata struct. Multiplexing
  makes it even more important to keep things associated with the right thing.

## connectdata

  A general idea in libcurl is to keep connections around in a connection
  cache after they have been used in case they are used again and then re-use
  an existing one instead of creating a new one as it creates a significant
  performance boost.

  Each `connectdata` struct identifies a single physical connection to a
  server. If the connection cannot be kept alive, the connection is closed
  after use and then this struct can be removed from the cache and freed.

  Thus, the same `Curl_easy` can be used multiple times and each time select
  another `connectdata` struct to use for the connection. Keep this in mind,
  as it is then important to consider if options or choices are based on the
  connection or the `Curl_easy`.

  As a special complexity, some protocols supported by libcurl require a
  special disconnect procedure that is more than just shutting down the
  socket. It can involve sending one or more commands to the server before
  doing so. Since connections are kept in the connection cache after use, the
  original `Curl_easy` may no longer be around when the time comes to shut
  down a particular connection. For this purpose, libcurl holds a special
  dummy `closure_handle` `Curl_easy` in the `Curl_multi` struct to use when
  needed.

  FTP uses two TCP connections for a typical transfer but it keeps both in
  this single struct and thus can be considered a single connection for most
  internal concerns.

  The libcurl source code generally uses the name `conn` for the local
  variable that points to the connectdata.

## Curl_multi

  Internally, the easy interface is implemented as a wrapper around multi
  interface functions. This makes everything multi interface.

  `Curl_multi` is the multi handle struct exposed as the opaque `CURLM *` in
  external APIs.

  This struct holds a list of `Curl_easy` structs that have been added to this
  handle with [`curl_multi_add_handle()`][13]. The start of the list is
  `->easyp` and `->num_easy` is a counter of added `Curl_easy`s.

  `->msglist` is a linked list of messages to send back when
  [`curl_multi_info_read()`][14] is called. Basically a node is added to that
  list when an individual `Curl_easy`'s transfer has completed.

  `->hostcache` points to the name cache. It is a hash table for looking up
  name to IP. The nodes have a limited lifetime in there and this cache is
  meant to reduce the time for when the same name is wanted within a short
  period of time.

  `->timetree` points to a tree of `Curl_easy`s, sorted by the remaining time
  until it should be checked - normally some sort of timeout. Each `Curl_easy`
  has one node in the tree.

  `->sockhash` is a hash table to allow fast lookups of socket descriptor for
  which `Curl_easy` uses that descriptor. This is necessary for the
  `multi_socket` API.

  `->conn_cache` points to the connection cache. It keeps track of all
  connections that are kept after use. The cache has a maximum size.

  `->closure_handle` is described in the `connectdata` section.

  The libcurl source code generally uses the name `multi` for the variable that
  points to the `Curl_multi` struct.

## Curl_handler

  Each unique protocol that is supported by libcurl needs to provide at least
  one `Curl_handler` struct. It defines what the protocol is called and what
  functions the main code should call to deal with protocol specific issues.
  In general, there is a source file named `[protocol].c` in which there is a
  `struct Curl_handler Curl_handler_[protocol]` declared. In `url.c` there is
  then the main array with all individual `Curl_handler` structs pointed to
  from a single array which is scanned through when a URL is given to libcurl
  to work with.

  The concrete function pointer prototypes can be found in `lib/urldata.h`.

  - `->scheme` is the URL scheme name, usually spelled out in uppercase. That
    is HTTP or FTP etc. SSL versions of the protocol need their own
    `Curl_handler` setup so HTTPS separate from HTTP.

  - `->setup_connection` is called to allow the protocol code to allocate
    protocol specific data that then gets associated with that `Curl_easy` for
    the rest of this transfer. It gets freed again at the end of the transfer.
    It gets called before the `connectdata` for the transfer has been
    selected/created. Most protocols allocate its private `struct [PROTOCOL]`
    here and assign `Curl_easy->req.p.[protocol]` to it.

  - `->connect_it` allows a protocol to do some specific actions after the TCP
    connect is done, that can still be considered part of the connection
    phase. Some protocols alter the `connectdata->recv[]` and
    `connectdata->send[]` function pointers in this function.

  - `->connecting` is similarly a function that keeps getting called as long
    as the protocol considers itself still in the connecting phase.

  - `->do_it` is the function called to issue the transfer request. What we
    call the DO action internally. If the DO is not enough and things need to
    be kept getting done for the entire DO sequence to complete, `->doing` is
    then usually also provided. Each protocol that needs to do multiple
    commands or similar for do/doing needs to implement their own state
    machines (see SCP, SFTP, FTP). Some protocols (only FTP and only due to
    historical reasons) have a separate piece of the DO state called
    `DO_MORE`.

  - `->doing` keeps getting called while issuing the transfer request
    command(s)

  - `->done` gets called when the transfer is complete and DONE. That is after
    the main data has been transferred.

  - `->do_more` gets called during the `DO_MORE` state. The FTP protocol uses
    this state when setting up the second connection.

  - `->proto_getsock`, `->doing_getsock`, `->domore_getsock`,
    `->perform_getsock` Functions that return socket information. Which
    socket(s) to wait for which I/O action(s) during the particular multi
    state.

  - `->disconnect` is called immediately before the TCP connection is
    shutdown.

  - `->readwrite` gets called during transfer to allow the protocol to do
    extra reads/writes

  - `->attach` attaches a transfer to the connection.

  - `->defport` is the default report TCP or UDP port this protocol uses

  - `->protocol` is one or more bits in the `CURLPROTO_*` set. The SSL
    versions have their base protocol set and then the SSL variation. Like
    `HTTP|HTTPS`.

  - `->flags` is a bitmask with additional information about the protocol that
    makes it get treated differently by the generic engine:
    - `PROTOPT_SSL` - makes it connect and negotiate SSL
    - `PROTOPT_DUAL` - this protocol uses two connections
    - `PROTOPT_CLOSEACTION` - this protocol has actions to do before closing
      the connection. This flag is no longer used by code, yet still set for a
      bunch of protocol handlers.
    - `PROTOPT_DIRLOCK` - direction lock. The SSH protocols set this bit to
      limit which direction of socket actions that the main engine concerns
      itself with.
    - `PROTOPT_NONETWORK` - a protocol that does not use the network (read
      `file:`)
    - `PROTOPT_NEEDSPWD` - this protocol needs a password and uses a default
      one unless one is provided
    - `PROTOPT_NOURLQUERY` - this protocol cannot handle a query part on the
      URL (?foo=bar)

## conncache

  Is a hash table with connections for later re-use. Each `Curl_easy` has a
  pointer to its connection cache. Each multi handle sets up a connection
  cache that all added `Curl_easy`s share by default.

## Curl_share

  The libcurl share API allocates a `Curl_share` struct, exposed to the
  external API as `CURLSH *`.

  The idea is that the struct can have a set of its own versions of caches and
  pools and then by providing this struct in the `CURLOPT_SHARE` option, those
  specific `Curl_easy`s use the caches/pools that this share handle holds.

  Then individual `Curl_easy` structs can be made to share specific things
  that they otherwise would not, such as cookies.

  The `Curl_share` struct can currently hold cookies, DNS cache and the SSL
  session cache.

## CookieInfo

  This is the main cookie struct. It holds all known cookies and related
  information. Each `Curl_easy` has its own private `CookieInfo` even when
  they are added to a multi handle. They can be made to share cookies by using
  the share API.
