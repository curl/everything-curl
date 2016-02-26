# curl return codes

A lot of effort has gone into the project to make curl return a usable return
or exit code when something goes wrong and it will always return 0 (zero) when
the operation went as planned.

If you write a shell script or batch file that invokes curl, you can always
check the return code to detect problems in the invoked command. Below here,
you'll find a list of return codes as of the time of this writing. Over time
we tend to slowly add new ones so if you get a code back not listed here,
please refer to more updated curl documentation for aid.

A very basic unix shell script could look like something like this:

    #!/bin/sh
    curl http://example.com
    res=$?
    if test "$res" != "0"; then
       echo "the curl command failed with: $res"
    fi

## List of all exit codes

 1. Unsupported protocol. This build of curl has no support for this protocol.

 2. Failed to initialize.

 3. URL malformed. The syntax was not correct.

 4. A feature or option that was needed to perform the desired request was
    not enabled or was explicitly disabled at build-time. To make curl able
    to do this, you probably need another build of libcurl!

 5. Couldn't resolve proxy. The given proxy host could not be resolved.

 6. Couldn't resolve host. The given remote host was not resolved.

 7. Failed to connect to host.

 8. Unknown FTP server response. The server sent data curl couldn't parse.

 9. FTP access denied. The server denied login or denied access to the
    particular resource or directory you wanted to reach. Most often you
    tried to change to a directory that doesn't exist on the server.

 10. **Not used**

 11. FTP weird PASS reply. Curl couldn't parse the reply sent to the PASS
    request.

 12. **Not used**

 13. Unknown response to FTP PASV command, Curl couldn't parse the reply
    sent to the PASV request.

 14. Unkmown FTP 227 format. Curl couldn't parse the 227-line the server
    sent.
 
 15.  FTP can't get host. Couldn't resolve the host IP we got in the
    227-line.

 16. **Not used**

 17. FTP couldn't set binary. Couldn't change transfer method to binary.

 18. Partial file. Only a part of the file was transferred.

 19. FTP couldn't download/access the given file, the RETR (or similar)
    command failed.

 20. **Not used**

 21. FTP quote error. A quote command returned error from the server.

 22. HTTP page not retrieved. The requested url was not found or returned
     another error with the HTTP error code being 400 or above. This return
     code only appears if -f, --fail is used.

 23. Write error. Curl couldn't write data to a local filesystem or similar.

 24. **Not used**

 25. The FTP server refused to store the file. The server denied the STOR
     operation, used for FTP uploading.

 26. Read error. Various reading problems.

 27. Out of memory. A memory allocation request failed.

 28. Operation timeout. The specified time-out period was reached according to the
     conditions.

 29. **Not used**

 30. FTP PORT failed. The PORT command failed. Not all FTP servers support
     the PORT command, try doing a transfer using PASV instead!

 31. FTP couldn't use REST. The REST command failed. This command is used
     for resumed FTP transfers.

 32. **Not used**

 33. HTTP range error. The range request didn't work.
 
 34. HTTP post error. Internal post-request generation error.

 35. A TLS/SSL connect error. The SSL handshake failed.

 36. FTP bad download resume. Couldn't continue an earlier aborted download.
 
 37. FILE couldn't read file. Failed to open the file. Permissions?

 38. LDAP cannot bind. LDAP bind operation failed.

 39. LDAP search failed.

 40. **Not used**

 41. A required LDAP function was not found.

 42. Aborted by callback. An application told curl to abort the operation.

 43. Internal error. A function was called with a bad parameter. Please file
     a bug report to the curl project if this happens to you!w

 44. **Not used**

 45. Interface error. A specified outgoing interface could not be used.

 46. **Not used**

 47. Too many redirects. When following redirects, curl hit the maximum
     amount.
 
 48. Unknown option specified to libcurl.  Please file a bug report to the
     curl project if this happens to you!

 49. Malformed telnet option.

 50. **Not used**

 51. The peer's SSL certificate or SSH MD5 fingerprint was not OK.

 52. The server didn't reply anything, which here is considered an error.

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

 66. Failed to initialise SSL Engine.

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
