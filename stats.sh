#!/bin/sh

abook=`grep -io '[a-z0-9/-]*\.md' SUMMARY.md | grep -v index.md`
book="README.md $abook"

tbd=`cat $book | grep -c ^TBD`
titles=`cat $book | grep -c ^#`
content=`echo "$titles-$tbd" | bc`

words=`cat $book | wc -w`
lines=`cat $book | wc -l`
nonspace=`cat $book | tr -d ' #\n' | wc -c`

echo "Section titles: $titles"
#echo "Sections with content: $content"
#echo "Sections to go: $tbd"
echo "Words: $words"
echo "Lines: $lines"
echo "Non-space bytes: $nonspace"

wordlen=`echo "scale=2; $nonspace / $words" | bc`
echo "Average word length: $wordlen characters"

complete=`echo "scale=1; $content*100/$titles" | bc`
secsize=`echo "$words/$content" | bc`

echo "Words per section: $secsize"
#echo "Completeness: $complete %"

left=`echo "$tbd * $secsize" | bc`
total=`echo "$secsize * $titles" | bc`
#echo "Estimated $left words left until $total"
