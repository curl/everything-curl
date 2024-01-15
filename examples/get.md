# Get a simple HTTP page

This example just fetches the HTML from a given URL and sends it to
stdout. Possibly the simplest libcurl program you can write.

By replacing the URL this is able to get contents over other supported
protocols as well.

Getting the output sent to stdout is a default behavior and usually not what
you actually want. Most applications instead install a
[write callback](../transfers/callbacks/write.md) to have receive the data that arrives.

    #include <stdio.h>
    #include <curl/curl.h>

    int main(void)
    {
      CURL *curl;
      CURLcode res;

      curl = curl_easy_init();
      if(curl) {
        curl_easy_setopt(curl, CURLOPT_URL, "http://example.com/");

        /* Perform the request, 'res' holds the return code */
        res = curl_easy_perform(curl);
        /* Check for errors */
        if(res != CURLE_OK)
          fprintf(stderr, "curl_easy_perform() failed: %s\n",
                  curl_easy_strerror(res));

        /* always cleanup */
        curl_easy_cleanup(curl);
      }
      return 0;
    }
