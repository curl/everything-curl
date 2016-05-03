OUT = bookindex.md

MDS := $(wildcard *.md)

$(OUT): mkindex.pl Makefile $(MDS)
	perl mkindex.pl $(MDS) > $(OUT)
