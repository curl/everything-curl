# Captive portals

These are not proxies but they are blocking the way between you and the server
you want to access.

A captive portal is one of these systems that are popular to use in hotels,
airports and for other sorts of network access to a larger audience. The
portal captures all network traffic and redirects you to a login webpage
until you have either clicked OK and verified that you have read their
conditions or perhaps even made sure that you have paid plenty of money for
the right to use the network.

curl's traffic is of course also captured by such portals and often the best
way is to use a browser to accept the conditions and get rid of the portal
since from then on they often allow all other traffic originating from that
same machine (MAC address) for a period of time.

Most often you can use curl too to submit that affirmation, if you just figure
out how to submit the form and what fields to include in it. If this is
something you end up doing many times, it may be worth exploring.
