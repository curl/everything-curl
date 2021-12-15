### Convert to and from network callbacks

For non-ASCII platforms, `CURLOPT_CONV_FROM_NETWORK_FUNCTION` is
provided. This function should convert **to** host encoding **from** the
network encoding.

`CURLOPT_CONV_TO_NETWORK_FUNCTION` should convert from **host** encoding
**to** the network encoding. It is used when commands or ASCII data are sent
over the network.

### Convert from UTF-8 callback

`CURLOPT_CONV_FROM_UTF8_FUNCTION` should convert to host encoding from UTF-8
encoding. It is required only for SSL processing.
