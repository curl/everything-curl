## The progress meter

curl has a built-in progress meter. When curl is invoked to transfer data
(either uploading or downloading) it can show that meter in the terminal
screen to show how the transfer is progressing. The current transfer speed,
how long it has been going on and how long it thinks it might be left until
completion.

The progress meter is inhibited if curl deems that there is output going to
the terminal, as then would the progress meter interfer with that output and
just mess out what gets displayed. A user can also forcibly switch off the
progress meter with the `-s / --silent` option, which tells curl to hush.

If you invoke curl and don't get the progress meter, make sure your output is
directed somewhere else than the terminal.

curl also features an alternative, and simpler, progress meter that you enable
with `-# / --progress-bar`. As the long name implies, it instead shows the
transfer as progress bar.

At times when curl is asked to transfer data, it can't figure out the total
size of the requested operation and that then subsequently makes the progress
meter contain less details and it cannot for example make forecasts for
transfer times etc.

### Progress meter legend

The progress meter exists to show a user that something actually is
happening. The different fields in the output have the following meaning:

    % Total    % Received % Xferd  Average Speed          Time             Curr.
                                   Dload  Upload Total    Current  Left    Speed
    0  151M    0 38608    0     0   9406      0  4:41:43  0:00:04  4:41:39  9287

From left-to-right:

 - %: percentage completed of the whole transfer
 - Total: total size of the whole expected transfer
 - %: percentage completed of the download
 - Received: currently downloaded amount of bytes
 - %: percentage completed of the upload
 - Xferd: currently uploaded amount of bytes
 - Average Speed Dload: the average transfer speed of the download
 - Average Speed Upload: the average transfer speed of the upload
 - Time Total: expected time to complete the operation
 - Time Current: time passed since the invoke
 - Time Left: expected time left to completion
 - Curr.Speed: the average transfer speed the last 5 seconds (the first 5
   seconds of a transfer is based on less time of course.)
