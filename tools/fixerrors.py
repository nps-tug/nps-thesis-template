#!/usr/bin/python
#
# fixbbl:
# BibTeX automatically puts a "%" character and a linebreak after long URLs.
# This breaks the included bibliography entries, in many circumstances, 
# but only with long URLs.
#
# This script reads in the bbl file and looks for lines that end with a %.
# The lines are then unbroken.
#
# Some version of BibTeX make URLs use the \path command, like \path|http://cnn.com|.
# That breaks other bibliographies. This script replaces \path|http://cnn.com|
# with {\footnotesize\url{http://cnn.com}}
#

# fixauthorindex:
# The authorindex sometimes has an unsuitable value such as an empty string
# or a '3rd' value.  This code will correct the problem.

# usage: python fixerrors.py
# adjust the below configuration options to determine if the fix runs
fix_bbl = True
fix_authorindex = True

import os
import sys
import fnmatch
import re
import glob

def fixbbl(fn):
    print("Fixing " + fn)
    ofn = fn + "~"
    try:
        os.unlink(ofn)
    except OSError:
        pass                            # ignore file does not exist
    os.rename(fn, ofn)
    indata = open(ofn, "r").read()
    indata = indata.replace("%\n", "") # remove bad linebreaks
    indata = indata.replace(r"\path|", r"{\footnotesize\url{")
    indata = indata.replace(r"|}\fi", r"}}}\fi")
    with open(fn, "w") as outfile:
        outfile.write(indata)
    outfile.close()
    os.remove(ofn)

def fixauthorindex(fn):
    print("Fixing " + fn)
    fnnew = fn + "~"
    n = open(fnnew, "w")
    r = re.compile("\\[(.*)\\]")
    for l in open(fn, "r"):
        m = r.search(l)
        if(m):
            if(m.group(1) == ''): continue
            if(m.group(1) == '3rd'): continue
        n.write(l)
    n.close()
    os.rename(fnnew, fn)

if __name__ == "__main__":
    from optparse import OptionParser
    parser = OptionParser()
    (options,args) = parser.parse_args()

    if args:
        for fn in args:
            if fn.endswith(".bbl"):
                fixbbl(fn)
            if fn.endswith(".ain"):
                fixauthorindex(fn)
        exit(0)

    if fix_bbl:
        for bbl in glob.glob("*.bbl"):
            fixbbl(bbl)
    if fix_authorindex:
        for ain in glob.glob("*.ain"):
            fixauthorindex(ain)
    
            
