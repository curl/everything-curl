# Cookie engine

The general concept of curl only doing the bare minimum unless you tell it
differently makes it not acknowledge cookies by default. You need to switch on
the cookie engine to make curl keep track of cookies it receives and then
subsequently send them out on requests that have matching cookies.

You enable the cookie engine by asking curl to read or write cookies. If you
tell curl to read cookies from blank named file, you only switch on the engine
but start off with an empty internal cookie store:

    curl -b "" http://example.com

Just switching on the cookie engine, getting a single resource and then
quitting would be pointless as curl would have no chance to actually send any
cookies it received. Assuming the site in this example would set cookies and
then do a redirect we would do:

    curl -L -b "" http://example.com

