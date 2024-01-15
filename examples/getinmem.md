# Get a response into memory

This example is a variation of the former that instead of sending the received
data to stdout (which often is not what you want), this example instead stores
the incoming data in a memory buffer that is enlarged as the incoming data
grows.

It accomplishes this by using a [write callback](../transfers/callbacks/write.md) to
receive the data.

This example uses a fixed URL string with a set URL scheme, but you can of
course change this to use any other supported protocol and then get a resource
from that instead.

    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>

    #include <curl/curl.h>

    struct MemoryStruct {
      char *memory;
      size_t size;
    };

    static size_t
    mem_cb(void *contents, size_t size, size_t nmemb, void *userp)
    {
      size_t realsize = size * nmemb;
      struct MemoryStruct *mem = (struct MemoryStruct *)userp;

      mem->memory = realloc(mem->memory, mem->size + realsize + 1);
      if(mem->memory == NULL) {
        /* out of memory */
        printf("not enough memory (realloc returned NULL)\n");
        return 0;
      }

      memcpy(&(mem->memory[mem->size]), contents, realsize);
      mem->size += realsize;
      mem->memory[mem->size] = 0;

      return realsize;
    }

    int main(void)
    {
      CURL *curl_handle;
      CURLcode res;

      struct MemoryStruct chunk;

      chunk.memory = malloc(1);  /* grown as needed by the realloc above */
      chunk.size = 0;    /* no data at this point */

      curl_global_init(CURL_GLOBAL_ALL);

      /* init the curl session */
      curl_handle = curl_easy_init();

      /* specify URL to get */
      curl_easy_setopt(curl_handle, CURLOPT_URL, "https://www.example.com/");

      /* send all data to this function  */
      curl_easy_setopt(curl_handle, CURLOPT_WRITEFUNCTION, mem_cb);

      /* we pass our 'chunk' struct to the callback function */
      curl_easy_setopt(curl_handle, CURLOPT_WRITEDATA, (void *)&chunk);

      /* some servers do not like requests that are made without a user-agent
         field, so we provide one */
      curl_easy_setopt(curl_handle, CURLOPT_USERAGENT, "libcurl-agent/1.0");

      /* get it! */
      res = curl_easy_perform(curl_handle);

      /* check for errors */
      if(res != CURLE_OK) {
        fprintf(stderr, "curl_easy_perform() failed: %s\n",
                curl_easy_strerror(res));
      }
      else {
        /*
         * Now, our chunk.memory points to a memory block that is chunk.size
         * bytes big and contains the remote file.
         *
         * Do something nice with it
         */

        printf("%lu bytes retrieved\n", (long)chunk.size);
      }

      /* cleanup curl stuff */
      curl_easy_cleanup(curl_handle);

      free(chunk.memory);

      /* we are done with libcurl, so clean it up */
      curl_global_cleanup();

      return 0;
    }
