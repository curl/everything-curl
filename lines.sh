#!/bin/sh

book=`grep -o '[/a-z-]*\.md' SUMMARY.md`

wc -l -- README.md $book | grep -v " total" | sort -nr
