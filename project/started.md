# How it started

Back in 1996, [Daniel Stenberg](https://daniel.haxx.se/) was writing an IRC
bot in his spare time, an automated program that would offer services for the
participants in a chatroom dedicated to the Amiga computer (#amiga on the IRC
network EFnet). He came to think that it would be fun to get some updated
currency rates and have his bot offer a service online for the chat room users
to get current exchange rates, to ask the bot "please exchange 200 USD into
SEK" or similar.

In order to have the provided exchange rates as accurate as possible, the bot
would download the rates daily from a website that was hosting them. A small
tool to download data over HTTP was needed for this task. A quick look-around
at the time had Daniel find a tiny tool named httpget (written by the
Brazilian developer Rafael Sagula). It did the job, almost, just needed a few
little tweaks here and there.

Rafael released HttpGet 0.1 on November 11, 1996 and already in the next
release, called 0.2 released in December that year, Daniel had his first
changes included. Soon after that, Daniel had taken over maintenance of the few
hundred lines of code it was.

HttpGet 1.0 was released on April 8 1997 with brand new HTTP proxy support.

We soon found and fixed support for getting currencies over GOPHER. Once FTP
download support was added, the name of the project was changed and urlget 2.0
was released in August 1997. The HTTP-only days were already past.

The project slowly grew bigger. When upload capabilities were added and the
name once again was misleading, a second name change was made and on March 20,
1998 curl 4 was released. (The version numbering from the previous names was
kept.)

We consider **March 20 1998** to be curl's birthday.
