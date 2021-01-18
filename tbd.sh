#!/bin/sh
grep -c "^TBD" `grep -o '[a-z0-9/-]*\.md' SUMMARY.md`  | grep -v :0 | sort -r -h -k2 -t:
