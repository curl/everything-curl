# Many options and URLs

As mentioned above, curl supports hundreds of command-line options and it also
supports an unlimited number of URLs. If your shell or command-line system
supports it, there is really no limit to how long a command line you can pass
to curl.

curl parses the entire command line first, apply the wishes from the
command-line options used, and then go over the URLs one by one (in a left to
right order) to perform the operations.

For some options (for example `-o` or `-O` that tell curl where to store the
transfer), you may want to specify one option for each URL on the command
line.

curl returns an exit code for its operation on the last URL used. If you
instead rather want curl to exit with an error on the first URL in the set
that fails, use the `--fail-early` option.

## One output for each given URL

If you use a command-line with two URLs, you must tell curl how to handle both
of them. The `-o` and `-O` options instruct curl how to save the output for
*one* URL of the URLs, so you might want to have as many of those options as
you have URLs on the command line.

If you have more URLs than output options on the command line, the URL content
without a corresponding output instruction then instead gets sent to stdout.

Using the `--remote-name-all` flag automatically makes curl act as if `-O` was
used for all given URLs that do not have any output option.

## Separate options per URL

In previous sections we described how curl always parses all options in the
whole command line and applies those to all the URLs that it transfers.

That was a simplification: curl also offers an option (`-:`, `--next`) that
inserts a boundary between a set of options and URLs for which it applies the
options. When the command-line parser finds a `--next` option, it applies the
following options to the next set of URLs. The `--next` option thus works as a
*divider* between a set of options and URLs. You can use as many `--next`
options as you please.

As an example, we do an HTTP GET to a URL and follow redirects, we then make a
second HTTP POST to a different URL and we round it up with a HEAD request to
a third URL. All in a single command line:

    curl --location http://example.com/1 --next
      --data sendthis http://example.com/2 --next
      --head http://example.com/3

Trying something like that _without_ the `--next` options on the command line
would generate an illegal command line since curl would attempt to combine
both a POST and a HEAD:

    Warning: You can only select one HTTP request method! You asked for both
    Warning: POST (-d, --data) and HEAD (-I, --head).
