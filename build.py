#!/usr/bin/python
#
# This build script is an alternate for the Makefile.
# Mac and Linux users will benefit from the Makefile,
# while this script would be most useful for Windows users.

import os
import glob

# Change this to be the base filename of your work (thesis, techreport, etc)
# without the .tex extension
name = "thesis"

authindex = glob.glob("*.ain")
keywordindex = glob.glob("*.idx")

os.system("pdflatex " + name)
os.system("bibtex " + name)
if not authindex:
    os.system("perl authorindex.pl " + name)
if not keywordindex:
    os.system("makeindex " + keywordindex[0])
os.system("python fixerrors.py")
os.system("pdflatex " + name)
os.system("pdflatex " + name)

