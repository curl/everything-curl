# IPFS

IPFS is the *Inter-Planetary File System*. curl supports IPFS only via an
*HTTP gateway*. It means that it understands IPFS URLs when given to it, but
you must also provide a working gateway URL for curl to use to retrieve the
content. curl does not speak IPFS natively.

## Gateway

The `--ipfs-gateway` lets the user specify the IPFS HTTP gateway URL. Like this:

    curl --ipfs-gateway http://localhost:8080 ipfs://bafybeigagd5nmnn2iys2f3d/

If you opt to go for a remote gateway you should be aware that you completely
trust the gateway. This is fine in local gateways as you host it yourself.
With remote gateways there could potentially be a malicious actor returning
you data that does not match the request you made, inspect or even interfere
with the request. You might not notice this when getting IPFS using curl.

If the `--ipfs-gateway` option is not used, curl checks the `IPFS_GATEWAY`
environment variable for guidance and if not set, the `~/.ipfs/gateway` file
that can be used to identify the gateway.

IPFS support was first added to curl in version 8.4.0.
