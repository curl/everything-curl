# Cookie file format

Netscape once created a file format for storing cookies on disk so that they
would survive browser restarts. curl adopted that file format to allow sharing
the cookies with browsers, only to soon watch the browsers move away from that
format. Modern browsers no longer use it, while curl still does.

The Netscape cookie file format stores one cookie per physical line in the
file with a bunch of associated meta data, each field separated with TAB. That
file is called the cookiejar in curl terminology.

When libcurl saves a cookiejar, it creates a file header of its own in which
there is a URL mention that links to the web version of this document.

## File format

The cookie file format is text based and stores one cookie per line. Lines
that start with `#` are treated as comments.

Each line that specifies a single cookie consists of seven text fields
separated with TAB characters (ASCII octet 9). A valid line must end with a
newline character.

## Fields in the file

Field number, what type and example data and the meaning of it:

  0. string `example.com` - the domain name
  1. boolean `FALSE` - include subdomains
  2. string `/foobar/` - path
  3. boolean `TRUE` - send/receive over HTTPS only
  4. number `1462299217` - expires at - seconds since Jan 1st 1970, or 0
  5. string `person` - name of the cookie
  6. string `daniel` - value of the cookie
