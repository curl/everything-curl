# DICT

DICT is a protocol for dictionary lookups.

## Usage

For fun try

    curl dict://dict.org/m:curl
    curl dict://dict.org/d:heisenbug:jargon
    curl dict://dict.org/d:daniel:gcide

Aliases for 'm' are 'match' and 'find', and aliases for 'd' are 'define' and
'lookup'. For example,

    curl dict://dict.org/find:curl

Commands that break the URL description of the RFC (but not the DICT
protocol) are

    curl dict://dict.org/show:db
    curl dict://dict.org/show:strat
