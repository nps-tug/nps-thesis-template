#!/usr/bin/python
# 
# convert an NPS Excel Budget workbook to a PDF on a Mac
#
#

import sys,os

sys.path.append(os.getenv("DOMEX_HOME") + "/papers/npsreport/xlrd-0.7.1") # add the library

from subprocess import Popen,call,PIPE
import os,os.path
import xml.dom.minidom
import plistlib
import xlrd

def convert_to_pdf(ifn,ofn):
    if os.path.islink(ifn):
        fname = os.readlink(ifn)
    else:
        fname = ifn

    if os.path.exists("xdir"):
        raise RuntimeError("xdir must not exists")
    os.mkdir("xdir")
    if not os.path.exists("xdir"):
        raise RuntimeError("could not make xdir")
    print("Calling qlmanage to create the HTML output")
    cmd = ['qlmanage','-p','-o','xdir',fname]
    print(" ".join(cmd))
    if call(cmd)!=0:
        raise RuntimeError("Cannot convert %s to HTML" % fname)

    # Now we need to find the sheets and sort them.
    # This is done by reading the property list
    qldir = os.path.basename(fname) + ".qlpreview"
    propfilename = "%s/%s/%s" % ('xdir',qldir,'PreviewProperties.plist')
    if not os.path.exists(propfilename):
        raise RuntimeError(propfile+" was not created")
    plist = plistlib.readPlist(open(propfilename))
    attachments = plist['Attachments']
    ary = []
    for k in attachments.keys():
        if k.endswith(".html"):
            basename = os.path.basename(k)
            fn = attachments[k]['DumpedAttachmentFileName']
            print("Found %s -> %s" % (basename,fn))
            ary.append((basename,fn))
    sheets = [val[1] for val in sorted(ary)]
    if len(sheets)==0:
        sheets.append("Preview.html")
    print("sheets=",sheets)

    # Use wkhtmltopdf to generate the PDF output
    cmd = ['wkhtmltopdf'];
    print("Now using wkhtmltopdf to create PDF from HTML")
    os.chdir("%s/%s" % ('xdir',qldir))

    for fn in  sheets:
        cmd.append(fn)
    cmd.append("../../" + sys.argv[2])
    try:
        print(" ".join(cmd))
        if call(cmd)!=0:
            raise RuntimeError("command failed")
    except OSError:
        print("\n\nERROR: %s is not installed\n\n" % (cmd[0]))
        exit(1)
    os.chdir("../..")
    call(['/bin/rm','-rf','xdir'])

    # Finally, create a file that inputs the budget and signs it
    #bfn = ofn.replace(".pdf",".tex")
    #for i in range(0,len(sheets)):
    #    bfn.write(r"\includepdf[pages={0:}-{0:}]{{{1:}}}".format(i+0,ofn))
    #    bfn.write("\n")
                  
        


if __name__=="__main__":
    if len(sys.argv)==1:
        print("Usage: %s filename.xls output.pdf" % sys.argv[0])
        exit(1)

    convert_to_pdf(sys.argv[1],sys.argv[2])

