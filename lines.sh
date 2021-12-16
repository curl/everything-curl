#!/bin/sh

book=`grep -o '[a-z0-9/-]*\.md' SUMMARY.md`

wc -l -- README.md $book | grep -v " total" | sort -nr
