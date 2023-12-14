# Website

Most of the curl website is also available in a public git repository,
although separate from the source code repository since it generally is not
interesting to the same people and we can maintain a different list of people
that have push rights, etc.

The website git repository is available on GitHub at this URL:
[https://github.com/curl/curl-www](https://github.com/curl/curl-www) and
you can clone a copy of the web code like this:

    git clone https://github.com/curl/curl-www.git

## Building the web

The website is a custom-made setup that mostly builds static HTML files from a
set of source files. The source files are preprocessed with what is a
souped-up C preprocessor called [fcpp](https://daniel.haxx.se/projects/fcpp/)
and a set of perl scripts. The man pages get converted to HTML with
[roffit](https://daniel.haxx.se/projects/roffit/). Make sure fcpp, perl,
roffit, make and curl are all in your $PATH.

Once you have cloned the git repository the first time, invoke `sh
bootstrap.sh` once to get a symlink and some initial local files setup,
and then you can build the website locally by invoking `make` in the source
root tree.

Note that this does not make you a complete website mirror, as some scripts
and files are only available on the real actual site, but should give you
enough to let you view most HTML pages locally.

## Run a local clone

The website is built in a way that makes it easy and convenient to host a
local copy for browsing and testing changes before we push them to the
official site in production. We then recommend you call the site `curl.local`
and add that as an entry in your local `/etc/hosts` file. Then point the
document root of your HTTP server to the curl-www source code root.

## Website infrastructure

- The public curl website is hosted at [curl.se](https://curl.se).
- The domain name is owned by **Daniel Stenberg**
- The main origin machine is sponsored by **Haxx**
- The curl.se domain is served by anycast distributed DNS servers sponsored
  by **Kirei**
- The site is delivered to the world via a CDN run by **Fastly**
- The website updates itself from GitHub every N minutes. The CDN front-ends
  cache content for Y minutes (different types cache content different times)
