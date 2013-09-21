#!/usr/bin/python
# Fix the toc file to make it look the way NPS wants it

import re,sys

#\contentsline {chapter}{\numberline {}\hspace{-1.5pc}Appendix A\hspace{1pc} Data Preparation}{33}{appendix.A}


def process(fn):
    r = re.compile("\\{chapter\\}\\{\\\\numberline \\{([A-Z])\\}(.*)\\}(.*)")
    out = []
    for line in open(fn,"r"):
        line = line.strip()
        m = r.search(line)
        if not m:
            out.append(line)
        else:
            out.append("\\contentsline {chapter}{\\numberline {}\\hspace{-1.3pc}Appendix %s\\hspace{1pc} %s}%s"
                       % (m.group(1),m.group(2),m.group(3)))
    open(fn,"w").write("\n".join(out))
        

if __name__=="__main__":
    process(sys.argv[1])
