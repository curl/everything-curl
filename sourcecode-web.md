## Web site source code

Most of the curl web site is also available in a public git repository,
although separate from the source code repository since it generally isn't
interesting to the same people and we can maintain a different list of people
that have push rights etc.

The web site git repo is available on github on this URL:
[https://github.com/bagder/curl-www](https://github.com/bagder/curl-www) and
you can clone a copy of the web code like this:

    git clone https://github.com/bagder/curl-www.git

### Building the web

The web site is a on old custom made setup that mostly builds static HTML from
a set of source files. The sources files are preprocessed with what is
basically a souped-up a C preprocessor called
[fcpp](http://daniel.haxx.se/projects/fcpp/) and a set of perl scripts. The
man pages get converted to HTML with
[roffit](http://daniel.haxx.se/projects/roffit/). Make sure fcpp, perl and
roffit are in your $PATH.

Once you've cloned the git repo, you can build the web site locally with
`make` in the source root tree.

Note that this doesn't make you a complete web site mirror, as some scripts
and files are only available on the real actual site, but should give you
enough to let you load most HTML pages locally.
