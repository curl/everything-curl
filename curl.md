# 2. The cURL project

![curl logo](curl-logo.jpg)

A funny detail about open source projects is that they're called "projects",
as if they were somehow limited in time or ever can get done. The cURL
"project" is a number of loosely coupled voluntary individuals working on
writing software together with a common mission: to do reliable data transfers
with internet protocols. And giving away the code for free for anyone to use.

## How it started

Back in 1996, [Daniel Stenberg](http://daniel.haxx.se/) was writing an IRC bot
on his spare time. An automated program that would offer services for the
participants in a chatroom dedicated to the Amiga computer (#amiga on the IRC
network EFnet), when he came to think that it would be fun to get some updated
currency rates and have his bot offer a service online for the chat room users
to get current exchange rates. To ask the bot "please exchange 200 USD into
SEK" or similar.

In order to have the provided exchange rates as accurate as possible, the bot
would download the rates daily from a web site that was hosting them. A small
tool to download data over HTTP was needed for this task. A quick look-around
at the time made Daniel find a tiny tool named httpget (written by a Brazilian
named Rafael Sagula). It did the job, almost, just needed a little a tweaks
here and there and soon Daniel had taken over maintenance of the few hundred
lines of code it was.

HttpGet 1.0 was subsequently released on April 8th 1997 with brand new HTTP
proxy support.

We soon found and fixed support for getting currencies over GOPHER.  Once FTP
download support was added, the name of the project was changed and urlget 2.0
was released in August 1997. The http-only days were already passed.

The project slowly grew bigger. When upload capabilities were added and the
name once again was misleading, a second name change was made and on March 20,
1998 curl 4 was released. (The version numbering from the previous names was
kept.)

## The name

Naming things is hard.

The tool was about uploading and downloading data specified with a URL. It
would show the data (by default). The user would "see" the URL perhaps and
"see" then spelled with the single letter 'c'. It was also a client-side
program, a URL client. So 'c' for Client and URL: cURL.

Nothing more was needed so the name was selected and we never looked back
again.

Later on, someone suggested that curl could actually be a clever "backronym"
(where the first letter in the acronym refers back to the same word): "Curl
URL Request Library"

While that is awesome, it was actually not the original thought. We sort of
wish we were that clever though...

There are and were other projects using the name curl in various ways, but we
were not aware of them by the time our curl came to be.

## What does curl do?

cURL is a project and its primary purpose and focus is to make two products:

- curl, the command line tool

- libcurl the transfer library with a C API

Both the tool and the library do internet transfers for resources specified as
URLs using internet protocols.

Everything and anything that is related to internet protocol transfers can be
considered curl's business. Things that are not related to that should be
avoided and be left for other projects and products.

It could be important to also consider that curl and libcurl try to avoid
handling the actual data that is transferred. It has for example no knowledge
about HTML or anything else of the content that is popular to transfer over
HTTP, but it knows all about how to transfer such data over HTTP.

Both products are frequently used not only to drive thousands or millions
scripts and applications for an internet connection world, but also for a lot
of server testing, protocol fiddling and trying out new things.

The library is used in every imaginable sort of embedded device where internet
transfers are needed: car infotainment, televisions, blurayplayers, settop
boxes, printers, routers, game systems etc.

### Command line tool

Running curl from the command line, it was natural and Daniel never even
during a short moment considered anything else than that it would output data
on stdout, to the terminal, by default. The "everything is a pipe" mantra of
standard Unix philosophy was something Daniel believed in. curl is like 'cat'
or one of the other unix tools. It sends data to stdout to make it easy to
chain together with other tools to do what you want. That's also why virtually
all curl options that allow reading from a file or writing to a file, also
have the ability to select doing it to stdout or from stdin.

Following that style of what unix command line tools worked, it was also never
any question about that it should support multiple URLs on the command line.

## Project communication

cURL is a an open source project consisting of voluntary members from all over
the world, living and working in a large amount of the world's time zones. To
make such a setup actually work, communication and openness is key. We keep
all communication public and we use open communication channels. Most
discussions are held on mailing lists, we use bug trackers where all issues
are discussed and handled with full insight for everyone who cares to look.

It is important to realize that we're all jointly taking care of the project,
we fix problems and we add features. Sometimes a regular contributor grows
bored and fades away, sometimes a new eager contributor steps out from the
shadows and start helping out more. To keep this ship going forward as good as
possible it is important that we maintain open discussions and that's one of
the reasons why we frown upon users who take discussions privately or try to
email individual develop team members for development issues, questions,
debugging or whatever.

In this day and age, mailing lists may be considered sort of the old style of
communication - no fancy web forum or similar. Using a mailing list is
therefore become an art that isn't practiced everywhere and may be a bit
strange and unusual to you. But fear not. It is just about sending emails to
an address that then sends that email out to all the subscribers. Our mailing
lists have at most a few thousand subscribers. If you're mailing for the first
time, it might be good to read a few old mails first to get to learn the
culture and what's considered good practice.

The mailing lists and the bug tracker have changed hosting providers a few
times and there are reasons to suspect it might happen again in a future. It
is just things that happen to a project that lives for a long time.

A few users also hang out on IRC in the #curl channel on freenode.

### Mailing list etiquette

As many communities and sub cultures, we have developed guidelines and rules
of what we think is the right way to behave and how to communicate on the
mailing lists. The [curl mailing list
etiquette](http://curl.haxx.se/mail/etiquette.html) follows the style of
traditional open source projects.

#### Do Not Mail a Single Individual

Many people send one question to one person. One person gets many mails, and
there is only one person who can give you a reply. The question may be
something that other people are also wanting to ask. These other people have
no way to read the reply, but to ask the one person the question. The one
person consequently gets overloaded with mail.

If you really want to contact an individual and perhaps pay for his or her
services, by all means go ahead, but if it's just another curl question, take
it to a suitable list instead.

#### Reply or New Mail

Please do not reply to an existing message as a short-cut to post a message to
the lists.

Many mail programs and web archivers use information within mails to keep them
together as "threads", as collections of posts that discuss a certain
subject. If you don't intend to reply on the same or similar subject, don't
just hit reply on an existing mail and change subject, create a new mail.

#### Reply to the List

When replying to a message from the list, make sure that you do "group reply"
or "reply to all", and not just reply to the author of the single mail you
reply to.

We're actively discouraging replying back to the single person by setting the
Reply-To: field in outgoing mails back to the mailing list address, making it
harder for people to mail the author only by mistake.

#### Use a Sensible Subject

Please use a subject of the mail that makes sense and that is related to the
contents of your mail. It makes it a lot easier to find your mail afterwards
and it makes it easier to track mail threads and topics.

#### Do Not Top-Post

If you reply to a message, don't use top-posting. Top-posting is when you
write the new text at the top of a mail and you insert the previous quoted
mail conversation below. It forces users to read the mail in a backwards order
to properly understand it.

This is why top posting is so bad:

    A: Because it messes up the order in which people normally read text.
    Q: Why is top-posting such a bad thing?
    A: Top-posting.
    Q: What is the most annoying thing in e-mail?

Apart from the screwed up read order (especially when mixed together in a
thread when someone responds using the mandated bottom-posting style), it also
makes it impossible to quote only parts of the original mail.

When you reply to a mail. You let the mail client insert the previous mail
quoted. Then you put the cursor on the first line of the mail and you move
down through the mail, deleting all parts of the quotes that don't add context
for your comments. When you want to add a comment you do so, inline, right
after the quotes that relate to your comment. Then you continue downwards
again.

When most of the quotes have been removed and you've added your own words,
you're done!

#### HTML is not for mails

Please switch off those HTML encoded messages. You can mail all those funny
mails to your friends. We speak plain text mails.

#### Quoting

Quote as little as possible. Just enough to provide the context you cannot
leave out. A lengthy description can be found
[here](https://www.netmeister.org/news/learn2quote.html).

#### Digest

We allow subscribers to subscribe to the "digest" version of the mailing
lists. A digest is a collection of mails lumped together in one single mail.

Should you decide to reply to a mail sent out as a digest, there are two
things you MUST consider if you really really cannot subscribe normally
instead:

Cut off all mails and chatter that is not related to the mail you want to
reply to.

Change the subject name to something sensible and related to the subject,
preferably even the actual subject of the single mail you wanted to reply to

#### Please Tell Us How You Solved The Problem!

Many people mail questions to the list, people spend some of their time and
make an effort in providing good answers to these questions.

If you are the one who asks, please consider responding once more in case one
of the hints was what solved your problems. The guys who write answers feel
good to know that they provided a good answer and that you fixed the
problem. Far too often, the person who asked the question is never heard of
again, and we never get to know if he/she is gone because the problem was
solved or perhaps because the problem was unsolvable!

Getting the solution posted also helps other users that experience the same
problem(s). They get to see (possibly in the web archives) that the suggested
fixes actually has helped at least one person.

## Mailing lists

Some of the most important mailing lists are...

### curl-users

The main mailing list for users and developers of the curl command line
tool. Questions and help around curl concepts, command line options, the
protocols curl can speak or even related tools. We tend to move development
issues or more advanced bug fixes discussions over to curl-library instead,
since libcurl is the engine that drives most of curl.

See http://cool.haxx.se/mailman/listinfo/curl-users

### curl-library

The main development list, and also for users of libcurl. We discuss how to
use libcurl in applications as well as development of libcurl itself. Lots of
questions on libcurl behavior, debugging and documentation issues.

See http://cool.haxx.se/mailman/listinfo/curl-library

### curl-announce

This mailing list that only gets announcements about new releases and security
problems. Nothing else. For those who wants a more casual feed of information
from the project. http://cool.haxx.se/mailman/listinfo/curl-announce

## Reporting bugs

The development team does a lot of testing. We have a whole test suite that is
run frequently every day on numerous platforms to in order to exercise all
code and make sure everything works as supposed.

Still, there are times when things aren't working the way they should. Then we
appreciate getting those problems reported.

### A bug is a problem

Any problem can be considered a bug. A weirdly phrased wording in the manual
that prevents you from understanding something is a bug. A surprising side
effect of combining multiple options can be a bug - or perhaps it should be
better documented? Perhaps the option doesn't do at all what you expected it
to? That's a problem and we should fix it!

### Problems must be known to get fixed

This may sound easy and uncomplicated but is a fundamental truth in our and
other projects. Just because it is an old project and have thousands of users
don't mean that the development team knows about the problem you just fell
over. Maybe users haven't paid enough attention to details like you, or
perhaps it just never triggered for anyone else.

We rely on users experiencing problems to report them. We need to learn the
problems exist so that we can fix them.

### Fixing the problems

Software engineering is to a very large degree about fixing problems. To fix a
problem a developer needs to understand how to repeat it and to do that the
debugging person needs to be told what set of circumstances that made the
problem trigger.

### A good bug report

A good report explains what happened and what you thought was going to
happen. Tell us exactly what versions of the different components you used and
take us step by step through what you do to get the problem.

After you submitted a bug report, you can expect there to be follow-up
questions or perhaps requests that you try out varies things and tasks in
order for the developer to be able to narrow down the suspects and make sure
your problem is being cornered in properly.

Bug reports that are submitted by is abandoned by the submitter risk getting
closed if the developer fail to understand it, fail to report it or face other
problems when working on it. Don't abandon your report!

Report curl bugs in the [curl bug tracker on
github](https://github.com/bagder/curl/issues)!

## Testing

Testing software thoroughly and properly is a lot of work. Testing software
that runs on dozens on operating systems and dozens of CPU architectures with
server implementations with their owns sets of bugs and interpretations of the
specs even more so.

The curl project has a test suite that when run iterates over all existing
test cases, runs the test and verifies that the outcome is the correct one
and that no other problem happened - like a memory leak or something fishy in
the protocol layer.

The test suite is meant to be possible to run after you've built curl yourself
and there are a fair amount of volunteers who also help out by running the
test suite automatically a few days per day to make sure the latest commits
get a run. This way, we hopefully discover the worst flaws pretty soon after
they were introduced.

We don't test everything and even when we try to test things there will always
be subtle details that get through and that we, sometimes years after the
fact, figure out was wrong.

Due to the nature of different systems and funny use cases on the Internet,
eventually some of the best testing is done by users when they run the code to
perform their uses cases.

Another limiting factor with the test suite is that the test setup itself is
less portable than curl and libcurl so there are in fact platforms where curl
runs fine but the test suite cannot execute at all.

## Releases

A release in the curl project means packaging up all the source code that is
in the master branch of the code repository, signing the package, tagging the
point in time in the code repo, and then putting it up on the web site for the
world to download.

It is one single source code archive for all platforms curl can run on. It is
the one and only package for both curl and libcurl.

We never ship any curl or libcurl _binaries_ from the project. All the
packaged binaries that are provided with operating systems or on other
download sites are done by gracious volunteers outside of the project.

As of a few years back, we make an effort to do our releases on an eight week
cycle and unless some really serious and urgent problem shows up we stick to
this schedule. On a Wednesday, and then again a Wednesday eight weeks later
and so it continues. Non-stop.

For every release we tag the source code in the repository with "curl-release
version" and we update the [changelog](http://daniel.haxx.se/changes.html).

## Daily snapshots

Every single change to the source code is committed and pushed to the source
code repository. This repository is hosted on github.com and is using git
these days (but hasn't always been this way). When building curl off the
repository, there are a few things you need to generate and setup that
sometimes cause people some problems or just friction. To help with that, we
provide daily snapshots.

The daily snapshots are generated daily (clever naming, right?) as if a
release had been made at that point in time. It produces a package of all
sources code and all files that are normally part of a release and puts it in
a package and uploads it to a special place
([http://curl.haxx.se/snapshots/](http://curl.haxx.se/snapshots/)) to allow
interested people to get the very latest code. To test, to experiment and
whatever.

The snapshots are only kept for around 20 days until deleted.

## Security

Security is a primary concern for us in the curl project. We take it seriously
and we work hard on providing secure and safe implementations of all protocols
and related code. As soon as we get knowledge about a security related problem
or just a suspected problem, we deal with it and we will attempt to provide a
fix and security notice no later than in the next pending release.

We use a responsible disclosure policy, meaning that we prefer to discuss and
work on security fixes out of the public eye and we alert the vendors on the
openwall.org list a few days before we announce the problem and fix to the
world. This, in an attempt to shorten the time span the bad guys can take
advantage of a problem until a fixed version has been deployed.

### Past security problems

During the years we have had our fair share of security related problems. We
work hard on [documenting every
problem](http://curl.haxx.se/docs/security.html) thoroughly with all details
listed and clearly stated to aid users. Users of curl should be able to figure
out what problems their particular curl versions and use cases are vulnerable
to.

To help with this, we present [this waterfall
chart](http://curl.haxx.se/docs/vulnerabilities.html) showing how all
vulnerabilities affect which curl versions and we have this complete list of
all known security problems since the birth of this project.

## The development team

Daniel Stenberg is the founder and self-proclaimed leader of the
project. Everybody else that participates or contributes in the project has
thus arrived at a later point in time. Some contributors worked for a while
and then left again. Most contributors hang around only for a short while to
get their bug fixed or feature merged or similar. Counting all contributors
we know the names of, we have received help from more than 1300 individuals.

The list of people that have repeatedly shown up in discussions and commits
during the last several years include these stellar individuals:

- Daniel Stenberg
- Steve Holme
- Jay Satiro
- Dan Fandrich
- Marc Hörsken
- Kamil Dudka
- Alessandro Ghedini
- Yang Tse
- Günter Knauf
- Tatsuhiro Tsujikawa
- Patrick Monnerat
- Nick Zitzmann

## Future

There's no slow down in sight in the curl's future, bugs reported, development
pace or how Internet protocols are being developed or updated.

We're looking forward to support for more protocols, support for more features
within the already supported protocols, more and better APIs for libcurl to
allow users to do transfers even better and faster,

The project casually maintains a TODO file holding a bunch of ideas that we
could work on in the future. It also keeps a KNOWN_BUGS document with, yes, a
list of known problems we would like to get fixed.

## Users of curl

We use to say that there are a billion users of curl. It makes a good line to
say but in reality we of course don't have any numbers that exact. We just
estimate and guess based on observations and trends. It also depends on
exactly what you would consider "a user" to be. Let's elaborate.

### Open Source

The project being open source and even very liberally licensed so, means that
just about anyone can re-distribute curl in source format or built into binary
form.

### Counting downloads

The curl command line tool and the libcurl library are available for download
for most operating systems via the curl web site, they are provided via third
party installers to a bunch and and they come installed by default with yet
some operating systems. This makes counting downloads from the curl web site
completely inappropriate as a means of measurement.

### Finding users

So, we can't count downloads and anyone may redistribute it and nobody is
forced to tell us they use curl. How can we figure out the numbers? How can we
figure out the users? The answer is that we really can't with any decent level
of accuracy.

Instead we rely on witness reports, circumstantial evidence, on findings on
the Internet, the occasional "about box" or license agreement mentioning curl
or that authors ask for help and tell us about their use.

The curl license says users need to repeat it somewhere, like in the
documentation, but that's not easy for us to find in many cases and its also
not easy for us to do anything about should they decide not to follow the very
small license requirement.

### Command line tool users

The command line tool curl is widely used by programmers around the world in
shell and batch scripts, to debug servers and to test out things. There's no
doubt it is used by millions every day.

### Embedded library

libcurl is what makes our project reach the really large volume of users. The
ability to quickly and easily get client side file transfer abilities into
your application is desirable for a lot of users, and then libcurl's great
portability also helps: you can write more or less the same application on a
wide variety of platforms and you can still keep using libcurl for transfers.

libcurl being written in C with no or just a few required dependencies also
help to get it used in embedded systems.

libcurl is popularly used in smartphone operating systems, in car infotainment
setups, in television sets, in settop boxes, in audio and video equipment such
as bluray players and higher end receivers. It is often used in home routers
and printers.

A fair number of best-selling games are also using libcurl, on Windows and
game consoles.

### In web site backends

The libcurl binding for PHP was one of, if not the, first bindings for libcurl
to really catch on and get used widely. It quickly got adopted as a default
way for PHP users to transfer data and as it has now been in that position for
over a decade and PHP has turned out to be a fairly popular technology on the
Internet (recent numbers indicated that something like a forth of all sites on
the Internet uses PHP).

A few really high demand sites are using PHP and are using libcurl in the
backend. Facebook and Yahoo are two such sites.
