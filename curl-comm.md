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
therefore becoming an art that isn't practiced everywhere and may be a bit
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
etiquette](https://curl.haxx.se/mail/etiquette.html) follows the style of
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

See https://cool.haxx.se/mailman/listinfo/curl-users

### curl-library

The main development list, and also for users of libcurl. We discuss how to
use libcurl in applications as well as development of libcurl itself. Lots of
questions on libcurl behavior, debugging and documentation issues.

See https://cool.haxx.se/mailman/listinfo/curl-library

### curl-announce

This mailing list that only gets announcements about new releases and security
problems. Nothing else. For those who wants a more casual feed of information
from the project. https://cool.haxx.se/mailman/listinfo/curl-announce
