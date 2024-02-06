# Authentication

libcurl supports a wide variety of HTTP authentication schemes.

Note that this way of authentication is different than the otherwise widely
used scheme on the web today where authentication is performed by an HTTP POST
and then keeping state in cookies. See [Cookies with libcurl](cookies.md)
for details on how to do that.

## Username and password

libcurl does not try any HTTP authentication without a given username. Set
one like:

    curl_easy_setopt(curl, CURLOPT_USERNAME, "joe");

and of course most authentications also require a set password that you set
separately:

    curl_easy_setopt(curl, CURLOPT_PASSWORD, "secret");

That is all you need. This makes libcurl switch on its default authentication
method for this transfer: *HTTP Basic*.

## Authentication required

A client does not itself decide that it wants to send an authenticated
request. It is something the server requires. When the server has a resource
that is protected and requires authentication, it responds with a 401 HTTP
response and a `WWW-Authenticate:` header. The header includes details about
what specific authentication methods it accepts for that resource.

## Basic

Basic is the default HTTP authentication method and as its name suggests, it
is indeed basic. It takes the name and the password, separates them with a
colon and base64 encodes that string before it puts the entire thing into a
`Authorization:` HTTP header in the request.

If the name and password is set like the examples shown above, the exact
outgoing header looks like this:

    Authorization: Basic am9lOnNlY3JldA==

This authentication method is totally insecure over HTTP as the credentials
are sent in plain-text over the network.

You can explicitly tell libcurl to use Basic method for a specific transfer
like this:

    curl_easy_setopt(curl, CURLOPT_HTTPAUTH, CURLAUTH_BASIC);

## Digest

Another HTTP authentication method is called Digest. One advantage this method
has compared to Basic, is that it does not send the password over the wire in
plain text. This is however an authentication method that is rarely spoken by
browsers and consequently is not a frequently used one.

You can explicitly tell libcurl to use the Digest method for a specific
transfer like this (it still needs username and password set as well):

    curl_easy_setopt(curl, CURLOPT_HTTPAUTH, CURLAUTH_DIGEST);

## NTLM

Another HTTP authentication method is called NTLM.

You can explicitly tell libcurl to use the NTLM method for a specific transfer
like this (it still needs username and password set as well):

    curl_easy_setopt(curl, CURLOPT_HTTPAUTH, CURLAUTH_NTLM);

## Negotiate

Another HTTP authentication method is called Negotiate.

You can explicitly tell libcurl to use the Negotiate method for a specific
transfer like this (it still needs username and password set as well):

    curl_easy_setopt(curl, CURLOPT_HTTPAUTH, CURLAUTH_NEGOTIATE);

## Bearer

To pass on an OAuth 2.0 Bearer Access Token in a request, use
`CURLOPT_XOAUTH2_BEARER` for example:

    CURL *curl = curl_easy_init();
    if(curl) {
      curl_easy_setopt(curl, CURLOPT_URL, "pop3://example.com/");
      curl_easy_setopt(curl, CURLOPT_XOAUTH2_BEARER, "1ab9cb22ba269a7");
      ret = curl_easy_perform(curl);
      curl_easy_cleanup(curl);
    }

## Try-first

Some HTTP servers allow one out of several authentication methods, in some
cases you find yourself in a position where you as a client does not want or
is not able to select a single specific method before-hand and for yet another
subset of cases your application does not know if the requested URL even
require authentication or not.

libcurl covers all these situations as well.

You can ask libcurl to use more than one method, and when doing so, you imply
that curl first tries the request without any authentication at all and then
based on the HTTP response coming back, it selects one of the methods that
both the server and your application allow. If more than one would work, curl
picks them in a order based on how secure the methods are considered to be,
picking the safest of the available methods.

Tell libcurl to accept multiple method by bitwise ORing them like this:

    curl_easy_setopt(curl, CURLOPT_HTTPAUTH,
                     CURLAUTH_BASIC | CURLAUTH_DIGEST);

If you want libcurl to only allow a single specific method but still want it
to probe first to check if it can possibly still make the request without the
use of authentication, you can force that behavior by adding `CURLAUTH_ONLY`
to the bitmask.

Ask to use digest, but nothing else but digest, and only if proven really
necessary:

    curl_easy_setopt(curl, CURLOPT_HTTPAUTH,
                     CURLAUTH_DIGEST | CURLAUTH_ONLY);
