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
