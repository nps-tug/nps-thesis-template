.SUFFIXES: .tex .pdf 
.PHONY: all clean distclean

LATEX=pdflatex
BIBTEX=bibtex

TEXFILES = $(shell find . \( -iname "*.tex" -o -name "*.bib" \) -type f -exec echo "{}" \; | sed 's| |\\ |' | tr '\n' ' ')

ifneq ($(wildcard thesis.tex),)
  ALL += thesis.pdf
endif

all: $(ALL)

$(ALL): $(TEXFILES) 

#
# Build a pdf from a tex file
#
.tex.pdf:
	$(LATEX) $*
	-$(BIBTEX) $*
	$(LATEX) $*
	$(LATEX) $*

#
# Clean routines
#
clean:
	$(RM) *.log *.aux *.bbl *.blg  *.lof _*_.bib
	$(RM) *.lot *.toc *.out *.tmp *~ *.ain *.gz
	$(RM) *.idx *.ilg *.ind

distclean: clean
	$(RM) $(ALL)
