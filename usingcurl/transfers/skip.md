# Skip download if already done

Sometimes when writing a script or similar to do Internet transfers every now
and then you end up in a situation when you rather have curl skip doing the
transfer if indeed the target file is already present locally. Maybe after the
previous invoke, maybe for another reason.

This kind of extra logic can certainly be added in common shell script logic
before curl is invoked in many cases but not all. For example things get
complicated when you ask curl to use [globbing download
ranges](../../cmdline/urls/globbing.md).

For example, download one thousand images from a site but skip the ones that
we already have downloaded previously:

    curl --skip-existing -O https://example.com/image[0-999].jpg

It should be noted that this only checks the *presence* of the local file, it
makes not attempts to verify that it actually has the correct content and it
has no way to do any such checks.

curl offers other options to do [conditional
transfers](../../http/modify/conditionals.md) based on modified date or
contents.
