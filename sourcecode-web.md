## Web site source code

Most of the curl web site is also available in a public git repository,
although separate from the source code repository since it generally is not
interesting to the same people and we can maintain a different list of people
that have push rights, etc.

The web site git repository is available on GitHub at this URL:
[https://github.com/curl/curl-www](https://github.com/curl/curl-www) and
you can clone a copy of the web code like this:

    git clone https://github.com/curl/curl-www.git

### Building the web

The web site is a custom-made setup that mostly builds static HTML files from
a set of source files. The sources files are preprocessed with what is
basically a souped-up C preprocessor called
[fcpp](https://daniel.haxx.se/projects/fcpp/) and a set of perl scripts. The
man pages get converted to HTML with
[roffit](https://daniel.haxx.se/projects/roffit/). Make sure fcpp, perl,
roffit, make and curl are all in your $PATH.

Once you have cloned the git repository the first time, invoke `sh
bootstrap.sh` once to get a symlink and some some initial local files setup,
and then you can build the web site locally by invoking `make` in the source
root tree.

Note that this does not make you a complete web site mirror, as some scripts
and files are only available on the real actual site, but should give you
enough to let you view most HTML pages locally.
