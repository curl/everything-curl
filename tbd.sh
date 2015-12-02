#!/bin/sh
grep -c "^TBD" `grep -o '[a-z-]*\.md' SUMMARY.md`  | grep -v :0
