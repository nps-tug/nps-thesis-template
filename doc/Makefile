.SUFFIXES: .tex .pdf 
.PHONY: all clean distclean

LATEX=pdflatex
BIBTEX=bibtex

TEXFILES = $(shell find . \( -iname "*.tex" -o -name "*.bib" \) -type f -exec echo "{}" \; | sed 's| |\\ |' | tr '\n' ' ')

# for Mac this includes the .. directory for necessary files
NPSREPORT=$(shell pwd)/..
export TEXINPUTS := $(TEXINPUTS):$(NPSREPORT)
export BSTINPUTS := $(BSTINPUTS):$(NPSREPORT)
export BIBINPUTS := $(BIBINPUTS):$(NPSREPORT)

# for Windows this includes the .. directory for necessary files
ifeq ($(OS),Windows_NT)
    TEXOPTS = --include-directory=..
else
    TEXOPTS = 
endif

ALL := report.pdf

all: $(ALL)

$(ALL): $(TEXFILES) 

#
# Build a pdf from a tex file
#
.tex.pdf:
	$(LATEX) $(TEXOPTS) $*
	-$(BIBTEX) $*
	$(LATEX) $(TEXOPTS) $*
	$(LATEX) $(TEXOPTS) $*

#
# Clean routines
#
clean:
	$(RM) *.log *.aux *.bbl *.blg  *.lof _*_.bib
	$(RM) *.lot *.toc *.out *.tmp *~ *.ain *.gz
	$(RM) *.idx *.ilg *.ind

distclean: clean
	$(RM) $(ALL)
