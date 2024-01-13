# TLS versions

SSL was invented in the mid 90s and has developed ever since. SSL version 2
was the first widespread version used on the Internet but that was deemed
insecure already a long time ago. SSL version 3 took over from there, and it
too has been deemed not safe enough for use.

TLS version 1.0 was the first standard. RFC 2246 was published 1999. TLS 1.1
came out in 2006, further improving security, followed by TLS 1.2 in 2008. TLS
1.2 came to be the gold standard for TLS for a decade.

TLS 1.3 (RFC 8446) was finalized and published as a standard by the IETF in
August 2018. This is the most secure and fastest TLS version as of date. It is
however so new that a lot of software, tools and libraries do not yet support
it.

curl is designed to use a secure version of SSL/TLS by default. It means that
it does not negotiate SSLv2 or SSLv3 unless specifically told to, and in fact
several TLS libraries no longer provide support for those protocols so in many
cases curl is not even able to speak those protocol versions unless you make a
serious effort.

| Option    | Use                |
|-----------|--------------------|
| --sslv2   | SSL version 2      |
| --sslv3   | SSL version 3      |
| --tlsv1   | TLS >= version 1.0 |
| --tlsv1.0 | TLS >= version 1.0 |
| --tlsv1.1 | TLS >= version 1.1 |
| --tlsv1.2 | TLS >= version 1.2 |
| --tlsv1.3 | TLS >= version 1.3 |

