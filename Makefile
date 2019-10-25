# Makefile
# 
# Converts Markdown to other formats (HTML, PDF, DOCX, RTF, ODT, EPUB) using Pandoc
# <http://pandoc.org/>
#
# Run "make" (or "make all") to convert to all other formats
#
# Run "make clean" to delete converted files

# Convert all files in this directory that have a .md suffix
SOURCE_DOCS := $(wildcard *.md)

WEB_DOCS=\
 $(SOURCE_DOCS:.md=.html)

EXPORTED_DOCS=\
 $(SOURCE_DOCS:.md=.html) \
 $(SOURCE_DOCS:.md=.pdf) \
 $(SOURCE_DOCS:.md=.docx) \
 $(SOURCE_DOCS:.md=.rtf) \
 $(SOURCE_DOCS:.md=.odt) \
 $(SOURCE_DOCS:.md=.epub)

RM=/usr/bin/rm

PANDOC=/usr/bin/pandoc

PANDOC_OPTIONS=

PANDOC_HTML_OPTIONS=--template=GitHub.html5 --to html5
PANDOC_PDF_OPTIONS=
PANDOC_DOCX_OPTIONS=
PANDOC_RTF_OPTIONS=
PANDOC_ODT_OPTIONS=
PANDOC_EPUB_OPTIONS=--to epub3

MINIFIER_HTML=html-minifier

MINIFIER_HTML_OPTIONS=--collapse-whitespace --remove-comments --remove-optional-tags --remove-redundant-attributes --remove-script-type-attributes --remove-tag-whitespace --use-short-doctype --minify-css true --minify-js true

# Pattern-matching Rules

%.html : %.md
	$(PANDOC) $(PANDOC_OPTIONS) $(PANDOC_HTML_OPTIONS) $< | $(MINIFIER_HTML) $(MINIFIER_HTML_OPTIONS) > $@

%.pdf : %.md
	$(PANDOC) $(PANDOC_OPTIONS) $(PANDOC_PDF_OPTIONS) -o $@ $<
	
%.docx : %.md
	$(PANDOC) $(PANDOC_OPTIONS) $(PANDOC_DOCX_OPTIONS) -o $@ $<

%.rtf : %.md
	$(PANDOC) $(PANDOC_OPTIONS) $(PANDOC_RTF_OPTIONS) -o $@ $<

%.odt : %.md
	$(PANDOC) $(PANDOC_OPTIONS) $(PANDOC_ODT_OPTIONS) -o $@ $<

%.epub : %.md
	$(PANDOC) $(PANDOC_OPTIONS) $(PANDOC_EPUB_OPTIONS) -o $@ $<


# Targets and dependencies

.PHONY: all clean

all : $(WEB_DOCS)

clean:
	- $(RM) $(EXPORTED_DOCS)
