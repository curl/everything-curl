#!/bin/sh
grep -c "^TBD" README.md `grep -o '[a-z0-9/-]*\.md' SUMMARY.md`  | grep -v :0 | head -n1

