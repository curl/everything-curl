#!/bin/sh

tbd=`cat *.md | grep -c ^TBD`
titles=`cat *.md | grep -c ^#`

words=`cat *.md | wc -w`
lines=`cat *.md | wc -l`

echo "Titles added: $titles"
echo "Sections to go: $tbd"
echo "Words: $words"
echo "Lines: $lines"

complete=`echo "scale=1; ($titles-$tbd)*100/$titles" | bc`

echo "Completeness: $complete %"
