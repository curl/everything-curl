# curl easy options

You set options in the easy handle to control how that transfer is going to be
done, or in some cases you can actually set options and modify the transfer's
behavior while it is in progress. You set options with `curl_easy_setopt()`
and you provide the handle, the option you want to set and the argument to the
option. All options take exactly one argument and you must always pass exactly
three parameters to the `curl_easy_setopt()` calls.

Since the `curl_easy_setopt()` call accepts several hundred different options
and the various options accept a variety of different types of arguments, it
is important to read up on the specifics and provide exactly the argument
type the specific option supports and expects. Passing in the wrong type can
lead to unexpected side-effects or hard to understand hiccups.

The perhaps most important option that every transfer needs, is the URL.
libcurl cannot perform a transfer without knowing which URL it concerns so you
must tell it. The URL option name is `CURLOPT_URL` as all options are prefixed
with `CURLOPT_` and then the descriptive name — all using uppercase
letters. An example line setting the URL to get the `http://example.com` HTTP
contents could look like:

    CURLcode ret = curl_easy_setopt(easy, CURLOPT_URL, "http://example.com");

Again: this only sets the option in the handle. It does not do the actual
transfer or anything. It just tells libcurl to copy the given string and if
that works it returns OK.

It is, of course, good form to check the return code to see that nothing went
wrong.

## Get options

There is no way to extract the values previously set with
`curl_easy_setopt()`. If you need to be able to extract the information again
that you set earlier, we encourage you to keep track of that data yourself in
your application.

* [Set numerical options](num.md)
* [Set string options](strings.md)
* [TLS options](tls.md)
* [All options](all.md)
* [Get option information](info.md)
