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

ALL := dissertation.pdf
ALL += technical_report.pdf
ALL += technical_report_many_authors.pdf technical_report_chapters.pdf
ALL += cs_thesis_proposal.pdf
ALL += thesis_mult_appendix.pdf
ALL += thesis_author_advisor_reader.pdf thesis_twoauthor.pdf
ALL += thesis_author_advisor_tworeaders.pdf thesis_dual_degree.pdf
ALL += thesis_coadvisors.pdf thesis_coadvisors_reader.pdf
ALL += thesis_twoauthor_coadvisors_reader.pdf
ALL += thesis_fouo.pdf thesis_fouo_abstract.pdf
ALL += thesis_classified.pdf thesis_distro_statement.pdf
ALL += thesis_exec_sum_refs.pdf

all: $(ALL)

$(ALL): $(TEXFILES)

#
# Build a pdf from a tex file
#
.tex.pdf:
	$(LATEX) $(TEXOPTS) $*
	-$(BIBTEX) $(TEXOPTS) $*
	$(LATEX) $(TEXOPTS) $*
	$(LATEX) $(TEXOPTS) $*

thesis_exec_sum_refs.pdf: thesis_exec_sum_refs.tex
	$(LATEX) $(TEXOPTS) $*
	-$(BIBTEX) $(TEXOPTS) $*
	-$(BIBTEX) $(TEXOPTS) bu1
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
