OUT = bookindex.md

MDS := $(shell grep -o '[a-z0-9/-]\+\.md' SUMMARY.md | grep -v index.md) README.md

$(OUT): mkindex.pl Makefile index-words $(MDS)
	perl mkindex.pl $(MDS) > $(OUT)

check: 
	@proselint $(MDS)

wordcheck: 
	@./mgrep $(MDS)

fixup:
	for i in $(MDS); do ./lang.sh $$i; done
