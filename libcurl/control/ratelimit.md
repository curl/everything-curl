# Rate limit

Lets an application set a speed cap. Do not transfer data faster than a set
number of bytes per second. libcurl then attempts to keep the average speed
below the given threshold over a period of multiple seconds.

There are separate options for receiving (`CURLOPT_MAX_RECV_SPEED_LARGE`) and
sending (`CURLOPT_MAX_SEND_SPEED_LARGE`).

Here is an example source code showing it in use:

    #include <stdio.h>
    #include <curl/curl.h>

    int main(void)
    {
      CURL *curl;
      CURLcode res = CURLE_OK;

      curl = curl_easy_init();
      if(curl) {
        curl_off_t maxrecv = 31415;
        curl_off_t maxsend = 67954;

        curl_easy_setopt(curl, CURLOPT_MAX_RECV_SPEED_LARGE, maxrecv);
        curl_easy_setopt(curl, CURLOPT_MAX_SEND_SPEED_LARGE, maxsend);

        curl_easy_setopt(curl, CURLOPT_URL, "https://curl.se/");

        res = curl_easy_perform(curl);

        curl_easy_cleanup(curl);
      }

      return (int)res;
    }
