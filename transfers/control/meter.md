# Progress meter

libcurl can be made to output a progress meter on stderr. This feature is
disabled by default and is one of those options with an ones awkward negation
in the name: `CURLOPT_NOPROGRESS` - set it to `1L` to *disable* progress
meter. Set it to `0L` to enable it.

Return error to stop transfer

It can look something like this in code:

    #include <stdio.h>
    #include <curl/curl.h>

    int main(void)
    {
      CURL *curl;
      CURLcode res = CURLE_OK;

      curl = curl_easy_init();
      if(curl) {
        /* enable progress meter */
        curl_easy_setopt(curl, CURLOPT_NOPROGRESS, 0L);

        curl_easy_setopt(curl, CURLOPT_URL, "https://curl.se/");

        res = curl_easy_perform(curl);

        curl_easy_cleanup(curl);
      }

      return (int)res;
    }
