# 2. The cURL project

A funny detail about open source projects is that they're called "projects",
as if they were somehow limited in time or ever can get done. The cURL
"project" is a number of loosly coupled voluntary individuals working on
writing software together with a common mission: to do reliable data transfers
with internet protocols. And giving away the code for free for anyone to use.

## How it started

Back in 1996, [Daniel Stenberg](http://daniel.haxx.se/) was writing an IRC bot
for an Amiga related channel on the IRC network EFnet, when he came to think
that it would be fun to get some updated currency rates and offer a service
online for users to get current exchange rates. To ask the bot "please
exchange 200 USD into SEK" or similar.

To have the exchange rates as accurate as possibly, it would download rates
daily from a web site hosting rates. A small tool to download data over HTTP
was needed for this task. A quick look-around at the time made Daniel find a
tiny tool named httpget (written by a Brazilian named Rafael Sagula). It did
the job, almost, just needed a little a tweaks here and there and soon Daniel
had taken over maintenance of the few hundered lines of code it was.

HttpGet 1.0 was released on April 8th 1997 with brand new HTTP proxy support.

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
(where the first letter in the akronym refers back to the same word): "Curl
URL Request Library"

While that is awesome, it was actually not the original thought. We sort of
wish we were that clever though...

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
handling the actual data that is transfered. It has for example no knowledge
about HTML or anything else of the content that is popular to transfer over
HTTP, but it knows all about how to transfer such data over HTTP.

Both products are frequently used not only to drive thousands or millions
scripts and applications for an internet connection world, but also for a lot
of server testing, protocol fiddling and trying out new things.

The library is used in every imaginable sort of embedded device where internet
transfers are needed: car infotainment, televisions, blurayplayers, settop
boxes, printers, routers, game systems etc.

## Communication

cURL is a an open source project consisting of voluntary members from all over
the world. To make this work, communication and openness is key. We keep all
communication public and we use open communication channels. Most discussions
are held on mailing lists, we use bug trackers where all issues are discussed
and handled with full insight for everyone who cares to look.

It is important to realize that we're all jointly taking care of the project,
we fix problems and we add features. Sometimes a regular contributer grows
bored and fades away, sometimes a new eager contributer steps out from the
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

The mailing lists and the bug tracker have changed hostings a few times and
there are reasons to suspect it might happen again in a future. It is just
things that happen to a project that lives for a long time.

A few users also hang out on IRC in the #curl channel on freenode.

### Mailing list etiquette

As many communities and sub cultures, we have developed guidelines and rules
of what we think is the right way to behave and how to communicate on the
mailing lists. The [curl mailing list
etiquette](http://curl.haxx.se/mail/etiquette.html) follows the style of
traditional open source projects, nothing new there if you're used to this
culture but it could be worth checking out if you're new in the area.

### curl-users

The main mailing list for users and developers of the curl command line
tool. See http://cool.haxx.se/mailman/listinfo/curl-users

### curl-library

The main development list, and also for users of libcurl. See
http://cool.haxx.se/mailman/listinfo/curl-library

### curl-announce

The mailing list that only gets announcements about new releases and security
problems. Nothing else. For those who wants a more casual feed of information
from the project. http://cool.haxx.se/mailman/listinfo/curl-announce

## Reporting bugs

The development team does a lot of testing. We have a whole test suite that is
run freuquently every day on numerous platforms to in order to exercise all
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

This may sound easy and uncomplicted but is a fundamental truth in our and
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

### A good report

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

## Releases

## Security

## The development team

## Future

## Users of curl
