# Submit a login form over HTTP

A login submission over HTTP is usually a matter of figuring out exactly what
data to submit in a POST and to which target URL to send it.

Once logged in, the target URL can be fetched if the proper cookies are
used. As many login-systems work with HTTP redirects, we ask libcurl to follow
such if they arrive.

Some login forms makes it more complicated and require that you got cookies
from the page showing the login form etc, so if you need that you may want to
extend this code a little bit.

By passing in a non-existing cookie file, this example enables the cookie
parser so incoming cookies are stored when the response from the login
response arrives and then the subsequent request for the resource uses those
and prove to the server that we are in fact correctly logged in.

    #include <stdio.h>
    #include <string.h>
    #include <curl/curl.h>

    int main(void)
    {
      CURL *curl;
      CURLcode res;

      static const char *postthis = "user=daniel&password=monkey123";

      curl = curl_easy_init();
      if(curl) {
        curl_easy_setopt(curl, CURLOPT_URL, "https://example.com/login.cgi");
        curl_easy_setopt(curl, CURLOPT_POSTFIELDS, postthis);
        curl_easy_setopt(curl, CURLOPT_FOLLOWLOCATION, 1L); /* redirects */
        curl_easy_setopt(curl, CURLOPT_COOKIEFILE, ""); /* no file */
        res = curl_easy_perform(curl);
        /* Check for errors */
        if(res != CURLE_OK)
          fprintf(stderr, "curl_easy_perform() failed: %s\n",
                  curl_easy_strerror(res));
        else {
          /*
           * After the login POST, we have received the new cookies. Switch
           * over to a GET and ask for the login-protected URL.
           */
          curl_easy_setopt(curl, CURLOPT_URL, "https://example.com/file");
          curl_easy_setopt(curl, CURLOPT_HTTPGET, 1L); /* no more POST */
          res = curl_easy_perform(curl);
          /* Check for errors */
          if(res != CURLE_OK)
            fprintf(stderr, "second curl_easy_perform() failed: %s\n",
                    curl_easy_strerror(res));
        }
        /* always cleanup */
        curl_easy_cleanup(curl);
      }
      return 0;
    }
