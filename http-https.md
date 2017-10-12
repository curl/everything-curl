# HTTPS

HTTPS is in effect Secure HTTP. The "secure" part means that the TCP transport
layer is enhanced to provide authentication, privacy (encryption) and data
integrety by the use of TLS.

## Server verification

When HTTPS is used, curl will verify the server before any data exchange takes
place and only if deemed okay it will continue. It verifies the server by
asking for its "certificate" which should contain a correct name that
corresponds to the name used in the URL and it needs to have been signed by a
CA for which curl has a CA cert in its "CA cert store".

Although strongly discouraged, you can ask curl to skip the verification. By
passing `--insecure` on the command line you then make the otherwise secure
HTTPS transfer insecure. If curl doesn't verify that server is really who you
expect it to be, there could be a malicious intruder pretending to be the
actual server so curl will proceed and do an encrypted connection but to the
wrong other end. You should *never* use `--insecure` or its shorthand `-k` in
production.

## CA store

Most curl builds will use a default CA cert store provided by the operating
system making curl able to verify most public HTTPS sites out there already
from start.

You can also tell curl about a separate CA cert store for when you have
downloaded or been provided with the CA cert for a particular site. You can
then tell curl to use it like

    curl --cacert $HOME/ca-cert.crt https://example.com/

If you're using the curl command line tool on Windows, curl will search for a
CA cert file named `curl-ca-bundle.crt` in these directories and in this
order:

  1. application's directory
  2. current working directory
  3. Windows System directory (e.g. `C:\windows\system32`)
  4. Windows Directory (e.g. `C:\windows`)
  5. all directories along `%PATH%`

## Pinning

TBD
