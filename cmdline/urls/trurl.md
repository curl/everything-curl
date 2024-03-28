# trurl

*trurl* is a separate command line tool with the sole purpose of parsing,
manipulating and outputting URLs and parts of URLs. A companion tool to curl
for your command lines and scripting needs.

trurl uses libcurl’s URL parser. This ensures that curl and trurl always have
the same opinion about URLs and that both tools parse them identically and
consistently.

## Usage

Typically you pass in one or more URLs to trurl and specify what components
you want output. Possibly while modifying the URL(s) as well.

trurl knows URLs and every URL consists of up to ten separate and independent
*components*. These components can be extracted, removed and updated with
trurl.

## trurl example command lines

**Replace the hostname of a URL:**

    $ trurl --url https://curl.se --set host=example.com
    https://example.com/

**Create a URL by setting components:**

    $ trurl --set host=example.com --set scheme=ftp
    ftp://example.com/

**Redirect a URL:**

    $ trurl --url https://curl.se/we/are.html --redirect here.html
    https://curl.se/we/here.html

**Change port number:**

    $ trurl --url https://curl.se/we/../are.html --set port=8080
    https://curl.se:8080/are.html

**Extract the path from a URL:**

    $ trurl --url https://curl.se/we/are.html --get '{path}'
    /we/are.html

**Extract the port from a URL:**

    $ trurl --url https://curl.se/we/are.html --get '{port}'
    443

**Append a path segment to a URL:**

    $ trurl --url https://curl.se/hello --append path=you
    https://curl.se/hello/you

**Append a query segment to a URL:**

    $ trurl --url "https://curl.se?name=hello" --append query=search=string
    https://curl.se/?name=hello&search=string

**Read URLs from stdin:**

    $ cat urllist.txt | trurl --url-file -
    ...

**Output JSON:**

    $ trurl "https://fake.host/hello#frag" --set user=::moo:: --json
    [
      {
        "url": "https://%3a%3amoo%3a%3a@fake.host/hello#frag",
        "parts": {
          "scheme": "https",
          "user": "::moo::",
          "host": "fake.host",
          "path": "/hello",
          "fragment": "frag"
        }
      }
    ]

**Remove tracking tuples from query:**

    $ trurl "https://curl.se?search=hey&utm_source=tracker" \
      --trim query="utm_*"
    https://curl.se/?search=hey

**Show a specific query key value:**

    $ trurl "https://example.com?a=home&here=now&thisthen" -g '{query:a}'
    home

**Sort the key/value pairs in the query component:**

    $ trurl "https://example.com?b=a&c=b&a=c" --sort-query
    https://example.com?a=c&b=a&c=b

**Work with a query that uses a semicolon separator:**

    $ trurl "https://curl.se?search=fool;page=5" --trim query="search" \
      --query-separator ";"
    https://curl.se?page=5

**Accept spaces in the URL path:**

    $ trurl "https://curl.se/this has space/index.html" --accept-space
    https://curl.se/this%20has%20space/index.html

## More

Everything you want to know about trurl is found at <https://curl.se/trurl>. It
is probably already available for your Linux distribution of choice.
