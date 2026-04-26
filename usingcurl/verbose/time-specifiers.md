# Time specifiers

The following conversion specifications are available for the `--write-out`
option's `%time{}` feature:

| flag | outputs                                                                      |
|------|------------------------------------------------------------------------------|
| `%a` | The abbreviated name of the day of the week according to the current locale. |
| `%A` | The full name of the day of the week according to the current locale.        |
| `%b` | The abbreviated month name according to the current locale. |
| `%B` | The full month name according to the current locale. |
| `%c` | The preferred date and time representation for the current locale. (In the POSIX locale this is equivalent to `%a %b %e %H:%M:%S %Y`.) |
| `%C` | The century number (year/100) as a 2-digit integer. |
| `%d` | The day of the month as a decimal number (range 01 to 31). |
| `%D` | Equivalent to `%m/%d/%y`. (This format is ambiguous and should be avoided.) |
| `%e` | Like `%d`, the day of the month as a decimal number, but a leading zero is replaced by a space. |
| `%f` | The number of microseconds elapsed of the current second. (This is a curl special code and not a standard one.) |
| `%F` | Equivalent to `%Y-%m-%d` (the ISO 8601 date format). |
| `%G` | The ISO 8601 week-based year with century as a decimal number. The 4-digit year corresponding to the ISO week number (see `%V`). This has the same format and value as `%Y`, except that if the ISO week number belongs to the previous or next year, that year is used instead. |
| `%g` | Like `%G`, but without century, that is, with a 2-digit year (00-99). |
| `%h` | Equivalent to `%b`. |
| `%H` | The hour as a decimal number using a 24-hour clock (range 00 to 23). |
| `%I` | The hour as a decimal number using a 12-hour clock (range 01 to 12). |
| `%j` | The day of the year as a decimal number (range 001 to 366). |
| `%k` | The hour (24-hour clock) as a decimal number (range 0 to 23); single digits are preceded by a blank. |
| `%l` | The hour (12-hour clock) as a decimal number (range 1 to 12); single digits are preceded by a blank. |
| `%m` | The month as a decimal number (range 01 to 12). |
| `%M` | The minute as a decimal number (range 00 to 59). |
| `%p` | Either "AM" or "PM" according to the given time value, or the corresponding strings for the current locale. Noon is treated as "PM" and midnight as "AM". |
| `%P` | Like `%p` but in lowercase: "am" or "pm" or a corresponding string for the current locale. | 
| `%r` | The time in am or pm notation. |
| `%R` | The time in 24-hour notation (`%H:%M`). For a version including the seconds, see `%T` below. |
| `%s` | The number of seconds since the Epoch, 1970-01-01 00:00:00 +0000 (UTC). |
| `%S` | The second as a decimal number (range 00 to 60). (The range is up to 60 to allow for occasional leap seconds.) See `%f` for microseconds. |
| `%T` | The time in 24-hour notation (`%H:%M:%S`). |
| `%u` | The day of the week as a decimal, range 1 to 7, Monday being 1. |
| `%U` | The week number of the current year as a decimal number, range 00 to 53, starting with the first Sunday as the first day of week 01. See also `%V` and `%W`. |
| `%V` | The ISO 8601 week number (see NOTES) of the current year as a decimal number, range 01 to 53, where week 1 is the first week that has at least 4 days in the new year. See also `%U` and `%W`. |
| `%w` | The day of the week as a decimal, range 0 to 6, Sunday being 0. See also `%u`. |
| `%W` | The week number of the current year as a decimal number, range 00 to 53, starting with the first Monday as the first day of week 01.|
| `%x` | The preferred date representation for the current locale without the time. |
| `%X` | The preferred time representation for the current locale without the date. |
| `%y` | The year as a decimal number without a century (range 00 to 99). |
| `%Y` | The year as a decimal number including the century. |
| `%z` | The `+hhmm` or `-hhmm` numeric timezone (that is, the hour and minute offset from UTC). As time is always UTC, this outputs `+0000`. |
| `%Z` | The timezone name. As time is always UTC, this outputs the UTC timezone name, typically `GMT`. |
| `%%` | A literal `%` character. |
