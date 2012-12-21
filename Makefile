.PHONY: all
all: diary.html

*.html: diary.xsl
%.html: %.xml
	xsltproc diary.xsl $< > $@

.PHONY: clean
clean:
	-rm -f $(patsubst %.xml,%.html,$(wildcard *.xml)) *~
