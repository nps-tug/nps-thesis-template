.SUFFIXES: .tex .pdf 
.PHONY: all clean distclean

LATEX=pdflatex
BIBTEX=bibtex

TEXFILES = $(shell find . \( -iname "*.tex" -o -name "*.bib" \) -type f -exec echo "{}" \; | sed 's| |\\ |' | tr '\n' ' ')

# for Mac this includes the .. directory for necessary files
NPSREPORT=$(shell pwd)/.
export TEXINPUTS := $(TEXINPUTS):$(NPSREPORT)
export BSTINPUTS := $(BSTINPUTS):$(NPSREPORT)
export BIBINPUTS := $(BIBINPUTS):$(NPSREPORT)

# for Windows this includes the .. directory for necessary files
ifeq ($(OS),Windows_NT)
    TEXOPTS = --include-directory=.
else
    TEXOPTS = 
endif

#
# Files
#
ifneq ($(wildcard thesis.tex),)
  ALL += thesis.pdf
endif

COMMON = Makefile npsreport.cls nps_sf298.sty nps_thesis.bst
RELEASE = acronyms.tex appendix1.tex chapter1.tex thesis.bib thesis.tex \
          contrib/*.tex contrib/*.pdf \
          nps_sf298.sty nps_thesis.bst npsreport.cls figs/nps_logo*.pdf \
          examples/*.tex examples/*.sty examples/*.bib \
          doc/NPS-CS-11-011.pdf

all: $(ALL)

$(ALL): $(TEXFILES) $(COMMON)

#
# Build a pdf from a tex file
#
.tex.pdf:
	$(LATEX) $(TEXOPTS) $*
	-$(BIBTEX) $(TEXOPTS) $*
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
	$(MAKE) -C doc distclean
	$(MAKE) -C examples distclean
	$(MAKE) -C contrib distclean

#
# Build release
#
.PHONY: release

release: distclean
	$(MAKE) NPS_LaTeX_Template.zip

NPS_LaTeX_Template.zip: $(RELEASE)
	zip $@ $^
