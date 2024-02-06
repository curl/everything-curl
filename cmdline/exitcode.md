# Exit code

A lot of effort has gone into the project to make curl return a usable exit
code when something goes wrong and it always returns 0 (zero) when the
operation went as planned.

If you write a shell script or batch file that invokes curl, you can always
check the return code to detect problems in the invoked command. Below, you
find a list of return codes as of the time of this writing. Over time we tend
to slowly add new ones so if you get a code back not listed here, please refer
to more updated curl documentation for aid.

A basic Unix shell script could look like something like this:

    #!/bin/sh
    curl http://example.com
    res=$?
    if test "$res" != "0"; then
       echo "the curl command failed with: $res"
    fi

## Available exit codes

 1. Unsupported protocol. This build of curl has no support for this
  protocol. Usually this happens because the URL was misspelled to use a
  scheme part that either has a space in front of it or spells `http` like
  `htpt` or similar. Another common mistake is that you use a libcurl
  installation that was built with one or more protocols disabled and you
  now ask libcurl to use one of those protocols that were disabled in the
  build.

 2. Failed to initialize. This is mostly an internal error or a problem with
  the libcurl installation or system libcurl runs in.

 3. URL malformed. The syntax was not correct. This happens when you mistype a
  URL so that it ends up wrong, or in rare situations you are using a URL
  that is accepted by another tool that curl does not support only because
  there is no universal URL standard that everyone adheres to.

 4. A feature or option that was needed to perform the desired request was
  not enabled or was explicitly disabled at build-time. To make curl able
  to do this, you probably need another build of libcurl.

 5. Couldn't resolve proxy. The address of the given proxy host could not be
  resolved. Either the given proxy name is just wrong, or the DNS server is
  misbehaving and does not know about this name when it should or perhaps
  even the system you run curl on is misconfigured so that it does not
  find/use the correct DNS server.

 6. Couldn't resolve host. The given remote host's address was not
  resolved. The address of the given server could not be resolved. Either
  the given hostname is just wrong, or the DNS server is misbehaving and
  does not know about this name when it should or perhaps even the system you
  run curl on is misconfigured so that it does not find/use the correct DNS
  server.

 7. Failed to connect to host. curl managed to get an IP address to the
  machine and it tried to set up a TCP connection to the host but
  failed. This can be because you have specified the wrong port number,
  entered the wrong hostname, the wrong protocol or perhaps because there
  is a firewall or other network equipment in between that blocks the
  traffic from getting through.

 8. Unknown FTP server response. The server sent data curl could not
  parse. This is either because of a bug in curl, a bug in the server or
  because the server is using an FTP protocol extension that curl does not
  support. The only real work-around for this is to tweak curl options to try
  to get it to use other FTP commands that perhaps do not get this unknown
  server response back.

 9. FTP access denied. The server denied login or denied access to the
  particular resource or directory you wanted to reach. Most often you tried
  to change to a directory that does not exist on the server. The directory
  of course is what you specify in the URL.

 10. FTP accept failed. While waiting for the server to connect back when an
  active FTP session is used, an error code was sent over the control
  connection or similar.

 11. FTP weird PASS reply. Curl could not parse the reply sent to the PASS
  request. PASS in the command curl sends the password to the server with,
  and even anonymous connections to FTP server actually sends a password - a
  fixed anonymous string. Getting a response back from this command that
  curl does not understand is a strong indication that this is not an FTP
  server at all or that the server is badly broken.

 12. During an active FTP session (PORT is used) while waiting for the server
  to connect, the timeout expired. It took too long for the server to get
  back. This is usually a sign that something is preventing the server from
  reaching curl successfully, such as a firewall or other network
  arrangements.

 13. Unknown response to FTP PASV command. Curl could not parse the reply sent
  to the PASV request. This is a strange server. PASV is used to set up the
  second data transfer connection in passive mode, see the
  [FTP uses two connections](../ftp/twoconnections.md) section for more on
  that. You might be able to work-around this problem by using PORT instead,
  with the `--ftp-port` option.

 14. Unknown FTP 227 format. Curl could not parse the 227-line the server sent.
  This is most certainly a broken server. A 227 is the FTP server's response
  when sending back information on how curl should connect back to it in
  passive mode. You might be able to work-around this problem by using PORT
  instead, with the `--ftp-port` option.

 15. FTP cannot get host. Couldn't use the host IP address we got in the
  227-line. This is most likely an internal error.

 16. HTTP/2 error. A problem was detected in the HTTP2 framing layer. This is
  somewhat generic and can be one out of several problems, see the error
  message for details.

 17. FTP could not set binary. Couldn't change transfer method to binary. This
  server is broken. curl needs to set the transfer to the correct mode
  before it is started as otherwise the transfer cannot work.

 18. Partial file. Only a part of the file was transferred. When the transfer
  is considered complete, curl verifies that it actually received the same
  amount of data that it was told before-hand that it was going to get. If the
  two numbers do not match, this is the error code. It could mean that curl
  got fewer bytes than advertised or that it got more. curl itself cannot know
  which number is wrong or which is correct, if any.

 19. FTP could not download/access the given file. The RETR (or similar)
  command failed. curl got an error from the server when trying to download
  the file.

 20. **Not used**

 21. Quote error. A quote command returned an error from the server. curl
  allows several different ways to send custom commands to an IMAP, POP3,
  SMTP or FTP server and features a generic check that the commands
  work. When any of the individually issued commands fails, this is the exit
  status returned. The advice is generally to watch the headers in the
  FTP communication to better understand exactly what failed and how.

 22. HTTP page not retrieved. The requested URL was not found or returned
  another error with the HTTP error code being 400 or above. This return
  code only appears if `-f, --fail` is used.

 23. Write error. Curl could not write data to a local filesystem or
  similar. curl receives data chunk by chunk from the network and it stores
  it like at (or writes it to stdout), one piece at a time. If that write
  action gets an error, this is the exit status.

 24. **Not used**

 25. Upload failed. The server refused to accept or store the file that curl
  tried to send to it. This is usually due to wrong access rights on the
  server but can also happen due to out of disk space or other resource
  constraints. This error can happen for many protocols.

 26. Read error. Various reading problems. The inverse to exit status 23. When
  curl sends data to a server, it reads data chunk by chunk from a local file
  or stdin or similar, and if that reading fails in some way this is the exit
  status curl returns.

 27. Out of memory. A memory allocation request failed. curl needed to
  allocate more memory than what the system was willing to give it and curl
  had to exit. Try using smaller files or make sure that curl gets more
  memory to work with.

 28. Operation timeout. The specified time-out period was reached according to
  the conditions. curl offers several [timeouts](../usingcurl/timeouts.md),
  and this exit code tells one of those timeout limits were reached. Extend
  the timeout or try changing something else that allows curl to finish its
  operation faster. Often, this happens due to network and remote server
  situations that you cannot affect locally.

 29. **Not used**

 30. FTP PORT failed. The PORT command failed. Not all FTP servers support the
  PORT command; try doing a transfer using PASV instead. The PORT command is
  used to ask the server to create the data connection by *connecting back*
  to curl. See also the [FTP uses two connections](../ftp/twoconnections.md)
  section.

 31. FTP could not use REST. The REST command failed. This command is used for
  resumed FTP transfers. curl needs to issue the REST command to do range or
  resumed transfers. The server is broken, try the same operation without
  range/resume as a crude work-around.

 32. **Not used**

 33. HTTP range error. The range request did not work. Resumed HTTP requests
  are not necessarily acknowledged or supported, so this exit code signals that
  for this resource on this server, there can be no range or resumed
  transfers.

 34. HTTP post error. Internal post-request generation error. If you get this
  error, please report the exact circumstances to the curl project.

 35. A TLS/SSL connect error. The SSL handshake failed. The SSL handshake can
  fail due to numerous different reasons so the error message may offer some
  additional clues. Maybe the parties could not agree to a SSL/TLS
  version, an agreeable cipher suite or similar.

 36. Bad download resume. Could not continue an earlier aborted download. When
  asking to resume a transfer that then ends up not possible to do, this
  error can get returned. For FILE, FTP or SFTP.

 37. Couldn't read the given file when using the FILE:// scheme. Failed to
  open the file. The file could be non-existing or is it a permission
  problem perhaps?

 38. LDAP cannot bind. LDAP "bind" operation failed, which is a necessary step
  in the LDAP operation and thus this means the LDAP query could not be
  performed. This might happen because of a wrong username or password, or for
  other reasons.

 39. LDAP search failed. The given search terms caused the LDAP search to
  return an error.

 40. **Not used**

 41. **Not used**

 42. Aborted by callback. An application told libcurl to abort the
  operation. This error code is not generally made visible to users and not
  to users of the curl tool.

 43. Bad function argument. A function was called with a bad parameter - this
  return code is present to help application authors to understand why
  libcurl cannot perform certain actions and should never be returned by the
  curl tool. Please file a bug report to the curl project if this happens to
  you.

 44. **Not used**

 45. Interface error. A specified outgoing network interface could not be
  used. curl typically decides outgoing network and IP addresses by itself but
  when explicitly asked to use a specific one that curl cannot use, this error
  can occur.

 46. **Not used**

 47. Too many redirects. When following HTTP redirects, libcurl hit the
  maximum number set by the application. The maximum number of redirects is
  unlimited by libcurl but is set to 50 by default by the curl tool. The
  limit is present to stop endless redirect loops. Change the limit with
  `--max-redirs`.

 48. Unknown option specified to libcurl. This could happen if you use a curl
  version that is out of sync with the underlying libcurl version. Perhaps
  your newer curl tries to use an option in the older libcurl that was not
  introduced until after the libcurl version you are using but is known to
  your curl tool code as that is newer. To decrease the risk of this and
  make sure it does not happen: use curl and libcurl of the same version
  number.

 49. Malformed telnet option. The telnet option you provided to curl did not
  use the correct syntax.

 50. **Not used**

 51. The server's SSL/TLS certificate or SSH fingerprint failed verification.
  curl can then not be sure of the server being who it claims to be. See the
  [using TLS with curl](../usingcurl/tls.md) and
  [using SCP and SFTP with curl](../usingcurl/scpsftp.md) sections for more
  details.

 52. The server did not reply anything, which in this context is considered an
  error. When an HTTP(S) server responds to an HTTP(S) request, it always
  returns *something* as long as it is alive and sound. All valid HTTP
  responses have a status line and responses header. Not getting anything at
  all back is an indication the server is faulty or perhaps that something
  prevented curl from reaching the right server or that you are trying to
  connect to the wrong port number etc.

 53. SSL crypto engine not found.

 54. Cannot set SSL crypto engine as default.

 55. Failed sending network data. Sending data over the network is a crucial
  part of most curl operations and when curl gets an error from the lowest
  networking layers that the sending failed, this exit status gets
  returned. To pinpoint why this happens, some serious digging is usually
  required. Start with enabling verbose mode, do tracing and if possible check
  the network traffic with a tool like Wireshark or similar.

 56. Failure in receiving network data. Receiving data over the network is a
  crucial part of most curl operations and when curl gets an error from the
  lowest networking layers that the receiving of data failed, this exit
  status gets returned. To pinpoint why this happens, some serious digging
  is usually required. Start with enabling verbose mode, do tracing and if
  possible check the network traffic with a tool like Wireshark or similar.

 57. **Not used**

 58. Problem with the local certificate. The client certificate had a problem
  so it could not be used. Permissions? The wrong pass phrase?

 59. Couldn't use the specified SSL cipher. The cipher names need to be
  specified exactly and they are also unfortunately specific to the
  particular TLS backend curl has been built to use. For the current list
  of support ciphers and how to write them, see the online docs at
  [https://curl.se/docs/ssl-ciphers.html](https://curl.se/docs/ssl-ciphers.html).

 60. Peer certificate cannot be authenticated with known CA certificates. This
  usually means that the certificate is either self-signed or signed by a
  CA (Certificate Authority) that is not present in the CA store curl uses.

 61. Unrecognized transfer encoding. Content received from the server could
  not be parsed by curl.

 62. **Not used**

 63. Maximum file size exceeded. When curl has been told to restrict downloads
  to not do it if the file is too big, this is the exit code for that
  condition.

 64. Requested SSL (TLS) level failed. In most cases this means that curl
  failed to upgrade the connection to TLS when asked to.

 65. Sending the data requires a rewind that failed. In some situations curl
  needs to rewind in order to send the data again and if this cannot be done,
  the operation fails.

 66. Failed to initialize the OpenSSL SSL Engine. This can only happen when
  OpenSSL is used and would signify a serious internal problem.

 67. The username, password, or similar was not accepted and curl failed to
  log in. Verify that the credentials are provided correctly and that they are
  encoded the right way.

 68. File not found on TFTP server.

 69. Permission problem on TFTP server.

 70. Out of disk space on TFTP server.

 71. Illegal TFTP operation.

 72. Unknown TFTP transfer ID.

 73. File already exists (TFTP).

 74. No such user (TFTP).

 75. **Not used**

 76. **Not used**

 77. Problem with reading the SSL CA cert. The default or specified CA cert
  bundle could not be read/used to verify the server certificate.

 78. The resource (file) referenced in the URL does not exist.

 79. An unspecified error occurred during the SSH session. This sometimes
  indicates an incompatibility problem between the SSH libcurl curl uses and
  the SSH version used by the server curl speaks to.

 80. Failed to shut down the SSL connection.

 81. **Not used**

 82. Could not load CRL file, missing or wrong format

 83. TLS certificate issuer check failed. The most common reason for this is
  that the server did not send the proper intermediate certificate in the TLS
  handshake.

 84. The FTP `PRET` command failed. This is a non-standard command and far
  from all servers support it.

 85. RTSP: mismatch of CSeq numbers

 86. RTSP: mismatch of Session Identifiers

 87. Unable to parse FTP file list. The FTP directory listing format used by
  the server could not be parsed by curl. FTP wildcards can not be used on
  this server.

 88. FTP chunk callback reported error

 89. No connection available, the session is queued

 90. SSL public key does not match pinned public key. Either you provided
  a bad public key, or the server has changed.

 91. Invalid SSL certificate status. The server did not provide a proper
  valid certificate in the TLS handshake.

 92. Stream error in HTTP/2 framing layer. This is usually an unrecoverable
  error, but trying to force curl to speak HTTP/1 instead might circumvent it.

 93. An API function was called from inside a callback. If the curl tool
  returns this, something has gone wrong internally

 94. Authentication error.

 95. HTTP/3 layer error. This is somewhat generic and can be one out of
  several problems, see the error message for details.

 96. QUIC connection error. This error may be caused by an TLS library
  error. QUIC is the transport protocol used for HTTP/3.

 97. Proxy handshake error. Usually that means that a SOCKS proxy did not play
  along.

 98. A TLS client certificate is required but was not provided.

 99. An internal call to poll() or select() returned error that is not
  recoverable.

## Error message

When curl exits with a non-zero code, it also outputs an error message (unless
`--silent` is used). That error message may add some additional information or
circumstances to the exit status number itself so the same error number can
get different error messages.

Users can also craft their own error messages with
[--write-out](../usingcurl/verbose/writeout.md). The pseudo variable
`%{onerror}` allows you to set a message that only gets displayed on errors,
and it offers `%{errormsg}` and `%{exitcode}` among all the variables.

For example:

    curl --write-out "%{onerror}curl says: (%{exitcode}) %{errormsg}" \
      https://curl.se/

## "Not used"

The list of exit codes above contains a number of values marked as 'not
used'. Those are exit status codes that are not used in modern versions of curl
but that have been used or were intended to be used in the past. They may be
used in a future version of curl.

Additionally, the highest used error status in this list is 99, but future
curl versions might have added more exit codes after that number.
