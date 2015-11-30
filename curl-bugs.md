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
