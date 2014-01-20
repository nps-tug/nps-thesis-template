%%
%% npsreport.cls
%% LaTeX class file for NPS Theses and Tech Reports
%% Version 1.2
%%
%% NOTE:
%% There is typically no reason to modify this file. If something
%% appears broken, then look at latest style files available from the
%% thesis processor: it might already be fixed in a newer version!
%%
%%*************************************************************************
%
% Based on:
% New NPS thesis and report style for modern LaTeX
% Simson L. Garfinkel, Dept. of Computer Science
%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{npsreport}[2008/10/01]

% These if statements describe the various options used by the
% npsreport package

\newif\ifnpstraditional\npstraditionalfalse
\newif\ifsignatureline\signaturelinefalse
\newif\ifnpstwoside\npstwosidefalse
\newif\ifnpsauthorindex\npsauthorindexfalse
\newif\ifnpsarticle\npsarticlefalse
\newif\ifnpsthesis\npsthesisfalse
\newif\iftwoauthors\twoauthorsfalse
\newif\ifthreeauthors\threeauthorsfalse
\newif\iffourauthors\fourauthorsfalse
\newif\iftwoadvisors\twoadvisorsfalse
\newif\iftwoadvisorsreader\twoadvisorsreaderfalse
\newif\ifnpssinglespace\npssinglespacefalse
\newif\ifclassified\classifiedfalse
\newif\ifnpsdissertation\npsdissertationfalse
\newif\iffivemembers\fivemembersfalse
\newif\ifadvisoralone\advisoralonefalse
\newif\iffontsizeset\fontsizesetfalse
\newif\iffontnameset\fontnamesetfalse
\newif\iffonttimesset\fonttimessetfalse
\newif\iffontarialset\fontarialsetfalse
\newif\iffontcourierset\fontcouriersetfalse
\newif\ifnpstight\npstightfalse
\newif\ifnpsindex\npsindexfalse
\newif\ifnpsacronym\npsacronymfalse

\DeclareOption{article}{\npsarticletrue}           % use article default, not report
\DeclareOption{traditional}{\npstraditionaltrue}   % make it look old way
\DeclareOption{signatureline}{\signaturelinetrue}
\DeclareOption{twoside}{\npstwosidetrue}
\DeclareOption{authorindex}{\npsauthorindextrue}   % generate an author index
\DeclareOption{thesis}{\npsthesistrue}             % is this a thesis?
\DeclareOption{twoauthors}{\twoauthorstrue}        % two students? 
\DeclareOption{threeauthors}{\threeauthorstrue}    % or three students?
\DeclareOption{fourauthors}{\fourauthorstrue}      % or four students? 
\DeclareOption{twoadvisors}{\twoadvisorstrue}      % two advisors? (but no second reader)
\DeclareOption{twoadvisorsreader}{\twoadvisorsreadertrue}      % two advisors? (AND also second reader)
\DeclareOption{classified}{\classifiedtrue}        % you're in the STBL or SCIF
\DeclareOption{singlespace}{\npssinglespacetrue}   % looks better
\DeclareOption{dissertation}{\npsdissertationtrue} % getting a phd!
\DeclareOption{tight}{\npstighttrue}               % Smaller paragraph spacing 
\DeclareOption{index}{\npsindextrue}               % have a keyword index page
\DeclareOption{acronym}{\npsacronymtrue}           % Use the acronym package
\DeclareOption{fivemembers}{\fivememberstrue}      % five member PhD committee
\DeclareOption{advisoralone}{\advisoralonetrue}    % list the top person alone

\DeclareOption{10pt}{
   \fontsizesettrue
}
\DeclareOption{11pt}{
  \PassOptionsToClass{11pt}{article}
  \PassOptionsToClass{11pt}{report}
  \fontsizesettrue
}
\DeclareOption{12pt}{
  \PassOptionsToClass{12pt}{article}
  \PassOptionsToClass{12pt}{report}
  \fontsizesettrue
}  
\iffontsizeset
  % Font size is set
\else
  \PassOptionsToClass{12pt}{article}
  \PassOptionsToClass{12pt}{report}
\fi  

\DeclareOption{times}{
  \fontnamesettrue
  \fonttimessettrue
}

\DeclareOption{arial}{
  \fontnamesettrue
  \fontarialsettrue
}

\DeclareOption{courier}{
  \fontnamesettrue
  \fontcouriersettrue
}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
% Options Processing
\PassOptionsToClass{twoside}{geometry}
\PassOptionsToClass{twoside}{report}           % Options for report
\PassOptionsToClass{openright}{report}

\PassOptionsToClass{twoside}{article}          % Options for article
\PassOptionsToClass{openright}{article}

\ProcessOptions

% Now options can be used

\ifnpsdissertation              % a dissertation is automatically a thesis
  \npsthesistrue
\fi

\iffourauthors        % if there are four, then there are two and three
  \threeauthorstrue
  \twoauthorstrue
\fi
\ifthreeauthors       % if there are three, then there are two
  \twoauthorstrue
\fi

\ifclassified
  \typeout{*********************************************}
  \typeout{******** MAKING CLASSIFIED THESIS ***********}
  \typeout{*********************************************}
  \def\ULABEL{(U)\xspace}
\else
  \def\ULABEL{}
\fi

\ifnpsarticle
  \LoadClass{article}
\else
  \LoadClass{report}             % inherit from article so we can have
\fi

%% Page geometry
\usepackage[letterpaper]{geometry} % use 'showframe' for debugging
\newgeometry{includeheadfoot,            % headers and footers aren't in margins
             right=1.25in,left=1.25in,   % right/left margins
             top=1in,bottom=1in,         % top/bottom margins
             footskip=.5in,              % pg nums in footer need breathing room
             marginparwidth=0pt,         % no marginal paragraphs
             marginparsep=0pt,           % no marginal paragraphs
             head=30pt,headsep=0pt,hoffset=0pt}

%% Font selection
\usepackage[T1]{fontenc}        % http://tex.stackexchange.com/questions/664/why-should-i-use-usepackaget1fontenc
\usepackage{url}                % make\url work (be nice have [lowtidle])
\usepackage{eurosym}

\iffontnameset
  % Font name is set
\else
  \fonttimessettrue
\fi 

\iffonttimesset
  \usepackage{mathptmx}           % print the thesis in Times
\fi

\iffontarialset
  \usepackage[scaled]{uarial}
  \renewcommand*\familydefault{\sfdefault} %% base font of the document is sans serif
\fi

\iffontcourierset
  \usepackage{courier}
  \renewcommand*\familydefault{\ttdefault} %% base font of the document is typewriter style
\fi

% The NPS Template uses many packages to provide a rich set of features.
% Optional packages exist at the end; read through them and uncomment
% as necessary to include.
% Bring in the modern LaTeX packages; look at CTAN to see what each of
% these does.  Each package has a user's manual to reference for assistance.
\usepackage[utf8x]{inputenc}    % accented letters in tex files allowed
\usepackage{graphicx}           % better way to bring in graphics
\usepackage{tabularx}           % tables that expand to with width requested
\usepackage{titletoc}           % adds toc commands
\usepackage{titlesec}           % complete replacement for titles
\usepackage{fancyhdr}           % puts chapters names in footers
\usepackage{ccaption}           % control captions
\usepackage{setspace}           % enabled \doublespacing, \onehalfspacing, etc.
\usepackage{multicol}           % multiple columns; good for you!
\usepackage{fancyvrb}           % a better verbatim
\usepackage{varioref}           % provides \vref - smart referencing
\usepackage{xspace}             % provides \xspace
\usepackage{xifthen}            % if-then-else macro for empty fields
\usepackage{latexsym}           % gives \Box
\usepackage{graphicx}           % it's better
\usepackage{multirow}           % for table cells with multiple row
\usepackage{pifont}             % fancy characters
\usepackage{remreset}           % prevent footnotes from being reset at each chapter
\usepackage{color}
\usepackage[table]{xcolor}
\usepackage{paralist}           % {compactenum} {compactitem} environments
\usepackage{enumitem}           % No extra space before lists
\usepackage{afterpage}          % to implement \smark marking macro
\setlist{nolistsep}

\ifnpsthesis
\usepackage[old298]{nps_sf298}  % Bring in SF298 for the documentation page
\else
\usepackage{nps_sf298}          % Use newer SF298 for tech reports
\fi

\usepackage{float}              % reimplementation of float package
\usepackage{cite}               % for [5-8] reference style
\usepackage{amsmath,amsfonts}   % for many types of math equations
\usepackage{url}                % nice handling of URLs
\usepackage{subfigure}          % needs to be before tocloft, to avoid conflict
\usepackage[subfigure]{tocloft} % TOC Control

\pagenumbering{roman}

% Control widows, orphans, and floats
\renewcommand{\topfraction}{0.90}
\renewcommand{\floatpagefraction}{0.90}
\setcounter{topnumber}{10}   % up to 10 floats at the top of the page; Should be enough
\setcounter{totalnumber}{10} % see above


% Here are some commands that will help you make more attractive LaTeX
% Notice that \etal is italicized, but not e.g., etc. , or i.e.
% Please see p. 5, Section VI, para. 3, of The IEEE Editorial Style Manual
%\newcommand{\checkmark}{\Pisymbol{pzd}{52}}
\newcommand{\eg}{e.g.,\xspace}
\newcommand{\ie}{i.e.,\xspace}
\newcommand{\etc}{etc.\xspace}
\newcommand{\etal}{\emph{et al.}\xspace}
\newcommand{\naive}{na\"{\i}ve\xpsace}
\newcommand{\Naive}{Na\"{\i}ve\xspace}

% You can also insert this before paragraphs that have problems:
% \looseness -1 

\newcommand{\chapref}[1]{Chapter~\ref{#1}\xspace}
\newcommand{\chapvref}[1]{Chapter~\vref{#1}\xspace}
\newcommand{\secref}[1]{Section~\ref{#1}\xspace}
\newcommand{\secvref}[1]{Section~\vref{#1}\xspace}
\newcommand{\figref}[1]{Figure~\ref{#1}\xspace}
\newcommand{\figvref}[1]{Figure~\vref{#1}\xspace}
\newcommand{\tabref}[1]{Table~\ref{#1}\xspace}
\newcommand{\tabvref}[1]{Table~\vref{#1}\xspace}
\newcommand{\eqnref}[1]{Equation~(\ref{#1})\xspace}
\newcommand{\eqnvref}[1]{Equation~(\vref{#1})\xspace}
\newcommand{\eqnsref}[2]{Equations~(\ref{#1}) and (\ref{#2})\xspace}
\newcommand{\eqnsvref}[2]{Equations~(\vref{#1}) and (\ref{#2}) on page \pageref{#1}\xspace}
\newcommand{\appref}[1]{Appendix~\ref{#1}\xspace}
\newcommand{\appvref}[1]{Appendix~\vref{#1}\xspace}

% Good pages on LaTeX:
% http://www-h.eng.cam.ac.uk/help/tpl/textprocessing/extending_latex.html


%*************************************************************************
% Define the pieces that go on the title page, abstract, SF298, and
% other pages. This is liberally borrowed from MIT Thesis guide
%*************************************************************************

\def\declassifydate#1{\gdef\@declassifydate{#1}} \gdef\@declassifydate{}
\def\classifiedby#1{\gdef\@classifiedby{#1}}     \gdef\@classifiedby{}
\def\classifiedfrom#1{\gdef\@classifiedfrom{#1}} \gdef\@classifiedfrom{Multiple Sources}
\def\degreedate#1{\date{#1}}
\def\prevdegrees#1{\gdef\@prevdegrees{#1}}       \def\@prevdegrees{}
\def\department#1{\gdef\@department{#1}}
\def\departmenttwo#1{\gdef\@departmenttwo{#1}}   \gdef\@departmenttwo{}
\def\departmentchair#1{\gdef\@departmentchair{#1}}
\def\departmentchairtwo#1{\gdef\@departmentchairtwo{#1}} \gdef\@departmentchairtwo{}
\def\researchchair#1{\gdef\@researchchair{#1}}
\def\president#1{\gdef\@president{#1}}
\def\provost#1{\gdef\@provost{#1}}

% Provide reasonable defaults
\department{Computer Science}
\departmentchair{Peter Denning}
\researchchair{Jeffrey D. Paduan}
\president{Ronald A. Route}
\provost{Douglas A. Hensler}

% Single degree or dual degree options
\def\degree#1{\gdef\@degree{#1}}
\gdef\@degree{}
\gdef\@degreeword{degree}
\def\degreetwo#1{\gdef\@degreetwo{#1}\gdef\@degreeword{degrees}}
\gdef\@degreetwo{}

% Degree abbreviation
\def\degreeabbreviation#1{\setbox0\hbox{#1}\gdef\@degreeabbreviation{#1}}

% \rank
\def\rank#1{\setbox0\hbox{#1}
  \gdef\@rank{#1}}
\rank{}                         % default is no rank

% \prevdegrees
\def\prevdegrees#1{\setbox0\hbox{#1}
  \gdef\@prevdegrees{#1}}

% For a second author
\def\authortwo#1{\setbox0\hbox{#1} \gdef\@authortwo{#1}} \authortwo{}
\def\ranktwo#1{\setbox0\hbox{#1} \gdef\@ranktwo{#1}} \ranktwo{}
\def\prevdegreestwo#1{\setbox0\hbox{#1} \gdef\@prevdegreestwo{#1}} \prevdegreestwo{}

% For a third author
\def\authorthree#1{\setbox0\hbox{#1} \gdef\@authorthree{#1}} \authorthree{}
\def\rankthree#1{\setbox0\hbox{#1} \gdef\@rankthree{#1}} \rankthree{}
\def\prevdegreesthree#1{\setbox0\hbox{#1} \gdef\@prevdegreesthree{#1}} \prevdegreesthree{}

% For a fourth author
\def\authorfour#1{\setbox0\hbox{#1} \gdef\@authorfour{#1}} \authorfour{}
\def\rankfour#1{\setbox0\hbox{#1} \gdef\@rankfour{#1}} \rankfour{}
\def\prevdegreesfour#1{\setbox0\hbox{#1} \gdef\@prevdegreesfour{#1}} \prevdegreesfour{}

% \distribution
\def\distribution#1{\setbox0\hbox{#1}
  \gdef\@distribution{#1}}    

% \DistributionClause
\def\DistributionClause#1{\setbox0\hbox{#1}
  \gdef\@DistributionClause{#1}}
\DistributionClause{Further distribution of all or part of this report is authorized.}

% \SponsoringNotation
\def\SponsoringNotation#1{\setbox0\hbox{#1}
  \gdef\@SponsoringNotation{#1}}    

% \SignatureOne
\def\SignatureOne#1{\setbox0\hbox{#1}
  \gdef\@SignatureOne{#1}}    

% \SignatureTwo
\def\SignatureTwo#1{\setbox0\hbox{#1}
  \gdef\@SignatureTwo{#1}}    

% \SignatureThree
\def\SignatureThree#1{\setbox0\hbox{#1}
  \gdef\@SignatureThree{#1}}    

% \SignatureFour
\def\SignatureFour#1{\setbox0\hbox{#1}
  \gdef\@SignatureFour{#1}}    

% \RPTpreparedFor
\def\RPTpreparedFor#1{\setbox0\hbox{#1}
  \gdef\@RPTpreparedFor{#1}}    
\RPTpreparedFor{}               % default is prepared for nobody

% \abstract
\newcommand{\NPSabstract}{cough}
\def\abstract#1{\setbox0\hbox{#1}
  \gdef\@abstract{#1}\renewcommand{\NPSabstract}{#1}}

\def\SponsoringAgency#1{\setbox0\hbox{#1}
  \gdef\@sponsoringagency{#1}}

% \thesisadvisor
\def\thesisadvisor#1{\setbox0\hbox{#1}
   \gdef\@thesisadvisor{#1}}

% \co thesisadvisor1
\def\thesisadvisorone#1{\setbox0\hbox{#1}
   \gdef\@thesisadvisorone{#1}}

% \co thesisadvisor2
\def\thesisadvisortwo#1{\setbox0\hbox{#1}
   \gdef\@thesisadvisortwo{#1}}

\def\secondreader#1{\setbox0\hbox{#1}
   \gdef\@secondreader{#1}}

% Some useful defines
\newcommand{\tablefont}{\sffamily\fontsize{9}{10}\selectfont}


%*************************************************************************
% Support for authorindex, index, acronym packages
%*************************************************************************

% Support for the Authorindex
\ifnpsauthorindex
  \usepackage[small]{authorindex}
  \let\cite=\aicite
  \renewenvironment{theauthorindex}{%
    \raggedright%
    \setlength{\leftskip}{1em}%
    \setlength{\parindent}{-1em}%
    \setlength{\parskip}{0pt}%
    \def\item[##1]{\par\hspace{0mm}\ainame{##1}}
    \aisize}{\par}
  \aipagetypeorder{n}
  \def\theaipage{\arabic{page}}
\fi

% Support for the Index
\ifnpsindex
  \usepackage{makeidx}
  \makeindex
\fi

% Support for the acronym package
\ifnpsacronym
  \usepackage[printonlyused]{acronym}
  \iffonttimesset
    % fixes the acronym list to be in times font as well.
    % it originally is in arial font based on an earlier
    % define of bflabel.
    \renewcommand{\bflabel}[1]{{\textbf{#1}\hfill}}
  \fi
  \iffontcourierset
    % this is the fix for the courier font.
    \renewcommand{\bflabel}[1]{{\textbf{\texttt{#1}}\hfill}}
  \fi
\fi


%*************************************************************************
% Macros for security marking
%*************************************************************************

\def\securitybanner#1{\setbox0\hbox{#1} \gdef\@securitybanner{#1}}
\securitybanner{}               % default is no banner

\newcommand{\smarkthispage}{
 \thispagestyle{fancy}
\ifclassified % leave classified headers and footers alone
\else
  \chead{} %
  \cfoot{\thepage \\ \@securitybanner}
  \afterpage{\cfoot{\thepage}}
\fi
}

\newenvironment{smark}[1][(U)]%
{ \smarkthispage  #1 %
}
{ \smarkthispage
}

\newcommand{\smarkfigtemp}{UNCLASSIFIED}
\newenvironment{smarkenv}[2][\textwidth]
{
  \smarkthispage
  \begin{minipage}{#1}
  \renewcommand{\smarkfigtemp}{#2}
  {\par\noindent\nopagebreak\centering \smarkfigtemp \\ \vspace{6pt} }
}{
  \vspace{3pt} \par\noindent\nopagebreak\centering \smarkfigtemp
  \end{minipage}
  \smarkthispage
}



%*************************************************************************
%
% Basic Document Control Commands
%
%*************************************************************************


%
% Section names
%
\ifnpstraditional
  % Traditionally lots of things need to be in uppercase and bold
  \def\abstractname{ABSTRACT}
  \def\figurename{Figure}
  \def\tablename{Table}
  \def\chaptername{CHAPTER}
  \def\appendixname{APPENDIX}
  \def\appendicesname{APPENDICES}
  \def\partname{PART}
  \def\contentsname{\textbf{TABLE OF CONTENTS}}
  \def\listfigurename{\textbf{LIST OF FIGURES}}
  \def\listtablename{\textbf{LIST OF TABLES}}
  \def\listacronymname{\textbf{LIST OF ACRONYMS AND ABBREVIATIONS}}
  \def\distribname{\textbf{INITIAL DISTRIBUTION LIST}}
  \def\acknowledgementsname{\textbf{ACKNOWLEDGEMENTS}}
  \def\execsummaryname{\textbf{EXECUTIVE SUMMARY}}
  \def\indexname{\textbf{\ULABELINDEX}}
  \def\bibname{\textbf{LIST OF REFERENCES}}
\else
  \def\appendixname{Appendix}
  \def\appendicesname{Appendices}
  \def\contentsname{Table of Contents}
  \def\listacronymname{List of Acronyms and Abbreviations}
  \def\distribname{Initial Distribution List}
  \def\acknowledgementsname{Acknowledgements}
 \def\execsummaryname{Executive Summary}
  \def\bibname{References}
\fi


%
% Section Numbering and Labels
%
\ifnpstraditional
  % Traditional numbering scheme
  \def\thepart          {\arabic{part}}
  \def\thechapter       {\Roman{chapter}}
  \def\thesection       {\Alph{section}}
  \def\thesubsection    {\arabic{subsection}}
  \def\thesubsubsection {\alph{subsubsection}}
  \def\theparagraph     {\arabic{paragraph}}
  \def\thesubparagraph  {\roman{subparagraph}}

  % Traditional labels to include punctuation, for toc, etc.
  \def\labelpart          {\thepart.}
  \def\labelchapter       {\thechapter.}
  \def\labelsection       {\thesection.}
  \def\labelsubsection    {\thesubsection.}
  \def\labelsubsubsection {\thesubsubsection.}
  \def\labelparagraph     {(\theparagraph)}
  \def\labelsubparagraph  {(\thesubparagraph)}
  \def\to@appendix{\global\def\ap@pen@dix{OK}% this is a flag, set at first app.
    \setcounter{chapter}{0}%
    \setcounter{section}{0}%
    \def\thechapter       {\Alph{chapter}}%
    \def\thesection       {\arabic{section}}%
    \def\thesubsection    {\alph{subsection}}%
    \def\thesubsubsection {\roman{subsubsection}}%
  }
\fi


%
% Title Control
% This is done with the titlesec package
%
\ifnpstraditional
  \titleformat{\chapter}[display] 
              {\normalfont\bf\Large\filcenter}         % {fmt}
              {\thechapter.\ }                         % {label}
              {1pc}                                    % {sep}
              {\vspace{-1in}\enlargethispage{-0.5in}}  % {before}
  \titleformat{\section}[block] 
              {\normalfont\Large}    % {fmt}
              {\thesection.\ }       % {label}
              {1pc}                  % {sep}
              {}%
  \titleformat{\subsection}[block] 
              {\normalfont}                       % {fmt}
              {\hspace{.5in}\thesubsection.\ }    % {label}
              {1pc}                               % {sep}
              {}%
\else
  % New, avant garde Titles (courtesy of titlesec)
  \titleformat{\chapter}[display]
              {\vskip 0\p@ \LARGE\filcenter\sffamily\titlerule[1pt]\vspace{1pt}\titlerule}
              {\MakeUppercase{\chaptertitlename} \thechapter:} % label (not for * chapters)
              {-1pc}           % sep
              {}               % before
              [\titlerule]     % after
  \titleformat{\section}
              {\normalfont\Large\bfseries}
              {\thesection}
              {1em}
              {}%
  \titleformat{\subsection}
              {\normalfont\large\bfseries}
              {\thesubsection}
              {1em}
              {}%
  \titleformat{\subsubsection}
              {\normalfont\normalsize\bfseries}
              {\thesubsubsection}
              {1em}
              {}%
\fi

% ``The starred version kills the indention of the paragraph following the title.''
% \titlespacing%{<command>}{<left>}{<beforesep>}{<aftersep>}[<right>]
\ifnpstraditional
  \titlespacing*{\chapter}{0pt}{15pt}{.25in}
  \titlespacing*{\section}{0pt}{0pt plus 2ex}{-2ex plus .2ex} 
  \titlespacing*{\subsection}{0pt}{0pt plus 2ex}{-2ex plus .2ex} 
  \titlespacing*{\subsubsection}{0pt}{0pt plus 2ex}{-2ex plus .2ex} 
  \titlespacing*{\paragraph}{0pt}{0pt plus 2ex}{3pt}
  \setlength{\parskip}{2ex}
  \setlength{\parindent}{0pt}
\else
  \titlespacing*{\chapter}{0pt}{-.5in}{.25in}
  \titlespacing*{\section}{0pt}{0pt plus 2ex}{-2ex plus .2ex} 
  \titlespacing*{\subsection}{0pt}{0pt plus 2ex}{-2ex plus .2ex} 
  \titlespacing*{\subsubsection}{0pt}{0pt plus 2ex}{-2ex plus .2ex} 
  \titlespacing*{\paragraph}{0pt}{0pt plus 2ex}{3pt}
  \setlength{\parskip}{2ex}
  \setlength{\parindent}{0pt}
\fi


%
% Figure / Table Caption Control
%
\ifnpstraditional
  % Make traditional figures and tables not reset and not include the figure/table tag
  \usepackage{chngcntr}
  \@removefromreset{figure}{chapter}
  \@removefromreset{table}{chapter}
  \counterwithout{figure}{chapter}
  \counterwithout{table}{chapter}
\else
  % Put captions is a sanserif font, smaller, and tighter
  \captionnamefont{\sffamily\fontsize{11}{12}\selectfont}
  \captiontitlefont{\sffamily\fontsize{11}{12}\selectfont}
  \setlength{\abovecaptionskip}{5pt}
  \setlength{\belowcaptionskip}{0pt}
\fi


%
% ToC, LoF, LoT Controls
%
\setlength\cftbeforetoctitleskip{0pt}
\setlength\cftbeforeloftitleskip{0pt}
\setlength\cftbeforelottitleskip{0pt}
\setlength\cftaftertoctitleskip{0pt}
\setlength\cftafterloftitleskip{0pt}
\setlength\cftafterlottitleskip{0pt}
\setlength\cftparskip{2ex}
\ifnpsarticle
\else
  \setlength\cftchapindent{-3pt}
\fi

% This magic makes the word "Figure" appear in entries of LoF
\newlength\figurelen             % 
\settowidth\figurelen{Figure}
\addtolength\cftfignumwidth{\figurelen}
\renewcommand\cftfigpresnum{\hspace{-1.5pc}Figure }

% This magic makes the word "Table" appear in entries of LoT
\newlength\tablelen             % 
\settowidth\tablelen{Table}
\addtolength\cfttabnumwidth{\tablelen}
\renewcommand\cfttabpresnum{\hspace{-1.5pc}Table }

\ifnpstraditional
\else
  \ifnpsarticle
  \setcounter{tocdepth}{3}  % put sections and subsections in TOC for articles
  \else
  \setcounter{tocdepth}{1}  % only put chapters and sections in the TOC
  \fi

  \def\SECTIONBOLDFACE{}
  \def\ARTICLESPACE{-1.8ex}
  \contentsmargin{2.55em}
  \dottedcontents{section}[1.5em]{}{2.3em}{1pc}

  \ifnpsarticle
    \titlecontents{section}                                 % section
            [25pt]                                    % left
            {\vspace{-0.2ex}}                         % above
            {\SECTIONBOLDFACE\contentslabel{2.3em}}   % before with label
            {\hspace*{-2.3em}}                        % before without label
            {\titlerule*[1pc]{.}\contentspage}        % filler and page

    \titlecontents{subsection}                              % subsection
            [42pt]                                    % left
            {\vspace{-1.8ex}}                         % above
            {\contentslabel{3.1em}}                   % before with label
            {\hspace*{-2.3em}}                        % before without label
            {\titlerule*[1pc]{.}\contentspage}        % filler and page

    \titlecontents{subsubsection}                           % subsubsection
            [42pt]                                    % left
            {\vspace{-1.8ex}}                         % above
            {\contentslabel{3.1em}}                   % before with label
            {\hspace*{-2.3em}}                        % before without label
            {\titlerule*[1pc]{.}\contentspage}        % filler and page
  \else
    \titlecontents{section}                                 % section
            [25pt]                                    % left
            {\vspace{-1.2ex}}                         % above
            {\SECTIONBOLDFACE\contentslabel{2.3em}}   % before with label
            {\hspace*{-2.3em}}                        % before without label
            {\titlerule*[1pc]{.}\contentspage}        % filler and page

    \titlecontents{subsection}                              % subsection
            [25pt]                                    % left
            {\vspace{-1.8ex}}                         % above
            {\contentslabel{2.3em}}                   % before with label
            {\hspace*{-2.3em}}                        % before without label
            {\titlerule*[1pc]{.}\contentspage}        % filler and page

    \titlecontents{subsubsection}                           % subsubsection
            [52pt]                                    % left
            {\vspace{-1.8ex}}                         % above
            {\contentslabel{2.3em}}                   % before with label
            {\hspace*{-2.3em}}                        % before without label
            {\titlerule*[1pc]{.}\contentspage}        % filler and page
  \fi
\fi

\ifnpstight
  \parskip 3pt
  \parindent 1pc
\fi


%*************************************************************************
% Endmatter and Appendices
%*************************************************************************

\newcommand{\NPSend}{
\ifnpsauthorindex
  \chapter*{Referenced Authors}
  %\addcontentsline{toc}{chapter}{Referenced Authors}
  \begin{multicols}{3}
    \printauthorindex
  \end{multicols}
\fi
\ifnpsindex
  \printindex
\fi
}

% Use this to change to appendix mode and insert ``Appendix'' into the Table of Contents
% The appendix needs to also call \chapter{title} after this command and it will have another TOC entry.
\newcommand{\NPSappendix}{
  \appendix                       % Appendix mode
  \clearpage
\ifnpsarticle
  \addcontentsline{toc}{section}{\appendixname}  % Insert ``Appendix'' into TOC
\else
  \addcontentsline{toc}{chapter}{\appendixname}  % Insert ``Appendix'' into TOC
  \def\chaptername{\appendixname}  % not sure why this is needed, but it is
\fi
}

% Use this to change to appendix mode and insert ``Appendix: Title'' into the Table of Contents.
% The appendix does not need a \chapter (it is handled here) and the Appendix appears as a single, 
% non-numbered entry in the TOC.
\newcommand{\NPSappendixTOC}[1] {
  \appendix                       % Appendix mode
  \clearpage
\ifnpsarticle
  \section*{APPENDIX:~#1}
  \addcontentsline{toc}{section}{\appendixname:~#1}  % Insert ``Appendix: Title'' into TOC
\else
  \def\chaptername{\appendixname}  % not sure why this is needed, but it is
  \chapter*{APPENDIX:~#1}
  \addcontentsline{toc}{chapter}{\appendixname:~#1}  % Insert ``Appendix: Title'' into TOC
\fi
}

% Use this to change to appendix mode and insert ``Appendices'' into the Table of Contents.
% This is the best method to use for multiple appendices, and each will need a \chapter{title}.
% that will add additional entries into the TOC.
\newcommand{\NPSappendices}{
  \appendix                       % Appendix mode
  \clearpage
\ifnpsarticle
  \cftaddtitleline{toc}{section}{\appendicesname}{} % Insert ``Appendices'' into TOC
\else
  \cftaddtitleline{toc}{chapter}{\appendicesname}{} % Insert ``Appendices'' into TOC
  \def\chaptername{\appendixname}  % not sure why this is needed, but it is
\fi
}


%*************************************************************************
% Macros for Blank Pages
%*************************************************************************

\newcommand{\thisPageIntentionallyLeftBlankForced}{
    \ifclassified               % leave classified headers and footers alone
    \lhead{}\rhead{}            % remove the headings
    \else
    \lhead{}\chead{}\rhead{}    % remove the headings
    \fi
    \vspace*{\fill} 
    \begin{center} 
      THIS PAGE INTENTIONALLY LEFT BLANK 
    \end{center} 
    \vspace*{\fill} 
    \newpage 
}

% handle THIS PAGE INTENTIONALLY LEFT BLANK if in twopage mode
% See http://www.ctan.org/tex-archive/macros/latex/contrib/fancyhdr/fancyhdr.pdf
\newcommand{\thisPageIntentionallyLeftBlank}{
  \ifnpstwoside
    \thisPageIntentionallyLeftBlankForced
  \fi
}

\def\cleardoublepage{\clearpage\if@twoside \ifodd \c@page \else
 \thispagestyle{fancy}
 \thisPageIntentionallyLeftBlank
 \if@twocolumn\hbox{}\newpage\fi\fi\fi
}

\def\cleardoublepageEmpty{\clearpage\if@twoside \ifodd\c@page\else 
 \thispagestyle{blankmarked}
 \thisPageIntentionallyLeftBlank
 \if@twocolumn\hbox{}\newpage\fi\fi\fi
} 


%*************************************************************************
% Cover Page
%*************************************************************************

\def\NPScover{
%% These commands are the first commands that run when printing
%% starts, because the \NPScover command appears first
\ifnpstraditional
  \fancyhead{}                  % clear all header fields
\fi
  %%
  %% 'fancy' and 'plain' - classified marking, page numbers
  %% used: everywhere
  \pagestyle{fancyplain}
    \rhead{} \lhead{}
    \renewcommand{\headrulewidth}{0pt}
 \ifclassified
    \chead{\vspace{-1em}\@securitybanner \\ \vspace{1em}}
    \cfoot{\thepage \\ \@securitybanner}
 \else
    \chead{}
    \cfoot{\thepage}
 \fi
  %%
  %% 'frontmarked' - classified markings, FOUO marking, no page numbers
  %% used: front cover
  \fancypagestyle{frontmarked}{
 \ifclassified
    \chead{\vspace{-1em}\@securitybanner \\ \vspace{1em}}
 \fi
    \cfoot{\vspace{2pc}\@securitybanner}
  }
  %%
  %% 'blankmarked' - classified markings, no page numbers
  %% used: this page left intentionally blank
  \fancypagestyle{blankmarked}{
 \ifclassified
    \chead{\vspace{-1em}\@securitybanner \\ \vspace{1em}}
    \cfoot{\vspace{1pt}\@securitybanner}
 \else
    \cfoot{}
 \fi
  }
  %
  %
  \renewcommand{\sf@ExtraPages}{2}  % include for the NPS cover
  %
  % The first page; but note --- it's a title page, so it doesn't use
  % this page style
  %
  \begin{titlepage}
  \thispagestyle{frontmarked}
  \vfill
  \textbf{\sf@POReportNumber}   % if not defined, will be blank
  \begin{center}
  \includegraphics{figs/nps_logo_3clr_cymk}
  \textbf{\huge\ifclassified\Large\fi{}\\NAVAL\\POSTGRADUATE\\SCHOOL\\}
  \vspace{2pc}
  \textbf{\large{}MONTEREY, CALIFORNIA\\}
  \vfill
  \ifnpsthesis
    \ifnpsdissertation
      \textbf{\huge DISSERTATION\\} 
    \else
      \textbf{\huge THESIS\\} 
    \fi
    ~
    \vfill
     \vspace*{\fill}
  \fi  

  % Print the box on the front page
  \setlength{\fboxrule}{1pt}

  \framebox[4.5in][c]{
    \begin{minipage}{4.45in}
      \vspace{3pt}
      \centering
        \textbf{\MakeUppercase{\@title}}\\
        \vspace{1pc}
        by\\
        \vspace{1pc}
        \@author\\
        \iftwoauthors
          \@authortwo\\
        \fi
        \ifthreeauthors
          \@authorthree\\
        \fi
        \iffourauthors
          \@authorfour\\
        \fi
        \vspace{1pc}
        \@date\\
        \vspace{1pc}
        \ifnpsthesis
          \begin{tabularx}{4.45in}{lXr}
            \ifnpsdissertation
                Dissertation Supervisor: & & \@thesisadvisor \\
            \else
                \iftwoadvisors
                    Thesis Co-Advisors: & \hspace{1in} & \@thesisadvisorone \\
                                        & \hspace{1in} & \@thesisadvisortwo \\
                \else
                  \iftwoadvisorsreader
                    Thesis Co-Advisors: & \hspace{1in} & \@thesisadvisorone \\
                                        & \hspace{1in} & \@thesisadvisortwo \\
                    Second Reader:      & \hspace{1in} & \@secondreader  \\
                  \else
                    Thesis Advisor:     & \hspace{1in} & \@thesisadvisor \\
                    Second Reader:      & \hspace{1in} & \@secondreader  \\
                  \fi
                \fi
            \fi
          \end{tabularx}
        \fi
    \end{minipage}
  }
  \parbox{\textwidth}{\centering \singlespacing \bf \small \@distribution} \\

  % define \RPTpreparedFor when needed in you tex file
  \ifthenelse{\equal{\@RPTpreparedFor}{}}{}{%
    \vspace{\smallskipamount}
    Prepared for: \@RPTpreparedFor
  }
  \vfill
  \ifclassified 
    \enlargethispage{4pc}
    \smallskip
    \begin{tabular}{ccc}
    \multicolumn{3}{c}{\textbf{\footnotesize DESTRUCTION NOTICE}}\\[-2pc]
    \parbox[t]{1.6in}{\singlespacing \scriptsize
     Classified by: \@classifiedby. Derived from: \@classifiedfrom.
     Declassify on \@declassifydate
    } &
    \parbox[t]{3.0in}{\singlespacing \scriptsize
     For classified documents follow the procedure in
     DoD 5220.22m Industrial Security Manual or DoD 5220.1R Information
     Security Program Regulation (Ch. 17 of OPNAVINST 5510.1)
    } &
    \parbox[t]{1.0in}{\singlespacing \scriptsize
     Copy \_\_\_\_ of \_\_\_\_ copies. This document contains
     \newcounter{nps@page}{}
         {\@ifundefined{r@TotPages}%
          {{\bf ??}}%
          {\setcounter{nps@page}{\expandafter\@car\r@TotPages\@nil}
           \addtocounter{nps@page}{-\value{TotPages}}
           \addtocounter{nps@page}{\sf@ExtraPages}
           \arabic{nps@page}}}
     pages.
    }
    \end{tabular}
  \fi
  \end{center}
  \vfill
  \end{titlepage}

  \cleardoublepageEmpty
}


%*************************************************************************
% SF298
%*************************************************************************

\def\NPSsftne{
  % Fill in items for the SF298
  \pagenumbering{roman}        % because they are weird
  \Title{\@title}
  \iffourauthors
    \Author{\@author, \@authortwo, \@authorthree, \@authorfour}
  \else
    \ifthreeauthors
      \Author{\@author, \@authortwo, \@authorthree}
    \else
      \iftwoauthors
        \Author{\@author, \@authortwo}
      \else
        \Author{\@author}
      \fi
    \fi
  \fi
  \PerformingOrg{Naval Postgraduate School \\ Monterey, CA 93943}  
  \DistributionStatement{\@distribution}
  \Abstract{\@abstract}
  \SponsoringAgencySF{\@sponsoringagency}
  \MakeRptDocPage
  \thispagestyle{plain}
  \cleardoublepage
}


%*************************************************************************
% Thesis Title Page
%*************************************************************************

% Definitions for the dissertation signature page identifications
\newcommand{\NPSsigfont}{\normalsize}
\newcommand{\NPScommitteebox}[1]{\parbox[t]{2.2in}{\raggedright #1}}
\def\committeechair#1{\gdef\@committeechair{#1}}
\def\assocprovost#1{\gdef\@assocprovost{#1}}

% Dissertation committee members
\def\@memberOne{\@thesisadvisor}
\def\@memberTwo{\@committeechair}
\def\@memberThree{}
\def\@memberFour{}
\def\@memberFive{}
\def\@memberSix{}

\def\memberOne#1{\gdef\@memberOne{#1}}
\def\memberTwo#1{\gdef\@memberTwo{#1}}
\def\memberThree#1{\gdef\@memberThree{#1}}
\def\memberFour#1{\gdef\@memberFour{#1}}
\def\memberFive#1{\gdef\@memberFive{#1}}
\def\memberSix#1{\gdef\@memberSix{#1}}

% Title lines for each dissertation committee member.
\def\@memberOneTitleLine{Dissertation Supervisor}
\def\@memberTwoTitleLine{Dissertation Committee Chair}
\def\@memberThreeTitleLine{}
\def\@memberFourTitleLine{}
\def\@memberFiveTitleLine{}
\def\@memberSixTitleLine{}

\def\memberOneTitleLine#1{\gdef\@memberOneTitleLine{#1}}
\def\memberTwoTitleLine#1{\gdef\@memberTwoTitleLine{#1}}
\def\memberThreeTitleLine#1{\gdef\@memberThreeTitleLine{#1}}
\def\memberFourTitleLine#1{\gdef\@memberFourTitleLine{#1}}
\def\memberFiveTitleLine#1{\gdef\@memberFiveTitleLine{#1}}
\def\memberSixTitleLine#1{\gdef\@memberSixTitleLine{#1}}

\def\NPSthesistitle{
  % this page is always (iii), so force skip (used in non-twoside mode)
  \ifnum \c@page < 3 \thisPageIntentionallyLeftBlankForced \fi
  \setcounter{page}{3}          % do not reset to page 1
  \smarkthispage
  \begin{center}
    \textbf{\@distribution}\\
    \vspace{\bigskipamount}\vfill
    \textbf{\MakeUppercase{\@title}}\\
    \vspace{\bigskipamount}\vfill
    \@author~\\
    \@rank~\\
    \@prevdegrees\\
    \iftwoauthors
      \vspace{1.5\medskipamount}
      \@authortwo~\\
      \@ranktwo~\\
      \@prevdegreestwo\\
    \fi
    \vspace{\bigskipamount}\vfill
    Submitted in partial fulfillment of the\\
    requirements for the \@degreeword\ of\\
    \vspace{\bigskipamount}\vfill
    \textbf{\MakeUppercase{\@degree}}\\
      \ifthenelse{\equal{\@degreetwo}{}}{}{%
            \vspace{\smallskipamount}
            and \\ \vspace{\smallskipamount}
            \textbf{\MakeUppercase{\@degreetwo}}\\
      }
    \vspace{\medskipamount}
    from the\\
    \vspace{1.5\medskipamount}
    \textbf{NAVAL POSTGRADUATE SCHOOL}\\
    \textbf{\@date}
  \end{center}

  %% dissertation:
  \ifnpsdissertation 
     \newcommand{\sigspace}{1.5pc}

      \vfill
      \NPSsigfont
      \begin{tabbing}
      \hspace{1.1in} \= \hspace{2.4in} \= \\      % Set the tabs

      Author: \> \@author \\[\sigspace]

      %% Row 1:
      % process member 1
      \ifadvisoralone
      Approved by: \> \@memberOne \\
                   \> \NPScommitteebox{\@memberOneTitleLine} \\[\sigspace]
      \else
      % process member 1 and 2
      Approved by: \> \@memberOne
                   \> \@memberTwo \\
                   \> \NPScommitteebox{\@memberOneTitleLine} \>
                      \NPScommitteebox{\@memberTwoTitleLine} \\[\sigspace]
      \fi
      %% Row 2:
      \ifadvisoralone
      % process member 2 and 3
                   \> \@memberTwo
                   \> \@memberThree \\
                   \> \NPScommitteebox{\@memberTwoTitleLine} \>
                      \NPScommitteebox{\@memberThreeTitleLine} \\[\sigspace]
      \else
      % process member 3 and 4
                   \> \@memberThree
                   \> \@memberFour \\
                   \> \NPScommitteebox{\@memberThreeTitleLine} \>
                      \NPScommitteebox{\@memberFourTitleLine} \\[\sigspace]
      \fi
      %% Row 3:
      \ifadvisoralone
      % process member 4 and 5
                   \> \@memberFour
                   \> \@memberFive \\
                   \> \NPScommitteebox{\@memberFourTitleLine} \>
                      \NPScommitteebox{\@memberFiveTitleLine} \\[\sigspace]
      \else
      \iffivemembers
      % process member 5 and done
                   \> \@memberFive \\
                   \> \NPScommitteebox{\@memberFiveTitleLine} \\[\sigspace]
      \else
      % process member 5 and 6
                   \> \@memberFive
                   \> \@memberSix \\
                   \> \NPScommitteebox{\@memberFiveTitleLine} \> %
                      \NPScommitteebox{\@memberSixTitleLine} \\[\sigspace]
      \fi
      \fi
      Approved by: \> \@departmentchair \\
                   \> Chair, \@department \\[\sigspace]

      Approved by: \> \@assocprovost \\
                   \> Associate Provost for Academic Affairs \\
      \end{tabbing}
      \normalsize
  %% thesis:
  \else
    %% co-advisors
    \iftwoadvisors
      \newcommand{\sigspace}{1.5pc}

      \vfill
      \begin{tabbing}
      \hspace{1.5in}\=\\       % Set the tabs

      \iftwoauthors
      Authors: \> \@author \\[\sigspace]
               \> \@authortwo\\[\sigspace]
      \else
      Author: \> \@author \\[\sigspace]
      \fi
  
      Approved by:   \> \@thesisadvisorone \\
                     \> Thesis Co-Advisor \\[\sigspace]

                     \> \@thesisadvisortwo \\
                     \> Thesis Co-Advisor \\[\sigspace]

                     \> \@departmentchair \\
                     \>  Chair, \@department

                  \ifthenelse{\equal{\@departmenttwo}{}}{\\}{ %
                     \\[\sigspace]
                     \> \@departmentchairtwo \\
                     \> Chair, \@departmenttwo \\
                  }
      \end{tabbing}
    \else
    %% co-advisors + reader
    \iftwoadvisorsreader
      \newcommand{\sigspace}{1.5pc}

      \vfill
      \begin{tabbing}
      \hspace{1.5in}\=\\       % Set the tabs

      \iftwoauthors
      Authors: \> \@author \\[\sigspace]
               \> \@authortwo\\[\sigspace]
      \else
      Author: \> \@author \\[\sigspace]
      \fi

      Approved by:   \> \@thesisadvisorone \\
                     \> Thesis Co-Advisor \\[\sigspace]

                     \> \@thesisadvisortwo \\
                     \> Thesis Co-Advisor \\[\sigspace]

                     \> \@secondreader \\
                     \> Second Reader \\[\sigspace]

                     \> \@departmentchair \\
                     \>  Chair, \@department

                  \ifthenelse{\equal{\@departmenttwo}{}}{\\}{ %
                     \\[\sigspace]
                     \> \@departmentchairtwo \\
                     \> Chair, \@departmenttwo \\
                  }
      \end{tabbing}
    %% advisor + reader
    \else
      \newcommand{\sigspace}{1.5pc}

      \vfill
      \begin{tabbing}
      \hspace{1.5in}\=\\       % Set the tabs

      \iftwoauthors
      Authors: \> \@author \\[\sigspace]
               \> \@authortwo\\[\sigspace]
      \else
      Author: \> \@author \\[\sigspace]
      \fi

      Approved by:   \> \@thesisadvisor \\
                     \> Thesis Advisor \\[\sigspace]

                     \> \@secondreader \\
                     \> Second Reader \\[\sigspace]

                     \> \@departmentchair \\
                     \>  Chair, \@department

                  \ifthenelse{\equal{\@departmenttwo}{}}{\\}{ %
                     \\[\sigspace]
                     \> \@departmentchairtwo \\
                     \> Chair, \@departmenttwo \\
                  }
      \end{tabbing}
    \fi
    \fi
  \fi
  \cleardoublepage
}

\newif\ifNPSabstractWasPrinted\NPSabstractWasPrintedfalse
\def\NPSabstractpage{
  \begin{center}
  \textbf{{\large\ULABEL ABSTRACT}}\\
  \end{center}
  \begin{minipage}{\textwidth}
  \vspace{2pc}
  \onehalfspacing                 % a really bad idea, but apparently required
  \ifnpstraditional\hspace{.5in}\fi % indent if traditional
  \@abstract
  \end{minipage}
  \singlespacing                % back to single spacing
  \NPSabstractWasPrintedtrue
  \cleardoublepage
}

\def\NPSfrontmatter{
  \ifnpstraditional
  \else
    \lhead{\nouppercase{\rightmark}} % don't use upper-case headers
    \rhead{\nouppercase{\leftmark}}  % must appear after \pagestyle command
  \fi
  \singlespacing
}

\newcommand{\NPSsignature}{
  % this page is always (iii), so force skip (used in non-twoside mode)
  \ifnum \c@page < 3 \thisPageIntentionallyLeftBlankForced \fi
  \setcounter{page}{3}          % do not reset to page 1
  \begin{center}
  \textbf{NAVAL POSTGRADUATE SCHOOL\\Monterey, California 93943-5000}
  \end{center}

  \begin{tabbing}
  \hspace{3.5in} \= \hspace{2.5in} \= \\      % set the tabs
  \@president   \>   \@provost \\
  President     \>   \mbox{Provost}
  \end{tabbing}

  \ifthenelse{\NOT\equal{\@SponsoringNotation}{}}{%
    The report entitled ``\@title'' was \@SponsoringNotation
  }{}

  \vspace{\medskipamount}
  {\bf \@DistributionClause}
  \vfill

  \newcommand{\sigspace}{1.5pc}
  \textbf{This report was prepared by:}
  \begin{tabbing}
  \hspace{3.5in} \= \hspace{2.5in} \= \\      % set the tabs
  \\[\sigspace]
  \@SignatureOne     \> \iftwoauthors \@SignatureTwo \fi \\[-2pc]
  \rule{2.5in}{1pt}  \> \iftwoauthors \rule{2.5in}{1pt} \fi \\
  \@author           \> \iftwoauthors \@authortwo \fi \\
  \@rank             \> \iftwoauthors \@ranktwo \fi \\[\sigspace]

  \ifthreeauthors
  \\[\sigspace]
  \@SignatureThree   \> \iffourauthors \@SignatureFour \fi \\[-2pc]
  \rule{2.5in}{1pt}  \> \iffourauthors \rule{2.5in}{1pt} \fi \\
  \@authorthree      \> \iffourauthors \@authorfour \fi \\
  \@rankthree        \> \iffourauthors \@rankfour \fi \\[\sigspace]
  \fi

  \\[\sigspace]
  {\bf Reviewed by:} \> {\bf Released by:} \\[\sigspace]
  \\ \vspace{1.5\bigskipamount}
  \rule{2.5in}{1pt}  \> \rule{2.5in}{1pt} \\
  \@departmentchair\xspace, Chairman  \> \@researchchair \\
  \@department       \> \mbox{Dean of Research} \\
  \end{tabbing}
  \newpage
  \thisPageIntentionallyLeftBlank
}

\newcommand{\NPSbody}{
  \renewcommand{\topfraction}{0.99}
  %\renewcommand{\textfracton}{0.10}
  \renewcommand{\floatpagefraction}{0.99}
  \ifnpssinglespace
     \singlespace
     \ifnpstight
        \titlespacing*{\section}{0pt}{6pt plus 1ex}{0pt}
        \titlespacing*{\subsection}{0pt}{6pt plus 1ex}{0pt}
        \titlespacing*{\subsubsection}{0pt}{6pt plus 1ex}{0pt}
     \fi
  \else
     \onehalfspacing
  \fi
  \cleardoublepage
  \pagenumbering{arabic}

  \ifNPSabstractWasPrinted
    % do not print the abstract
  \else
    \begin{center}\textbf{\ULABEL\abstractname}\end{center}
    \begin{quotation}
    \@abstract
    \end{quotation}
  \fi
}


%*************************************************************************
% Commands for Special Sections
%*************************************************************************

\newcommand{\NPSexecsummary}[1]{%
\ifnpsarticle
  \begin{center}\textbf{\large{\ULABEL\execsummaryname}}\end{center}
\else
  \chapter*{\ULABEL\execsummaryname}
  %\addcontentsline{toc}{chapter}{\execsummaryname}
\fi
  \def\execsummaryname{}
  \onehalfspacing
  #1
  \cleardoublepage
}

\newcommand{\NPSacknowledgements}[1]{
\ifnpsarticle
  \begin{center}\textbf{\large{\ULABEL\acknowledgementsname}}\end{center}
\else
  \chapter*{\ULABEL\acknowledgementsname}
  %\addcontentsline{toc}{chapter}{\acknowledgementsname}
\fi
  \def\acknowledgementsname{}
  \onehalfspacing
  #1
  \cleardoublepage
}

\newcommand{\NPSbibliography}[1]{
\ifnpsarticle
  \clearpage
\else
  \cleardoublepage
\fi
  \bibliographystyle{nps_thesis}
  \raggedright      % don't automatically full justify bibliographic references
  \singlespacing    % reduce extra line breaks between entries
\ifnpsarticle
  \addcontentsline{toc}{section}{\ULABEL\bibname}
\else
  \addcontentsline{toc}{chapter}{\ULABEL\bibname}
\fi
  \bibliography{#1}
  \doublespacing
}

% This is a legacy command for compatibility.  The newer command is below.
\newcommand{\NPSdistribution}[1]{
\ifnpsarticle
  \section*{#1}
  \addcontentsline{toc}{section}{#1}
\else
  \def\chaptername{#1}
  \chapter*{#1}
  \addcontentsline{toc}{chapter}{#1}
\fi
  \singlespacing    % reduce extra line breaks between entries
  \newenvironment{distributionlist}
    {\begin{enumerate}\itemsep \baselineskip}
    {\end{enumerate}}
}

\newcommand{\NPSdistributionlist}{
\ifnpsarticle
  \clearpage
\else
  \cleardoublepage
\fi
\ifnpsarticle
  %\section*{\ULABEL\distribname}
  \begin{center}\textbf{\large{\ULABEL\distribname}}\end{center}
  \addcontentsline{toc}{section}{\distribname}
\else
  \chapter*{\ULABEL\distribname}
  \addcontentsline{toc}{chapter}{\distribname}
\fi
  \singlespacing    % reduce extra line breaks between entries
  \newenvironment{distributionlist}
    {\begin{enumerate}\itemsep \baselineskip}
    {\end{enumerate}}
}

\newcommand{\NPStableOfContents}{
\ifnpsarticle
  %\section*{\ULABEL\contentsname}
  \begin{center}\textbf{\large{\ULABEL\contentsname}}\end{center}
\else
  \chapter*{\ULABEL\contentsname}
\fi
  \lhead{}\rhead{}
  \def\contentsname{}           % clear, because it will be in the header
  \tableofcontents
  \cleardoublepage
}

\newcommand{\NPSlistOfFigures}{
  \lhead{}\rhead{}
\ifnpsarticle
  %\section*{\ULABEL\listfigurename}
  %\addcontentsline{toc}{section}{\listfigurename}
  \begin{center}\textbf{\large{\ULABEL\listfigurename}}\end{center}
\else
  \chapter*{\ULABEL\listfigurename}
  %\addcontentsline{toc}{chapter}{\listfigurename}
\fi
  \def\listfigurename{}
  \listoffigures
  \cleardoublepage
}

\newcommand{\NPSlistOfTables}{
  \lhead{}\rhead{}
\ifnpsarticle
  %\section*{\ULABEL\listtablename}
  %\addcontentsline{toc}{section}{\listtablename}
  \begin{center}\textbf{\large{\ULABEL\listtablename}}\end{center}
\else
  \chapter*{\ULABEL\listtablename}
  %\addcontentsline{toc}{chapter}{\listtablename}
\fi
  \def\listtablename{}
  \listoftables
  \cleardoublepage
}

\newcommand{\NPSlistOfAcronyms}[1]{
  \lhead{}\rhead{}
\ifnpsarticle
  %\section*{\ULABEL\listacronymname}\vspace{1pc}
  %\addcontentsline{toc}{section}{\listacronymname}
  \begin{center}\textbf{\large{\ULABEL\listacronymname}}\end{center}
\else
  \chapter*{\ULABEL\listacronymname}
  %\addcontentsline{toc}{chapter}{\listacronymname}
\fi
  \def\listacronymname{}
  \onehalfspacing
  #1
  \cleardoublepage
}

\newcommand{\NPSlistOfAcronymsFromFile}[1]{
  \lhead{}\rhead{}
\ifnpsarticle
  %\section*{\ULABEL\listacronymname}\vspace{1pc}
  %\addcontentsline{toc}{section}{\listacronymname}
  \begin{center}\textbf{\large{\ULABEL\listacronymname}}\end{center}
  \vspace{1ex}
\else
  \chapter*{\ULABEL\listacronymname}
  %\addcontentsline{toc}{chapter}{\listacronymname}
  \vspace{2ex}
\fi
  \def\listacronymname{}
  \onehalfspacing
  \input{#1}
  \cleardoublepage
}



%*************************************************************************
% Simson Garfinkel's layout routines
% From this PhD Thesis
%*************************************************************************

\newcommand{\minipagegraphic}[2]{
  \begin{minipage}{#1\textwidth}
  \includegraphics[width=\textwidth]{#2}
  \end{minipage}
}

% \sgraphic[optional width=8in]{filename}{caption}
% Then use \figref{filename} to get a reference to the figure
\newcommand{\sgraphic}[3][width=\linewidth]{
  \begin{figure}
  \begin{center}
  \fbox{\includegraphics[#1]{#2}}
  \end{center}
  \caption{#3\label{#2}}
  \end{figure}
}

% \sgraphicb[optional width=8in]{filename}{caption}
% \sgraphicb is like sgraphic, but may put it at the bottom of the page
\newcommand{\sgraphicb}[3][width=\linewidth]{
  \begin{figure}
  \begin{center}
  \fbox{\includegraphics[#1]{#2}}
  \end{center}
  \caption{#3\label{#2}}
  \end{figure}
}

% \sgraphicn[optional width=8in]{filename}{caption}
% \sgraphicn is like sgraphic, but does not put a box around the graphic
\newcommand{\sgraphicn}[3][width=\textwidth]{
  \begin{figure}
  \begin{center}
  \includegraphics[#1]{#2}
  \end{center}
  \caption{#3\label{#2}}
  \end{figure}
}

% \sgraphico[optional width=8in]{filename}{caption}
% \sgraphico is like sgraphic, but it doesn't create a figure
\newcommand{\sgraphico}[3][width=\textwidth]{
  \begin{center}
  \fbox{\includegraphics[#1]{#2}}
  \end{center}
%  \caption{#3\label{#2}}
}

% \sgraphicon[optional width=8in]{filename}{caption}
\newcommand{\sgraphicon}[3][width=\textwidth]{
  \begin{center}
  \includegraphics[#1]{#2}
  \end{center}
%  \caption{#3\label{#2}}
}


% \twofigures{width1}{imagefile1}{caption1}
%            {width2}{imagefile2}{caption2}
\newcommand{\twofigures}[6]{
  \begin{figure}
    \begin{tabularx}{\textwidth}{p{#1}Xp{#4}}
  \includegraphics[width=#1]{#2} &&
  \includegraphics[width=#4]{#5} \\
  \caption{#3\label{#2}} &&
  \caption{#6\label{#5}} \\
\end{tabularx}
\end{figure}
}

% \twoimages{imagefile1}{imagefile2}{caption}
\newcommand{\twoimages}[3]{
  \begin{figure}
  \includegraphics[width=.5\textwidth]{#1} 
  \hspace{1pc}
  \includegraphics[width=.5\textwidth]{#2} 
  \caption{#3\label{#1}}
  \end{figure}
}

% \sidebyside[placementidentifier]{contents1}{contents2}{caption}{label}
% figure side by side
% see http://en.wikibooks.org/wiki/LaTeX/Floats,_Figures_and_Captions#Figures
% for placement identifiers.
% Contents is a placeholder for an image, text, etc.
\newcommand{\sidebyside}[5][ht]{
  \begin{figure*}[#1]
    \begin{minipage}[t]{.45\columnwidth}
      #2
    \end{minipage}
    \hfill
    \begin{minipage}[t]{.45\columnwidth}
      #3
    \end{minipage}
    \caption{#4\label{#5}}
  \end{figure*}
}

% \tsidebyside[placementidentifier]{contents1}{contents2}{caption}{label}
% table side by side
% see http://en.wikibooks.org/wiki/LaTeX/Tables#The_table_environment_-_captioning_etc
% for placement identifiers.
% Contents is a placeholder for an image, text, etc.
\newcommand{\tsidebyside}[5][ht]{
  \begin{table*}[#1]
    \begin{minipage}[t]{.45\columnwidth}
      #2
    \end{minipage}
    \hfill
    \begin{minipage}[t]{.45\columnwidth}
      #3
    \end{minipage}
    \caption{#4\label{#5}}
  \end{table*}
}

% \threesidebyside[placementidentifier]{contents1}{contents2}{contents3}{caption}{label}
% figure side by side
% see http://en.wikibooks.org/wiki/LaTeX/Floats,_Figures_and_Captions#Figures
% for placement identifiers.
% Contents is a placeholder for an image, text, etc.
\newcommand{\threesidebyside}[6][ht]{
  \begin{figure*}[#1]
    \begin{minipage}[t]{.31\columnwidth}
      #2
    \end{minipage}
    \hfill
    \begin{minipage}[t]{.31\columnwidth}
      #3
    \end{minipage}
    \hfill
    \begin{minipage}[t]{.31\columnwidth}
      #4
    \end{minipage}
    \caption{#5\label{#6}}
  \end{figure*}
}


\endinput
