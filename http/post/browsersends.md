# Figure out what a browser sends

A common shortcut is to simply fill in the form with your browser and submit
it and check in the browser's network development tools exactly what it sent.

A slightly different way is to save the HTML page containing the form, and
then edit that HTML page to redirect the 'action=' part of the form to your
own server or a test server that just outputs exactly what it gets. Completing
that form submission shows you exactly how a browser sends it.

A third option is, of course, to use a network capture tool such as Wireshark
to check exactly what is sent over the wire. If you are working with HTTPS,
you cannot see form submissions in clear text on the wire but instead you need
to make sure you can have Wireshark extract your TLS private key from your
browser. See the [SSLKEYLOGFILE section](../../usingcurl/tls/sslkeylogfile.md)
for details on doing that.

