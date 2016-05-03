OUT = bookindex.md

MDS := $(shell grep -o '[a-z-]*\.md' SUMMARY.md | grep -v index.md)

$(OUT): mkindex.pl Makefile $(MDS)
	perl mkindex.pl $(MDS) > $(OUT)
