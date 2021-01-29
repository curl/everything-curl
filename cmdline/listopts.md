## List all command-line options

curl has more than two hundred command-line options and the number of options
keep increasing over time. Chances are the number of options will reach 250
within a few years.

To find out which options you need to perform as certain action, you can get
curl to list them. First, `curl --help` or simply `curl -h` will get you a
list of the most important and frequently used options. You can then provide
an additional "category" to `-h` to get more options listed for that specific
area. Use `curl -h category` to list all existing categories or `curl -h all`
to list *all* available options.

Before curl 7.73.0, the help category system didn't exist and then `curl
--help` or simply `curl -h` would simply list all existing options in an
alphabetical with a brief explanation next to each.

The `curl --manual` option outputs the entire man page for curl. That is a
thorough and complete document on how each option works amassing several
thousand lines of documentation. To wade through that is also a tedious work
and we encourage use of a search function through those text masses. Some
people will appreciate the man page in its [web
version](https://curl.se/docs/manpage.html).
