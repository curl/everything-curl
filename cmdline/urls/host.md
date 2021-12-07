# Host

The host name part of the URL is, of course, simply a name that can be resolved
to an numerical IP address, or the numerical address itself.

    curl http://example.com

When specifying a numerical address, use the dotted version for IPv4
addresses:

    curl http://127.0.0.1/

…and for IPv6 addresses the numerical version needs to be within square
brackets:

    curl http://[::1]/

When a host name is used, the converting of the name to an IP address is
typically done using the system's resolver functions. That normally lets a
sysadmin provide local name lookups in the `/etc/hosts` file (or equivalent).
