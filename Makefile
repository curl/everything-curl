OUT = bookindex.md

MDS := $(shell grep -o '[a-z0-9/-]\+\.md' SUMMARY.md | grep -v bookindex.md) README.md

IMDS := $(shell grep -o '[a-z0-9/-]\+\.md' SUMMARY.md | grep -vE '(bookindex.md|how-to-read.md)') README.md

$(OUT): mkindex.pl Makefile index-words $(IMDS)
	@echo "generates $(OUT)"
	@perl mkindex.pl $(IMDS) > $(OUT)

mdcheck: 
	@./checkmd $(MDS)

check: 
	@proselint $(MDS)

wordcheck: 
	@./mgrep $(MDS)

fixup:
	for i in $(MDS); do ./lang.sh $$i; done

uni.md: uni.pl $(MDS) SUMMARY.md $(OUT)
	./uni.pl SUMMARY.md >$@

everything-curl.html: uni.md $(MDS)
	pandoc -o everything-curl.html uni.md
	rm -rf everything-curl
	mkdir -p everything-curl
	cp -p `grep -oe 'img src="[0-9a-z/.-]*' everything-curl.html | cut -c10-` everything-curl/
	cp everything-curl.html everything-curl/index.html
	zip -r everything-curl.zip everything-curl

html: everything-curl.html

everything-curl.pdf:	uni.md
	pandoc -o everything-curl.pdf pdf.txt uni.md --toc

pdf: everything-curl.pdf

everything-curl.epub:	uni.md
	pandoc -o everything-curl.epub --epub-cover-image=cover.jpg epub.txt uni.md

epub: everything-curl.epub

clean:
	rm -f uni.md everything-curl.pdf
