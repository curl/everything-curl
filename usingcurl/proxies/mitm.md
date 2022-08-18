# MITM proxy

MITM means Man-In-The-Middle. MITM proxies are usually deployed by companies
in "enterprise environments" and elsewhere, where the owners of the network
have a desire to investigate even TLS encrypted traffic.

To do this, they require users to install a custom "trust root" (Certificate
Authority (CA) certificate) in the client, and then the proxy terminates all
TLS traffic from the client, impersonates the remote server and acts like a
proxy. The proxy then sends back a generated certificate signed by the custom
CA. Such proxy setups usually transparently capture all traffic from clients
to TCP port 443 on a remote machine. Running curl in such a network would also
get its HTTPS traffic captured.

This practice, of course, allows the middle man to decrypt and snoop on
all TLS traffic.
