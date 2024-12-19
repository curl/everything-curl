# VLAN

With the `--vlan-priority` command line option you set a priority value betwen
0 and 7 that is set in the Ethernet header. It is thus limited to your local
network only and will not be used across any routers.

VLAN priority as defined in IEEE 802.1Q.

Example:

    curl --vlan-priority 4 https://example.com
