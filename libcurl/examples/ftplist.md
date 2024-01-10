# Get an FTP directory listing

This example just fetches the FTP directory output from the given URL and
sends it to stdout. The trailing slash in the URL is what makes libcurl treat
it as a directory.

    #include <curl/curl.h>

    int main(void)
    {
      CURL *curl;
      CURLcode res;

      curl_global_init(CURL_GLOBAL_DEFAULT);

      curl = curl_easy_init();
      if(curl) {
        /*
         * Make the URL end with a trailing slash
         */
        curl_easy_setopt(curl, CURLOPT_URL, "ftp://ftp.example.com/");

        res = curl_easy_perform(curl);

        /* always cleanup */
        curl_easy_cleanup(curl);

        if(CURLE_OK != res) {
          /* we failed */
          fprintf(stderr, "curl told us %d\n", res);
        }
      }

      curl_global_cleanup();

      return 0;
    }
