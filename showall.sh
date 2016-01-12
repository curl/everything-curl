#!/bin/sh
cat README.md `grep -o '[a-z-]*\.md' SUMMARY.md`
