.PHONY: all
all: diary.html diary.rss

*.html: diary.html.xsl

*.rss: diary.rss.xsl

%.html: %.xml
	xsltproc diary.html.xsl $< > $@

%.rss: %.xml
	xsltproc diary.rss.xsl $< > $@

.PHONY: clean
clean:
	-rm -f $(patsubst %.xml,%.html,$(wildcard *.xml)) $(patsubst %.xml,%.rss,$(wildcard *.xml)) *~
