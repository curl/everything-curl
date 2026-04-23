# WebSocket using callback

This example sets up a WebSocket download and handles all the incoming data in
the standard write callback.

If your WebSocket need is more of a back-and-forth communication, you might
want to rather use the dedicated send and receive functions shown in the
[simple WebSocket](websocket.md) example.

    #include <stdio.h>
    #include <curl/curl.h>

    static size_t write_cb(char *b, size_t size, size_t nitems, void *p)
    {
      CURL *curl = p;
      size_t i;
      const struct curl_ws_frame *frame = curl_ws_meta(curl);
      fprintf(stderr, "Type: %s\n",
              frame->flags & CURLWS_BINARY ? "binary" : "text");
      fprintf(stderr, "Bytes: %u", (unsigned int)(nitems * size));
      for(i = 0; i < nitems; i++)
        fprintf(stderr, "%02x ", (unsigned char)b[i]);
      return nitems;
    }

    int main(void)
    {
      CURL *curl;

      CURLcode result = curl_global_init(CURL_GLOBAL_ALL);
      if(result != CURLE_OK)
        return (int)result;

      curl = curl_easy_init();
      if(curl) {
        curl_easy_setopt(curl, CURLOPT_URL, "wss://example.com");

        curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, write_cb);
        /* pass the easy handle to the callback */
        curl_easy_setopt(curl, CURLOPT_WRITEDATA, curl);

        /* Perform the request, result gets the return code */
        result = curl_easy_perform(curl);
        /* Check for errors */
        if(result != CURLE_OK)
          fprintf(stderr, "curl_easy_perform() failed: %s\n",
                  curl_easy_strerror(result));

        /* always cleanup */
        curl_easy_cleanup(curl);
      }
      curl_global_cleanup();
      return (int)result;
    }
