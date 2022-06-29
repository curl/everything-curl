# Stop slow transfers

Having a fixed maximum time for a curl operation can be cumbersome, especially
if you, for example, do scripted transfers and the file sizes and transfer
times vary a lot. A fixed timeout value then needs to be set unnecessarily
high to cover for worst cases.

As an alternative to a fixed time-out, you can tell curl to abandon the
transfer if it gets below a certain speed and stays below that threshold for a
specific period of time.

For example, if a transfer speed goes below 1000 bytes per second during 15
seconds, stop it:

    curl --speed-time 15 --speed-limit 1000 https://example.com/

