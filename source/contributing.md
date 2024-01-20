# Contributing

Contributing means helping out.

When you contribute anything to the project—code, documentation, bug fixes,
suggestions or just good advice—we assume you do this with permission and you
are not breaking any contracts or laws by providing that to us. If you do not
have permission, do not contribute it to us.

Contributing to a project like curl could be many different things. While
source code is the stuff that is needed to build the products, we are also
depending on good documentation, testing (both test code and test
infrastructure), web content, user support and more.

Send your changes or suggestions to the team and by working together we can
fix problems, improve functionality, clarify documentation, add features or
make anything else you help out with land in the proper place. We make sure
improved code and docs get merged into the source tree properly and other
sorts of contributions are suitable received.

Send your contributions on a [mailing list](../project/comm.md), file an issue
or submit a pull request.

## Suggestions

Ideas are easy, implementations are hard. Yes, we do appreciate good ideas and
suggestions of what to do and how to do it, but the chances that the ideas
actually turn into real features grow substantially if you also volunteer to
participate in converting the idea into reality.

We already gather ideas in the `TODO` document and we are generally aware of
the current trends in the popular networking protocols so there is usually no
need to remind us about those.

## What to add

The best approach to add anything to curl or libcurl is, of course, to first
bring the idea and suggestion to the curl project team members and then
discuss with them if the idea is feasible for inclusion and then how an
implementation is best done—and done in the best possible way to get merged
into the source code repository, assuming that is what you want.

The project generally approves functions that improve the support for the
current protocols, especially features that popular clients or browsers have
but that curl still lacks.

Of course, you can also add contents to the project that are not code, like
documentation, graphics or website contents, but the general rules apply
equally to that.

If you are fixing a problem you have or a problem that others are reporting,
we are thrilled to receive your fixes and merge them as soon as possible,

## What not to add

There are no good rules that say what features you can or cannot add or that
we never accept, but let me instead try to mention a few things you should
avoid to get less friction and to be successful, faster:

- Do not write up a huge patch first and then send it to the list for
  discussion. Always start out by discussing on the list, and send your
  initial review requests early to get feedback on your design and
  approach. It saves you from wasting time going down a route that might need
  rewriting in the end anyway.

- When introducing things in the code, you need to follow the style and
  architecture that already exists. When you add code to the ordinary transfer
  code path, it must, for example, work asynchronously in a non-blocking
  manner. We do not accept new code that introduces blocking behaviors—we
  already have too many of those that we have not managed to remove yet.

- Quick hacks or dirty solutions that have a high risk of not working on
  platforms you do not run or on architectures you do not know. We do not care
  if you are in a hurry or that it works for you. We do not accept high risk
  code or code that is hard to read or understand.

- Code that breaks the build. Sure, we accept that we sometimes have to add
  code to certain areas that makes the new functionality perhaps depend on a
  specific 3rd party library or a specific operating system and similar, but
  we can **never** do that at the expense of all other systems. We do not break
  the build, and we make sure all tests keep running successfully.

## git

Our preferred source control tool is [git](https://git-scm.com/).

While git is sometimes not the easiest tool to learn and master, all the basic
steps a casual developer and contributor needs to know are straight-forward
and do not take much time or effort to learn.

This book does not help you learn git. All software developers in this day and
age should learn git anyway.

The curl git tree can be browsed with a web browser on our GitHub page at
[https://github.com/curl/curl](https://github.com/curl/curl).

To check out the curl source code from git, you can clone it like this:

    git clone https://github.com/curl/curl.git

## Pull request

A popular and convenient way to make your own changes and contribute them back
to the project is by doing a so-called pull request on GitHub.

First, you create your own version of the source tree, called a fork, on the
Github website. That way you get your own version of the curl git tree that
you can clone to a local copy.

You edit your own local copy, commit the changes, push them to the git
repository on Github and then on the Github website you can select to create
a pull request based on your changes done to your local repository clone of
the original curl repository.

We recommend doing your work meant for a pull request in a dedicated separate
branch and not in master, just to make it easier for you to update a pull
request, like after review, for example, or if you realize it was a dead end and
you decide to just throw it away.

## Make a patch for the mailing list

Even if you opt to not make a pull request but prefer the old fashioned and
trusted method of sending a patch to the curl-library mailing list, it is
still a good practice to work in a local git branch and commit your changes
there.

A branch makes it easy to edit and rebase when you need to change things and
it makes it easy to keep syncing to the master branch when things are updated
upstream.

Once your commits are fine enough to get sent to the mailing list, you just
create patches with `git format-patch` and send them away. Even more fancy
users go directly to `git send-email` and have git send the email itself.

## git commit style

When you commit a patch to git, you give it a commit message that describes
the change you are committing. We have a certain style in the project that we
ask you to use:

    [area]: [short line describing the main effect]

    [separate the above single line from the rest with an empty line]

    [full description, no wider than 72 columns that describes as much as
    possible as to why this change is made, and possibly what things
    it fixes and everything else that is related]

    [Bug: link to source of the report or more related discussion]
    [Reported-by: John Doe—credit the reporter]
    [whatever-else-by: credit all helpers, finders, doers]

Do not forget to use `git commit --author="Jane Doe <jane@example.com>"` if
you commit someone else's work, and make sure that you have your own Github
username and email setup correctly in git before you commit via commands
below:

    git config --global user.name "johndoe"
    git config --global user.email "johndoe@example.com"


The author and the \*-by: lines are, of course, there to make sure we give the
proper credit in the project. We do not want to take someone else's work
without clearly attributing where it comes from. Giving correct credit is of
utmost importance.

## Who decides what goes in?

First, it might not be obvious to everyone but there is, of course, only a
limited set of people that can actually merge commits into the actual official
git repository. Let's call them the core team.

Everyone else can fork off their own curl repository to which they can commit
and push changes and host them online and build their own curl versions from
and so on, but in order to get changes into the *official* repository they need
to be pushed by a trusted person.

The core team is a small set of curl developers who have been around for
several years and have shown they are skilled developers and that they fully
comprehend the values and the style of development we do in this project. They
are some of the people listed in the [The development team](../project/devteam.md) section.

You can always bring a discussion to the mailing list and argue why you think
your changes should get accepted, or perhaps even object to other changes that
are getting in and so forth. You can even suggest yourself or someone else to
be given "push rights" and become one of the selected few in that team.

Daniel remains the project leader and while it is rarely needed, he has the
final say in debates that do not seem to sway in either direction or fail to
reach consensus.
