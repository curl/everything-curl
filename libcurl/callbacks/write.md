# Write data

The write callback is set with `CURLOPT_WRITEFUNCTION`:

    curl_easy_setopt(handle, CURLOPT_WRITEFUNCTION, write_callback);

The `write_callback` function must match this prototype:

    size_t write_callback(char *ptr, size_t size, size_t nmemb,
                          void *userdata);

This callback function gets called by libcurl as soon as there is data
received that needs to be saved. *ptr* points to the delivered data, and the
size of that data is *size* multiplied with *nmemb*.

If this callback is not set, libcurl instead uses 'fwrite' by default.

The write callback is passed as much data as possible in all invokes, but it
must not make any assumptions. It may be one byte, it may be thousands. The
maximum amount of body data that is passed to the write callback is defined in
the curl.h header file: `CURL_MAX_WRITE_SIZE` (the usual default is 16KB). If
`CURLOPT_HEADER` is enabled for this transfer, which makes header data get
passed to the write callback, you can get up to `CURL_MAX_HTTP_HEADER` bytes
of header data passed into it. This usually means 100KB.

This function may be called with zero bytes data if the transferred file is empty.

The data passed to this function is not be zero terminated. You cannot, for
example, use printf's `%s` operator to display the contents nor strcpy to copy
it.

This callback should return the number of bytes actually taken care of. If
that number differs from the number passed to your callback function, it
signals an error condition to the library. This causes the transfer to get
aborted and the libcurl function used returns `CURLE_WRITE_ERROR`.

The user pointer passed in to the callback in the *userdata* argument is set
with `CURLOPT_WRITEDATA`:

    curl_easy_setopt(handle, CURLOPT_WRITEDATA, custom_pointer);

## Store in memory

A popular demand is to store the retrieved response in memory, and the
callback explained above supports that. When doing this, just be careful as
the response can potentially be enormous.

You implement the callback in a manner similar to:

    struct response {
      char *memory;
      size_t size;
    };

    static size_t
    mem_cb(void *contents, size_t size, size_t nmemb, void *userp)
    {
      size_t realsize = size * nmemb;
      struct response *mem = (struct response *)userp;

      char *ptr = realloc(mem->memory, mem->size + realsize + 1);
      if(!ptr) {
        /* out of memory! */
        printf("not enough memory (realloc returned NULL)\n");
        return 0;
      }

      mem->memory = ptr;
      memcpy(&(mem->memory[mem->size]), contents, realsize);
      mem->size += realsize;
      mem->memory[mem->size] = 0;

      return realsize;
    }

    int main()
    {
      struct response chunk = {.memory = malloc(0),
                               .size = 0};

      /* send all data to this function  */
      curl_easy_setopt(curl_handle, CURLOPT_WRITEFUNCTION, mem_cb);

      /* we pass our 'chunk' to the callback function */
      curl_easy_setopt(curl_handle, CURLOPT_WRITEDATA, (void *)&chunk);
    
      free(chunk.memory);
    }
