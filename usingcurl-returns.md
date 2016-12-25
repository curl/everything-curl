# Exit status

A lot of effort has gone into the project to make curl return a usable exit
code when something goes wrong and it will always return 0 (zero) when the
operation went as planned.

If you write a shell script or batch file that invokes curl, you can always
check the return code to detect problems in the invoked command. Below, you
will find a list of return codes as of the time of this writing. Over time we
tend to slowly add new ones so if you get a code back not listed here, please
refer to more updated curl documentation for aid.

A very basic Unix shell script could look like something like this:

    #!/bin/sh
    curl http://example.com
    res=$?
    if test "$res" != "0"; then
       echo "the curl command failed with: $res"
    fi

## Available exit codes

 1. Unsupported protocol. This build of curl has no support for this
    protocol. Usually this happens because the URL was misspelled to use a
    sheme part that either as a space in front of it or spells "http" like
    "htpt" or similar. Another common mistake is that you use a libcurl
    installation that was built with one or more protocols disabled and you
    now ask libcurl to use one of those protocols that were disabled in the
    build.

 2. Failed to initialize. This is mostly an internal error or a problem with
    the libcurl installation or system libcurl runs in.

 3. URL malformed. The syntax was not correct. This happens when you mistype a
    URL so that it ends up wrong, or in rare situations you are using a URL
    that is accepted by another tool that curl doesn't support only because
    there is no proper univeral URL standard that everyone adheres to.

 4. A feature or option that was needed to perform the desired request was
    not enabled or was explicitly disabled at build-time. To make curl able
    to do this, you probably need another build of libcurl!

 5. Couldn't resolve proxy. The address of the given proxy host could not be
    resolved. Either the given proxy name is just wrong, or the DNS server is
    misbehaving and doesn't know about this name when it should or perhaps
    even the system you run curl on is misconfigured so that it doesn't
    find/use the correct DNS server.

 6. Couldn't resolve host. The given remote host's address was not
    resolved. The address of the given server could not be resolved. Either
    the given host name is just wrong, or the DNS server is misbehaving and
    doesn't know about this name when it should or perhaps even the system you
    run curl on is misconfigured so that it doesn't find/use the correct DNS
    server.

 7. Failed to connect to host. curl managed to get an IP address to the
    machine and it tried to setup a TCP connection to the host but
    failed. This can be because you have specified the wrong port number,
    entered the wrong host name, the wrong protocol or perhaps because there
    is a firewal or another network equipment in between that blocks the
    traffic from getting through.

 8. Unknown FTP server response. The server sent data curl couldn't
    parse. This is either because of a bug in curl, a bug in the server or
    because the server is using an FTP protocol extension that curl doesn't
    support. The only real work-around for this is to tweak curl options to
    try it to use other FTP commands that perhaps won't get this unknown
    server response back.

 9. FTP access denied. The server denied login or denied access to the
    particular resource or directory you wanted to reach. Most often you tried
    to change to a directory that doesn't exist on the server. The directory
    of course is what you specify in the URL.

 10. FTP accept failed. While waiting for the server to connect back when an
    active FTP session is used, an error code was sent over the control
    connection or similar.

 11. FTP weird PASS reply. Curl couldn't parse the reply sent to the PASS
    request. PASS in the command curl sends the password to the server with,
    and even anonymous connections to FTP server actually sends a password - a
    fixed anonymous string. Getting a response back from this command that
    curl doesn't understand is a strong indication that this isn't an FTP
    server at all or that the server is badly broken.

 12. During an active FTP session (PORT is used) while waiting for the server
    to connect, the timeout expired. It took too long for the server to get
    back. This is usually a sign that something is preventing the server from
    reaching curl succecssfully. Like a firewall or other network
    arrangements.
.
 13. Unknown response to FTP PASV command, Curl couldn't parse the reply sent
    to the PASV request. This is a strange server. PASV is used to setup the
    second data tranfer connection in passive mode, see the [FTP uses two
    connections](ftp-twoconnections.md) section for more on that. You might be
    able to work-around this problem by using PORT instead, with the
    `--ftp-port` option.

 14. Unknown FTP 227 format. Curl couldn't parse the 227-line the server sent
    - this is basically a broken server. A 227 is the FTP server's response
    when sending back information on how curl should connect back to it in
    passive mode. You might be able to work-around this problem by using PORT
    instead, with the `--ftp-port` option.
 
 15. FTP can't get host. Couldn't use the host IP address we got in the
    227-line. This is most likely an internal error!

 16. HTTP/2 error. A problem was detected in the HTTP2 framing layer. This is
    somewhat generic and can be one out of several problems, see the error
    message for details.

 17. FTP couldn't set binary. Couldn't change transfer method to binary. This
    server is broken. curl needs to set the transfer to the correct mode
    before it is started as otherwise the transfer can't work.

 18. Partial file. Only a part of the file was transferred. When the transfer
    is considered complete, curl will verify that it actually received the
    same amount of data that it was told before-hand that it was going to
    get. If the two numbers don't match, this is the error code. It may mean
    that curl to less than advertised or that it got more. curl itself cannot
    know which number that is wrong or which is correct. If any.

 19. FTP couldn't download/access the given file. The RETR (or similar)
    command failed. curl got an error from the server when trying to download
    the file.

 20. **Not used**

 21. Quote error. A quote command returned an error from the server. curl
    allows serveral different ways to send custom commands to a IMAP, POP3,
    SMTP or FTP server and features a generic check that the commands
    work. When any of the individually issued commands fails, this is exit
    status is returned. The advice is generally to watch the headers in the
    FTP communication to better understand exactly what failed and how.

 22. HTTP page not retrieved. The requested url was not found or returned
    another error with the HTTP error code being 400 or above. This return
    code only appears if -f, --fail is used.

 23. Write error. Curl couldn't write data to a local filesystem or
    similar. curl receives data chunk by chunk from the network and it stores
    it like at (or writes it to stdout), one piece at a time. If that write
    action gets an error, this is the exit status.

 24. **Not used**

 25. Upload failed. The server refused to accept or store the file that curl
    tried to send to it. This is usually due to wrong access rights on the
    server but can also happen due to out of disk space or other resource
    constraints. This error can happen for many protocols.

 26. Read error. Various reading problems. The inverse to exit status 23. When
    curl sends data to a server, it reads data chunk by chunk from a local
    file or stdin or similar, and if that reading fails in some way this is
    the exit status curl will return.

 27. Out of memory. A memory allocation request failed. curl needed to
    allocate more memory than what the system was willing to give it and curl
    had to exit. Try using smaller files or make sure that curl gets more
    memory to work with.

 28. Operation timeout. The specified time-out period was reached according to
    the conditions. curl offers several [timeouts](usingcurl-timeouts.md), and
    this exit code tells one of those timeout limits were reached. Extend the
    timeout or try changing something else that allows curl to finish its
    operation faster. Often, this happens due to network and remote server
    situations that you cannot affect locally.

 29. **Not used**

 30. FTP PORT failed. The PORT command failed. Not all FTP servers support the
    PORT command; try doing a transfer using PASV instead! The PORT command is
    used to ask the server to create the data connection by *connecting back*
    to curl. See also the [FTP uses two connections](ftp-twoconnections.md)
    section.

 31. FTP couldn't use REST. The REST command failed. This command is used for
    resumed FTP transfers. curl needs to issue the REST command to do range or
    resumed transfers. The server is broken, try the same operation without
    range/resume as a crude work-around!

 32. **Not used**

 33. HTTP range error. The range request didn't work. Resumed HTTP requests
    aren't necessary acknowledged or supported, so this exit code signals that
    for this resource on this server, there can be no range or resumed
    transfers.
 
 34. HTTP post error. Internal post-request generation error.

 35. A TLS/SSL connect error. The SSL handshake failed.

 36. FTP bad download resume. Couldn't continue an earlier aborted download.
 
 37. FILE couldn't read file. Failed to open the file. Permission problem?

 38. LDAP cannot bind. LDAP bind operation failed.

 39. LDAP search failed.

 40. **Not used**

 41. A required LDAP function was not found.

 42. Aborted by callback. An application told curl to abort the operation.

 43. Internal error. A function was called with a bad parameter. Please file
     a bug report to the curl project if this happens to you!

 44. **Not used**

 45. Interface error. A specified outgoing interface could not be used.

 46. **Not used**

 47. Too many redirects. When following redirects, curl hit the maximum
     number.
 
 48. Unknown option specified to libcurl.  Please file a bug report to the
     curl project if this happens to you!

 49. Malformed telnet option.

 50. **Not used**

 51. The peer's SSL certificate or SSH MD5 fingerprint was not OK.

 52. The server didn't reply anything, which in this context is considered an error.

 53. SSL crypto engine not found.

 54. Cannot set SSL crypto engine as default.

 55. Failed sending network data.

 56. Failure in receiving network data.

 57. **Not used**

 58. Problem with the local certificate.

 59. Couldn't use specified SSL cipher.

 60. Peer certificate cannot be authenticated with known CA certificates.

 61. Unrecognized transfer encoding.

 62. Invalid LDAP URL.

 63. Maximum file size exceeded.

 64. Requested FTP SSL level failed.

 65. Sending the data requires a rewind that failed.

 66. Failed to initialize SSL Engine.

 67. The user name, password, or similar was not accepted and curl failed to log in.

 68. File not found on TFTP server.

 69. Permission problem on TFTP server.

 70. Out of disk space on TFTP server.

 71. Illegal TFTP operation.

 72. Unknown TFTP transfer ID.

 73. File already exists (TFTP).

 74. No such user (TFTP).

 75. Character conversion failed.

 76. Character conversion functions required.

 77. Problem with reading the SSL CA cert

 78. The resource referenced in the URL does not exist.

 79. An unspecified error occurred during the SSH session.

 80. Failed to shut down the SSL connection.

 81. **Not used**

 82. Could not load CRL file, missing or wrong format

 83. TLS certificate issuer check failed

 84. The FTP PRET command failed

 85. RTSP: mismatch of CSeq numbers

 86. RTSP: mismatch of Session Identifiers

 87. unable to parse FTP file list

 88. FTP chunk callback reported error

 89. No connection available, the session will be queued

 90. SSL public key does not matched pinned public key

## Error message

When curl exits with a non-zero code, it will also output an error message
(unless `--silent` is used). That error message may add some additional info
or circumstance to the exit status number itself so the same error number can
get different error messages.

## "Not used"

The list of exit codes above contains a number of values marked as 'not
used'. Those are exit status codes that aren't used in modern versions of curl
but that have been used or were intended to be used in the past. They may very
well be used in a future version of curl.

Additionally, the highest used error status in this list is 90, but there is
no guarantee that a future curl version won't decide to add more exit codes
after that number.
