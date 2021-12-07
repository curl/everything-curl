# PAC

Some network environments provides several different proxies that should be
used in different situations, and a customizable way to handle that is
supported by the browsers. This is called "[proxy auto-config](https://en.wikipedia.org/wiki/Proxy_auto-config)", or PAC.

A PAC file contains a JavaScript function that decides which proxy a given
network connection (URL) should use, and even if it should not use a proxy at
all. Browsers most typically read the PAC file off a URL on the local network.

Since curl has no JavaScript capabilities, curl does not support PAC files. If
your browser and network use PAC files, the easiest route forward is usually
to read the PAC file manually and figure out the proxy you need to specify to
run curl successfully.
