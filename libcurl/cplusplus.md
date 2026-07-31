# for C++ programmers

libcurl provides a C API. C and C++ are similar but not the same. There are a
few things to keep in mind when using libcurl in C++.

## Strings are C strings, not C++ string objects

When you pass strings to libcurl's APIs that accept `char *` that means you
cannot pass in C++ strings or objects to those functions.

For example, if you build a string with C++ and then want that string used as
a URL:

    std::string url = "https://example.com/foo.asp?name=" + i;
    curl_easy_setopt(curl, CURLOPT_URL, url.c_str());

## Callback considerations

libcurl is written in C and is unaware of C++ class instances or member
functions, which require an implicit `this` pointer. You can work around this
by using a static member function (or a standalone C-style function) as the
callback and passing the object instance via the user data pointer you set
with libcurl (for example, `CURLOPT_WRITEDATA` for the write callback). Inside
the static callback, cast that `void *` back to your class type to invoke
non-static member functions.

Here's an example of a write callback using a C++ method as callback:

    // f is the pointer to your object.
    static size_t YourClass::func(void *buffer, size_t sz,
                                  size_t n, void *f)
    {
      // Call non-static member function.
      static_cast<YourClass*>(f)->nonStaticFunction();
    }

    // This is how you pass pointer to the static function:
    curl_easy_setopt(hcurl, CURLOPT_WRITEFUNCTION, YourClass::func);
    curl_easy_setopt(hcurl, CURLOPT_WRITEDATA, this);
