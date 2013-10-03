.SUFFIXES: .tex .pdf 
.PHONY: all clean distclean

LATEX=pdflatex
BIBTEX=bibtex


#
# Directives for legacy scripts
#
FIXERRORS=echo
AUTHORINDEX=echo
MAKEINDEX=echo

# if using the old nps-*.bst files, we need the fix error script:
ifneq ($(wildcard fixerrors.py),)
FIXERRORS=python fixerrors.py
endif

authors = 0
# if we are using the authors option, we need these scripts
ifeq ($(authors),1)
AUTHORINDEX=perl authorindex.pl
MAKEINDEX=makeindex
endif


#
# Files
#
COMMON = Makefile npsreport.cls nps_sf298.sty nps_thesis.bst
RELEASE = acronyms.tex appendix1.tex chapter1.tex thesis.bib thesis.tex \
          contrib/*.tex contrib/*.pdf \
          nps_sf298.sty nps_thesis.bst npsreport.cls figs/nps_logo*.pdf \
          examples/*.tex doc/NPS-CS-11-011.pdf
TEXFILES = $(shell find . \( -iname "*.tex" -o -name "*.bib" \) -type f -exec echo "{}" \; | sed 's| |\\ |' | tr '\n' ' ')

ifneq ($(wildcard thesis.tex),)
  ALL += thesis.pdf
endif

all: $(ALL)

$(ALL): $(TEXFILES) $(COMMON)

#
# Build a pdf from a tex file
#
.tex.pdf:
	$(LATEX) $*
	-$(BIBTEX) $*
	$(AUTHORINDEX) $*
	$(MAKEINDEX) $*
	$(FIXERRORS) $*
	$(LATEX) $*
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
