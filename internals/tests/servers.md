# Test servers

A large portion of the curl test suite actually runs curl command lines that
interact with servers that are started on the local machine for testing
purposes only during the test, and that are shut down again at the end of the
test round.

The test servers are custom servers written for this purpose that speak HTTP,
FTP, IMAP, POP3, SMTP, TFTP, MQTT, SOCKS proxies and more.

All test servers are controlled via the test file: which servers that each
test case needs to have running to work, what they should return and how they
are supposed to act for each test.

The test servers typically log their actions in dedicated files in
`tests/log`, and they can be useful to check out if your test does not act the
way you want.
