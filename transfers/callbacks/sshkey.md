# SSH key

This callback is set with `CURLOPT_SSH_KEYFUNCTION`.

It gets called when the `known_host` matching has been done, to allow the
application to act and decide for libcurl how to proceed. The callback is
called if `CURLOPT_SSH_KNOWNHOSTS` is also set.

In the arguments to the callback are the old key and the new key and the
callback is expected to return a return code that tells libcurl how to act:

`CURLKHSTAT_FINE_REPLACE` - The new host+key is accepted and libcurl replaces
the old host+key into the known_hosts file before continuing with the
connection. This also adds the new host+key combo to the known_host pool kept
in memory if it was not already present there. The adding of data to the file
is done by completely replacing the file with a new copy, so the permissions
of the file must allow this.

`CURLKHSTAT_FINE_ADD_TO_FILE` - The host+key is accepted and libcurl appends
it to the known_hosts file before continuing with the connection. This also
adds the host+key combo to the known_host pool kept in memory if it was not
already present there. The adding of data to the file is done by completely
replacing the file with a new copy, so the permissions of the file must allow
this.

`CURLKHSTAT_FINE` - The host+key is accepted libcurl continues with the
connection. This also adds the host+key combo to the known_host pool kept in
memory if it was not already present there.

`CURLKHSTAT_REJECT` - The host+key is rejected. libcurl denies the connection
to continue and it closes.

`CURLKHSTAT_DEFER` - The host+key is rejected, but the SSH connection is asked
to be kept alive. This feature could be used when the app wants to somehow
return and act on the host+key situation and then retry without needing the
overhead of setting it up from scratch again.
