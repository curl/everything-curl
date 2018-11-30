# libcurl examples

The native API for libcurl is in C so this chapter is focussed on examples
written in C. But since many language bindings for libcurl are thin, they
usually expose more or less the same functions and thus they can still be
interesting and educational for users of other languages, too.

## Get a simple HTML page

This example just fetches the HTML and sends it to stdout:

    #include <stdio.h>
    #include <curl/curl.h>

    int main(void)
    {
      CURL *curl;
      CURLcode res;

      curl = curl_easy_init();
      if(curl) {
        curl_easy_setopt(curl, CURLOPT_URL, "http://example.com/");

        /* Perform the request, res will get the return code */
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

## Get a HTML page in memory

This example is a variation of the former that instead of sending the data to
stdout (which often is not what you want), this stores the received data in a
memory buffer that is made larger as the incoming data grows.

It accomplishes this by using the write callback to receive the data.

    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>

    #include <curl/curl.h>

    struct MemoryStruct {
      char *memory;
      size_t size;
    };

    static size_t
    WriteMemoryCallback(void *contents, size_t size, size_t nmemb, void *userp)
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

      chunk.memory = malloc(1);  /* will be grown as needed by the realloc above */
      chunk.size = 0;    /* no data at this point */

      curl_global_init(CURL_GLOBAL_ALL);

      /* init the curl session */
      curl_handle = curl_easy_init();

      /* specify URL to get */
      curl_easy_setopt(curl_handle, CURLOPT_URL, "http://www.example.com/");

      /* send all data to this function  */
      curl_easy_setopt(curl_handle, CURLOPT_WRITEFUNCTION, WriteMemoryCallback);

      /* we pass our 'chunk' struct to the callback function */
      curl_easy_setopt(curl_handle, CURLOPT_WRITEDATA, (void *)&chunk);

      /* some servers don't like requests that are made without a user-agent
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
         * Do something nice with it!
         */

        printf("%lu bytes retrieved\n", (long)chunk.size);
      }

      /* cleanup curl stuff */
      curl_easy_cleanup(curl_handle);

      free(chunk.memory);

      /* we're done with libcurl, so clean it up */
      curl_global_cleanup();

      return 0;
    }

## Submit a login form over HTTP

TBD

## Get an FTP directory listing

TBD

## Download an HTTPS page straight into memory

TBD

## Upload data to an HTTP site without blocking

TBD
