# Stop slow transfers

By default, a transfer can stall or transfer data extremely slow for any
period without that being an error.

Stop a transfer if below **N** bytes/sec during **M** seconds. Set **N** with
`CURLOPT_LOW_SPEED_LIMIT` and set **M** with `CURLOPT_LOW_SPEED_TIME`.

Using these option in real code can look like this:

    #include <stdio.h>
    #include <curl/curl.h>

    int main(void)
    {
      CURL *curl;
      CURLcode res = CURLE_OK;

      curl = curl_easy_init();
      if(curl) {
        /* abort if slower than 30 bytes/sec during 60 seconds */
        curl_easy_setopt(curl, CURLOPT_LOW_SPEED_TIME, 60L);
        curl_easy_setopt(curl, CURLOPT_LOW_SPEED_LIMIT, 30L);

        curl_easy_setopt(curl, CURLOPT_URL, "https://curl.se/");

        res = curl_easy_perform(curl);

        curl_easy_cleanup(curl);
      }

      return (int)res;
    }
