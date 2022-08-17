# Autobuilds

Volunteering individuals run the **autobuilds**. This is a script that runs
automatically that:

- checks out the latest code from the git repository
- builds everything
- runs the test suite
- sends the full log over email to the curl server

As they are then run on different platforms with different build options, they
offer an extra dimension of feedback on curl build health.

## Check status

All logs are parsed, managed and displayed on [the curl
site](https://curl.se/dev/builds.html).

## Legacy

We started the autobuild system in 2003, a decade before [CI jobs](ci.md)
started becoming a serious alternative.

Now, the autobuilds are more of a legacy system as we are moving more and more
into a world with CI and more direct and earlier feedback.
