#!/usr/bin/python
# 
# xls_extract.py:
# Extract all of the excel terms from an NPS budget spreadsheet and write to LaTeX variables
#
#

import sys,os,re


sys.path.append(os.getenv("DOMEX_HOME") + "/papers/npsreport/xlrd-0.7.1") # add the library

from subprocess import Popen,call,PIPE
import os,os.path
import xml.dom.minidom
import plistlib
import xlrd

number_name = ["Zero","One","Two","Three","Four","Five","Six","Seven"]

# For each dhs_category, we have a DHS title and a regular expression
# Must be redone for contracts on new NPS form
dhs_categories = [("Direct Labor",'TOTAL FACULTY/SUPPORT Labor.*'),
                  ('Travel','Travel'),
                  ('Equipment','Equipment'),
                  ('Indirect Cost','^Indirect Cost.*'),
                  ('Total','TOTAL PROPOSAL COST')]

make_dhs = False

import datetime
def xls_datetime(num):
    """Convert num days from January 1, 1900 to current date"""
    return datetime.datetime(1900,1,1)+datetime.timedelta(days=num-2)

def xls_datestr(num):
    """Convert num days from January 1, 1900 to current date"""
    return xls_datetime(num).strftime("%d-%b-%Y")

def current_fy():
    """What is this year's FY?"""
    import time
    tm = time.localtime()
    if tm.tm_mon>=10: return tm.tm_year+1
    return tm.tm_year

def extract_from_xls(ifn,ofn):
    # Now extract the money numbers
    import xlrd,locale
    book = xlrd.open_workbook(ifn)
    if len(book.sheets())==1:
        years = 1
        year1 = book.sheet_by_index(0)
        yearN = book.sheet_by_index(0)
    else:
        years = len(book.sheets())-1
        year1 = book.sheet_by_index(0)
        yearN = book.sheet_by_index(years)

    locale.setlocale(locale.LC_ALL, "")

    print("This is a %d year proposal" % (years))
    if years==0:
        raise RuntimeError("Invalid years")

    f = open(ofn,"w")

    def nice_var(var):
        ret = ""
        for ch in var:
            if ch.isalpha():
                ret += ch
        return ret

    def set_variable(var,val,verbose=False):
        """Outputs a variable to the LaTeX file"""
        val = str(val).replace("$","\\$")
        f.write("\\newcommand\\"+nice_var(var)+"{"+str(val)+"\\xspace}\n")
        if verbose: print("{}: {}".format(var,val))

    def set_money(var,val):
        set_variable(var,locale.currency(val,True,True))

    # Output fields for all years
    # Extract title and other information.
    set_variable("proposalTitle",year1.row(5)[0].value.strip(),verbose=True)
    set_variable("sponsor",year1.row(5)[6].value.strip(),verbose=True)

    # Find the cost in the first year;
    # it might be a short or long, so we need to actually scan for the number

    def find_row(sheet,title_re):
        """Find the row which has the title"""
        reg = re.compile(title_re,re.I)
        for i in range(0,sheet.nrows):
            if reg.search(unicode(sheet.row(i)[0].value)):
                return i
        

    def find_value(sheet,title,colmax=1,required=False):
        reg = re.compile(title,re.I)
        """Returns the last floating point value on from the sheet
        for which the A column has the words in 'title'"""
        for i in range(0,sheet.nrows):
            row = sheet.row(i)
            for col in range(0,min(len(row),colmax)):
                v = row[col].value
                if reg.search(unicode(v)):
                    vals = list(row[1:])
                    for r in vals[col:]:
                        if type(r.value)==float and r.value>0:
                            return r.value
                    if required:
                        print("Cannot find "+title)
                        for r in vals[col:]:
                            print("{}  {}".format(type(r.value),r))
                    return 0
                
        raise ValueError("Could not find "+title+" in sheet ")

    set_money("yearOneCost",find_value(year1,'TOTAL PROPOSAL COST'))
    set_money("totalCost",find_value(yearN,'TOTAL PROPOSAL COST'))
    

    POPStart = find_value(yearN,"From:",colmax=7,required=True)
    if type(POPStart)!=float or POPStart==0:
        print(type(POPStart))
        print("Proposal Start period not set on total page")
        exit(1)
    POPStartStr = xls_datestr(POPStart)
    set_variable("POPStart",POPStartStr,verbose=True)
    
    POPEnd = find_value(yearN,"To:",colmax=14,required=True)
    if type(POPEnd)!=float or POPEnd==0:
        print("Proposal End not set on total page")
        exit(1)

    set_variable("POPEnd",xls_datestr(POPEnd),verbose=True)
    set_variable("POPMonths",int((POPEnd-POPStart)/30),verbose=True)

    # Now output the data for each year
    for (title,reg) in dhs_categories:
        total = 0
        for i in range(0,years):
            year = book.sheet_by_index(i)
            yearname = "year" + number_name[i+1]
            try:
                val = find_value(year,reg)
                set_money(yearname+reg,val)
                total += val
            except ValueError as e:
                print("Error: "+str(e))
        set_money("total"+reg,total)

    # Create the Total Cost Table, should it be desired.
    nl = "\n"
    f.write(r"\newcommand{\totalCostTable}{" + nl)
    f.write(r"Total budget for this proposal is \totalTOTALPROPOSALCOST\xspace and will be spent as follows:" + nl)
    f.write(nl)
    f.write(r"{\sffamily\fontsize{10}{11}\selectfont"+nl)
    f.write(r"\begin{tabular}{l|")
    f.write(r"r" * years)
    f.write(r"|r}"+nl)
    for i in range(1,years+1):
        f.write("  & Year %d " % i)
    f.write(r"& Total  \\" + nl)
    f.write(r"\hline" + nl)
    for (title,reg) in dhs_categories:
        if title==dhs_categories[-1][0]: f.write("\\hline ")
        f.write(title)
        for i in range(0,years):
            yearname = "year" + number_name[i+1]
            f.write("& \\" + nice_var(yearname+reg))
        f.write(" & \\" + nice_var("total"+reg) + r"\\" + nl)

    f.write(r"\end{tabular}" + nl)
    f.write(r"}}"+nl)
    
    def dump_section(sheet,start_row,cols,col_heads):
        # If there is no data in the row, return
        for i in range(0,3):
            print(start_row,i,sheet.row(start_row)[i].value)

        if sheet.row(start_row)[cols[0]].value=="": return
        ncols = len(cols)
        f.write(r"\begin{tabular}{l|" + "r"*ncols + r"}" + nl)
        if col_heads: f.write("&".join(col_heads) + r"\\" + nl)
        f.write(r"\hline"+nl)
        sum = 0
        while sheet.row(start_row)[cols[0]].value!="":
            for c in cols:
                v = sheet.row(start_row)[c].value
                if not v:
                    continue
                if c!=cols[-1]:
                    f.write(str(v) + " & ")
                else:
                    try:
                        f.write("\\" + locale.currency(v,True,True) + r"\\" + nl)
                        sum += float(v)
                    except TypeError:
                        continue
            start_row+=1
        f.write("\hline\multicolumn{%d}{l}{Total} &" % (ncols-1))
        f.write("\\" + locale.currency(sum,True,True) + r"\\" + nl)
        f.write(r"\end{tabular}" + nl + nl)
        

    # Are we in the current FY?
    popstart_datetime = xls_datetime(POPStart)
    next_fystart      = datetime.datetime(current_fy(),10,1)
    in_current_fy = popstart_datetime <= next_fystart
    if in_current_fy:
        print("This proposal starts in the current FY!")
        f.write(r"\newcommand\CurrentFYBudget{\yearOneTOTALPROPOSALCOST}" + nl)
    else:
        f.write(r"\newcommand\CurrentFYBudget{\$0.00\xspace}" + nl)

    # Create the DHS year for each year
    if make_dhs:
        for i in range(0,years):
            f.write(r"\newcommand\NPSBudgetYear"+number_name[i+1]+"{" + nl)
            year = book.sheet_by_index(i)
            f.write(r"\noindent\textbf{Direct Labor:}" + nl + nl)
            dump_section(year,13,[0,7,9,10],["Individual","Days","Hrly Rate","Est.Cost"])
            dump_section(year,37,[0,7,9,10],None)

            total_benefits = year.row(59)[10].value
            f.write("Total Benefits: \\" + locale.currency(total_benefits,True,True) + nl*2)


            f.write(r"\noindent\textbf{Travel:}" + nl + nl)
            dump_section(year,65,[0,2,4,6,7,8],
                         ["Traveler","Destination (if Known)","Purpose (if known)",
                          "Trips","Cost/Trip","Subtotal"])

            f.write(r"\noindent\textbf{Equipment:}" + nl + nl)
            dump_section(year,78,[0,4,6,7,8],
                         ["Description","Purpose","Units","Cost/Unit","Subtotal"])

            f.write(r"\noindent\textbf{Contracts}" + nl + nl)
            dump_section(year,100,[1,8],
                         ["Contracts","Estimated Cost"])

            indirect_rate = year.row(117)[6].value * 100.0
            indirect_base = year.row(117)[8].value - 25000
            indirect_tot  = year.row(117)[10].value
            f.write("Indirect Costs: \\" + locale.currency(indirect_tot,True,True)
                    + (" (%5.2f\\%% of " % indirect_rate) 
                    + "\\" + locale.currency(indirect_base,True,True) + ")"
                    + nl + nl)


            f.write(r"}"+nl)
            f.write("\n\n")


            f.write(r"\newcommand\AsistanceAgreementBudgetYear"+number_name[i+1]+"{" + nl)
            f.write(r"\noindent\textbf{Assistance Agreements:}" + nl*2)
            dump_section(year,105,[1,8],
                         ["Grants/Cooperative Agreements","Estimated Cost"])

            indirect_rate = year.row(117)[6].value * 100.0
            indirect_base = 25000
            indirect_tot  = year.row(117)[10].value
            f.write("Indirect Costs: \\" + locale.currency(indirect_tot,True,True)
                    + (" (%5.2f\\%% of " % indirect_rate) 
                    + "\\" + locale.currency(indirect_base,True,True) + ")"
                    + nl + nl)


            f.write(r"}"+nl)
            f.write("\n\n")
    f.close()

if __name__=="__main__":
    if len(sys.argv)==2:
        print("Usage: %s filename.xls LaTeX_vars.tex" % sys.argv[0])
        exit(1)
    if not sys.argv[1].endswith(".xls"):
        print("Error: This program can only process .xls files")
        exit(1)

    if not sys.argv[2].endswith(".tex"):
        print("Error: This program only writes to a LaTeX file")
        exit(1)

    extract_from_xls(sys.argv[1],sys.argv[2])
