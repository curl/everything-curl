## Contributing

Contributing means helping out.

When you contribute anything to the project. Code, documentation, bug fixes,
suggestions or just good advice, we assume you do this with permission and you
are not breaking any contracts or laws by providing that to us. If you don't
have permission, don't contribute it to us.

Contributing to a project like curl could be many different things. While
source code is the stuff that is needed to build the products, we're also
depending on good documentation, testing (both test code and test
infrastructure), web content, user support and more.

Send your changes or suggestions to the team and by working together we can
fix problems, improve functionality, clarify documentation, add features or
make anything else you help out with land in the proper place. To make sure
improved code and docs get merged into the source tree properly and other
sorts of contributions are suitable received.

Send your contributions on a [mailing list](curl-comm.md), file an issue or
submit a pull-request.

### Suggestions

Ideas are easy, implementations are hard. Yes we do appreciate good ideas and
suggestions of what to do and how to do it, but the chances that the ideas
actually turn into real features grow substantially if you also volunteer to
participate in converting the idea into reality.

We already gather ideas in the `TODO` document and we are generally aware of
the current trends in the popular networking protocols so there is usually no
need to remind us about those.

### What to add

The best approach to add anything to curl or libcurl is of course to first
bring the idea and suggestion to the curl project team members, and then
discuss with them on if the idea is feasable for inclusion and then how an
implementoin is best done - and done in the best possible way to get merged
into the source code repository. Assuming that is what you want.

The project generally approves of functions that improves the support for the
current protocols. Especially features that popular clients or browsers have
but that curl still lacks.

Of course you can also add contents to the project that isn't code. Like
documentation, graphics or web site contents, but the general rule applies
equally to that.

If you're fixing a problem you have or a problem that others are reporting, we
will be thrilled to receive it and merge it as soon as possible!

### What not to add

There isn't any good rules to say what features you can't add or that we will
never accept, but let me instead try to mention a few things you should avoid
to get less friction and to reach success faster:

- Do not write up a huge page first and then send it to the list for
  discussion. Always start out by discussing on the list, and send your
  initial reviews early to get feedback on your design and approach. It saves
  you from wasting a lot of time going down a route that might need rewriting
  in the end anyway!

- When introducing things in the code you need to follow the style and
  architecture that already exists. When you add code to the ordinary transfer
  code path, it must for example work asynchronously in a non-blocking
  manner. We will not accept new code that introduces new blocking
  behaviors. We already have too many of those that we haven't managed to
  remove yet.

- Quick hacks or dirty solutions that have a high risk of not working on
  platforms you don't run or achitectures you don't know. We don't care if
  you're in a hurry or that it works for you. We do not accept high risk code
  or code that is hard to read or understand.

- Code that breaks the build. Sure, we accept that we sometimes have to add
  code to certain areas that makes the new functionality perhaps depend on a
  specific 3rd party library or a specific operating system and similar, but
  we can **never** do that at the expence of all other systems. We don't break
  the build, and we make sure all tests keep running succesfully.

## git

TBD

### git commit style

TBD

### Who decides what goes in?

TBD
