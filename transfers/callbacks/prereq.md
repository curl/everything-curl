# Prereq

"Prereq" here means immediately before the request is issued. That is the
moment where this callback is called.

Set the function with `CURLOPT_PREREQFUNCTION` and it gets called and passed
on the used IP address and port numbers in the arguments. This allows the
application to know about the transfer just before it starts and also allows
it to cancel this particular transfer should it want to.
