.SUFFIXES: .tex .pdf 
.PHONY: all clean distclean

LATEX=pdflatex
BIBTEX=bibtex

TEXFILES = $(shell find . \( -iname "*.tex" -o -name "*.bib" \) -type f -exec echo "{}" \; | sed 's| |\\ |' | tr '\n' ' ')

NPSREPORT=$(shell pwd)/..
export TEXINPUTS := $(TEXINPUTS):$(NPSREPORT)
export BSTINPUTS := $(BSTINPUTS):$(NPSREPORT)
export BIBINPUTS := $(BIBINPUTS):$(NPSREPORT)

ALL := dissertation.pdf
ALL += technical_report.pdf
ALL += technical_report_many_authors technical_report_chapters.pdf
ALL += cs_thesis_proposal.pdf
ALL += thesis_mult_appendix.pdf
ALL += thesis_author_advisor_reader.pdf thesis_twoauthor.pdf
ALL += thesis_coadvisors.pdf thesis_coadvisors_reader.pdf
ALL += thesis_twoauthor_coadvisors_reader.pdf

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