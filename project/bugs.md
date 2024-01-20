# Reporting bugs

The development team does a lot of testing. We have a whole test suite that is
run frequently every day on numerous platforms in order to exercise all
code and make sure everything works as expected.

Still, there are times when things do not work the way they should, and we 
depend on people reporting it to us.

## A bug is a problem

Any problem can be considered a bug. A weirdly phrased wording in the manual
that prevents you from understanding something is a bug. A surprising side
effect of combining multiple options can be a bug—or perhaps it should be
better documented? Perhaps the option does not do at all what you expected it
to? That is a problem and we should fix it.

## Problems must be known to get fixed

This may sound easy and uncomplicated but is a fundamental truth in our and
other projects. Just because it is an old project and has thousands of users
does not mean the development team knows about the problem you just stumbled 
into. Maybe users have not paid attention to details as much as you have, or
perhaps it just never triggered for anyone else.

We rely on users experiencing problems to report them. We need to know of 
their existence in order to fix them.

## Fixing the problems

Software engineering is, to a large degree, about fixing problems. To fix a
problem a developer needs to understand how to repeat it, and to do that they
need to be told what set of circumstances triggered the problem.

## A good bug report

A good report explains what happened and what you thought was going to
happen. Tell us exactly what versions of the different components you used and
take us step by step through what you did to arrive at the problem.

After you submit a bug report, you can expect there to be follow-up questions
or perhaps requests that you try out various things so the developer can
narrow down the suspects and make sure your problem is properly located.

A bug report that is submitted then abandoned by the submitter risks getting
closed if the developer fails to understand it, fails to reproduce it or faces
other problems when working on it. Do not abandon your report.

Report curl bugs in the [curl bug tracker on
GitHub](https://github.com/curl/curl/issues).

## Testing

Testing software thoroughly and properly is a lot of work. Testing software
that runs on dozens of operating systems and CPU architectures, with
server implementations which have their own sets of bugs and interpretations 
of the specs, is even more work.

The curl project has a test suite that iterates over all existing test cases, 
runs each test and verifies that the outcome is correct and that no other 
problem happened, such as a memory leak or something fishy in the protocol layer.

The test suite is meant to be run after you have built curl yourself. There are 
a number of volunteers who also help out by running the test suite 
automatically a few times per day to make sure the latest commits are tested. 
This way we discover the worst flaws not long after their introduction.

We do not test everything, and even when we try to test things there are
always subtle bugs that get through, some that are only discovered years
later.

Due to the nature of different systems and funny use cases on the Internet,
eventually some of the best testing is done by users when they run the code to
perform their own use cases.

Another limiting factor with the test suite is that the test setup itself is
less portable than curl and libcurl, so there are in fact platforms where curl
runs fine but the test suite cannot execute at all.
