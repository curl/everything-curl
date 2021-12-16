#!/bin/sh

# Check for "banned" forms of popular words

grep -nf badwords.txt "$@"
