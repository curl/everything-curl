# MQTT

A plain GET subscribes to the topic and prints all published messages.
Doing a POST publishes the post data to the topic and exits.

Subscribe to the temperature in the `home/bedroom` subject published by
example.com:

    curl mqtt://example.com/home/bedroom/temp

Send the value `75` to the `home/bedroom/dimmer` subject hosted by the
example.com server:

    curl -d 75 mqtt://example.com/home/bedroom/dimmer

## What does curl deliver as a response to a subscribe

It outputs two bytes topic length (MSB | LSB), the topic followed by the
payload.

## Caveats

Remaining limitations in curl's MQTT support as of September 2022:

 - Only QoS level 0 is implemented for publish
 - No way to set retain flag for publish
 - No TLS (mqtts) support
