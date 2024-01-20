# Progress meter

curl has a built-in progress meter. When curl is invoked to transfer data
(either uploading or downloading) it can show that meter in the terminal
screen to show how the transfer is progressing, namely the current transfer speed,
how long it has been going on and how long it thinks it might be left until
completion.

The progress meter is inhibited if curl deems that there is output going to
the terminal, as the progress meter would interfere with that output and
just mess up what gets displayed. A user can also forcibly switch off the
progress meter with the `-s / --silent` option, which tells curl to hush.

If you invoke curl and do not get the progress meter, make sure your output is
directed somewhere other than the terminal.

curl also features an alternative and simpler progress meter that you enable
with `-# / --progress-bar`. As the long name implies, it instead shows the
transfer as a progress bar.

At times when curl is asked to transfer data, it cannot figure out the total
size of the requested operation and that then subsequently makes the progress
meter contain fewer details and it cannot, for example, make forecasts for
transfer times, etc.

## Units

The progress meter displays bytes and bytes per second.

It also uses suffixes for larger amounts of bytes, using the 1024 base system
so 1024 is one kilobyte (1K), 2048 is 2K, etc. curl supports these:

| Suffix  |  Amount | Name      |
|---------|---------|-----------|
| K       | 2^10    | kilobyte  |
| M       | 2^20    | megabyte  |
| G       | 2^30    | gigabyte  |
| T       | 2^40    | terabyte  |
| P       | 2^50    | petabyte  |

The times are displayed using H:MM:SS for hours, minutes and seconds.

## Progress meter legend

The progress meter exists to show a user that something actually is
happening. The different fields in the output have the following meaning:

    % Total  % Received % Xferd Average Speed          Time             Curr.
                                Dload  Upload Total    Current  Left    Speed
    0  151M  0 38608    0     0  9406      0  4:41:43  0:00:04  4:41:39  9287

From left to right:

| Title                  | Meaning                                                                                                                                           |
|------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------|
| `%`                    | Percentage completed of the whole transfer                                                                                                        |
| `Total`                | Total size of the whole expected transfer (if known)                                                                                              |
| `%`                    | Percentage completed of the download                                                                                                              |
| `Received`             | Currently downloaded number of bytes                                                                                                              |
| `%`                    | Percentage completed of the upload                                                                                                                |
| `Xferd`                | Currently uploaded number of bytes                                                                                                                |
| `Average Speed Dload`  | Average transfer speed of the entire download so far, in number of bytes per second                                                               |
| `Average Speed Upload` | Average transfer speed of the entire upload so far, in number of bytes per second                                                                 |
| `Time Total`           | Expected time to complete the operation, in `HH:MM:SS` notation for hours, minutes and seconds                                                      |
| `Time Current`         | Time passed since the start of the transfer, in `HH:MM:SS` notation for hours, minutes and seconds                                                  |
| `Time Left`            | Expected time left to completion, in `HH:MM:SS` notation for hours, minutes and seconds                                                             |
| `Curr. Speed`          | Average transfer speed over the last 5 seconds (the first 5 seconds of a transfer is based on less time, of course) in number of bytes per second |
