# HTTP authentication

libcurl supports a wide varity of HTTP authentication schemes.

Note that this way of authentication is different than the otherwise widely
used scheme on the web today where authentication is performed by a HTTP POST
and then keeping state in cookies. See [Cookies with
libcurl](libcurl-http-cookies.md) for details on how to do that.

## User name and password

libcurl won't try any HTTP authentication without a given user name. Set one like:

     curl_easy_setopt(curl, CURLOPT_USERNAME, "joe");

and of course most authentications also require a set password that you set
separately:

     curl_easy_setopt(curl, CURLOPT_PASSWORD, "secret");

That's all you need. This will make libcurl switch on its default
authentication method for this transfer: *HTTP Basic*.

## Authentication required

A client doesn't itself decide that it wants to send an authenticated
request. It is something the server requires. When the server has a resource
that is protected and requires authentication, it will respond with a 401 HTTP
response and a `WWW-Authenticate:` header. The header will include details
about what specific authentication methods it accepts for that resource.

## Basic

Basic is the default HTTP authentication method and as its name suggests, it
is indeed basic. It takes the name and the password, separates them with a
colon and base64 encodes that string before it puts the entire thing into a
`Authorization:` HTTP header in the request.

If the name and password is set like the examples shown above, the exact
outgoing header looks like this:

    Authorization: Basic am9lOnNlY3JldA==

This authentication method is totally insecure over HTTP as the credentials
will then be sent in plain-text over the network.

You can explicitly tell libcurl to use Basic method for a specific transfer
like this:

    curl_easy_setopt(curl, CURLOPT_HTTPAUTH, CURLAUTH_BASIC);

## Digest

Another authentication method is called Digest. This method has an advantage that 

## NTLM

TBD

## Negotiate

TBD

## Bearer

TBD

## Try-first

TBD
