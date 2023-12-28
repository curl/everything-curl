# HTTP PUT

The difference between a PUT and a POST is subtle. They are virtually
identical transmissions except for the different method strings. Where POST is
meant to pass on data to a remote resource, PUT is supposed to be the new
version of that resource.

In that aspect, PUT is similar to good old standard file upload found in other
protocols. You upload a new version of the resource with PUT. The URL
identifies the resource and you point out the local file to put there:

    curl -T localfile http://example.com/new/resource/file

`-T` implies a PUT and tell curl which file to send off. But the similarities
between POST and PUT also allows you to send a PUT with a string by using the
regular curl POST mechanism using `-d` but asking for it to use a PUT instead:

    curl -d "data to PUT" -X PUT http://example.com/new/resource/file
