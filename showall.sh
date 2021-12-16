#!/bin/sh
cat -- README.md `grep -o '[a-z0-9/-]*\.md' SUMMARY.md`
