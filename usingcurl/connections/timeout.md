# Connection timeout

curl typically makes a TCP connection to the host as an initial part of its
network transfer. This TCP connection can fail or be slow, if there are shaky
network conditions or faulty remote servers.

To reduce the impact on your scripts or other use, you can set the maximum
time in seconds which curl allows for the connection attempt. With
`--connect-timeout` you tell curl the maximum time to allow for connecting,
and if curl has not connected in that time it returns a failure.

The connection timeout only limits the time curl is allowed to spend up until
the moment it connects, so once the TCP connection has been established it can
take longer time. See the [Timeouts](../timeouts.md) section for more on
generic curl timeouts.

If you specify a low timeout, you effectively disable curl's ability to
connect to remote servers, slow servers or servers you access over unreliable
networks.

The connection timeout can be specified as a decimal value for sub-second
precision. For example, to allow 2781 milliseconds to connect:

    curl --connect-timeout 2.781 https://example.com/

