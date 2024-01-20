# Protocols

The language used to ask for data to get sent—in either direction—is
called **the protocol**. The protocol describes exactly how to ask the server
for data, or to tell the server that there is data coming.

Protocols are typically defined by the IETF ([Internet Engineering Task
Force](https://www.ietf.org/)), which hosts RFC documents that describe exactly
how each protocol works: how clients and servers are supposed to act and what
to send and so on.

## What protocols does curl support?

curl supports protocols that allow data transfers in either or both
directions. We usually also restrict ourselves to protocols which have a URI
format described in an RFC or at least is somewhat widely used, as curl works
primarily with URLs (URIs really) as the input key that specifies the
transfer.

The latest curl (as of this writing) supports these protocols:

DICT, FILE, FTP, FTPS, GOPHER, GOPHERS, HTTP, HTTPS, IMAP, IMAPS, LDAP, LDAPS,
MQTT, POP3, POP3S, RTMP, RTSP, SCP, SFTP, SMB, SMBS, SMTP, SMTPS, TELNET, TFTP,
WS, WSS

To complicate matters further, the protocols often exist in different versions
or flavors as well.

## What other protocols are there?

The world is full of protocols, both old and new. Old protocols get abandoned
and dropped and new ones get introduced. There is never a state of stability but
the situation changes from day to day and year to year. You can rest assured
that there will be new protocols added in the list above in the future and that
there will be new versions of the protocols already listed.

There are, of course, already other protocols in existence that curl does not yet
support. We are open to supporting more protocols that suit the general curl
paradigms, we just need developers to write the necessary code adjustments for
them.

## How are protocols developed?

Both new versions of existing protocols and entirely new protocols are usually
developed by persons or teams that feel that the existing ones are not good
enough. Something about them makes them not suitable for a particular use case
or perhaps some new idea has popped up that could be applied to improve
things.

Of course, nothing prevents anyone from developing a protocol entirely on their
own at their own pleasure in their own backyard, but the major protocols are
usually brought to the IETF at a fairly early stage where they are then
discussed, refined, debated and polished and then eventually, ideally, turned
into a published RFC document.

Software developers then read the RFC specifications and deploy their code in
the world based on their interpretations of the words in those documents. It
sometimes turns out that some of the specifications are subject to vastly
different interpretations or sometimes the engineers are just lazy and ignore
sound advice in the specs and deploy something that does not adhere.
Writing software that interoperates with other implementations of the
specifications can therefore end up being hard work.

## How much do protocols change?

Like software, protocol specifications are frequently updated and new protocol
versions are created.

Most protocols allow some level of extensibility which makes new extensions
show up over time, extensions that make sense to support.

The interpretation of a protocol sometimes changes even if the spec remains the
same.

The protocols mentioned in this chapter are all *Application Protocols*, which
means they are transferred over more lower level protocols, like TCP, UDP and
TLS. They are also themselves protocols that change over time, get new
features and get attacked so that new ways of handling security, etc., forces
curl to adapt and change.

## About adhering to standards and who is right

Generally, there are protocol specs that tell us how to send and receive data
for specific protocols. The protocol specs we follow are RFCs put together and
published by IETF.

Some protocols are not properly documented in a final RFC, like, for example,
SFTP for which our implementation is based on an Internet-draft that is not
even the last available one.

Protocols are, however, spoken by two parties and like in any given
conversation, there are then two sides of understanding something or
interpreting the given instructions in a spec. Also, lots of network software
is written without the authors paying close attention to the spec so they end
up taking some shortcuts, or perhaps they just interpreted the text
differently. Sometimes even mistakes and bugs make software behave in ways
that are not mandated by the spec and sometimes even downright forbidden in
the specs.

In the curl project we use the published specs as rules on how to act until we
learn anything else. If popular alternative implementations act differently
than what we think the spec says and that alternative behavior is what works
widely on the big Internet, then chances are we change foot and instead decide
to act like those others. If a server refuses to talk with us when we think we
follow the spec but works fine when we bend the rules ever so slightly, then
we probably end up bending them exactly that way—if we can still work
successfully with other implementations.

Ultimately, it is a personal decision and up for discussion in every case
where we think a spec and the real world do not align.

In the worst cases we introduce options to let application developers and curl
users have the final say on what curl should do. I say worst because it is
often really tough to ask users to make these decisions as it usually involves
tricky details and weirdness going on and it is a lot to ask of users. We
should always do our best to avoid pushing such protocol decisions to users.
