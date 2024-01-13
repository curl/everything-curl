# Opensocket and closesocket

Occasionally you end up in a situation where you want your application to
control with more precision exactly what socket libcurl uses for its
operations. libcurl offers this pair of callbacks that replaces libcurl's own
call to `socket()` and the subsequent `close()` of the same file descriptor.

## Provide a file descriptor

By setting the `CURLOPT_OPENSOCKETFUNCTION` callback, you can provide a custom
function to return a file descriptor for libcurl to use:

    curl_easy_setopt(handle, CURLOPT_OPENSOCKETFUNCTION, opensocket_callback);

The `opensocket_callback` function must match this prototype:

    curl_socket_t opensocket_callback(void *clientp,
                                      curlsocktype purpose,
                                      struct curl_sockaddr *address);

The callback gets the *clientp* as first argument, which is simply an opaque
pointer you set with `CURLOPT_OPENSOCKETDATA`.

The other two arguments pass in data that identifies for what *purpose* and
*address* the socket is to be used. The *purpose* is a typedef with a value of
`CURLSOCKTYPE_IPCXN` or `CURLSOCKTYPE_ACCEPT`, identifying in which
circumstance the socket is created. The "accept" case being when libcurl is
used to accept an incoming FTP connection for when FTP active mode is used,
and all other cases when libcurl creates a socket for its own outgoing
connections the *IPCXN* value is passed in.

The *address* pointer points to a `struct curl_sockaddr` that describes the IP
address of the network destination for which this socket is created. Your
callback can for example use this information to whitelist or blacklist
specific addresses or address ranges.

The socketopen callback is also explicitly allowed to modify the target
address in that struct, if you would like to offer some sort of network filter
or translation layer.

The callback should return a file descriptor or `CURL_SOCKET_BAD`, which then
causes an unrecoverable error within libcurl and it returns
`CURLE_COULDNT_CONNECT` from its perform function.

If you want to return a file descriptor that is *already connected* to a
server, then you must also set the [sockopt callback](sockopt.md) and
make sure that returns the correct return value.

The `curl_sockaddress` struct looks like this:

    struct curl_sockaddr {
      int family;
      int socktype;
      int protocol;
      unsigned int addrlen;
      struct sockaddr addr;
    };

## Socket close callback

The corresponding callback to the open socket is of course the close
socket. Usually when you provide a custom way to provide a file descriptor you
want to provide your own cleanup version as well:

    curl_easy_setopt(handle, CURLOPT_CLOSESOCKETFUNCTION,
                     closesocket_callback);

The `closesocket_callback` function must match this prototype:

    int closesocket_callback(void *clientp, curl_socket_t item);
