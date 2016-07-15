%%
%% npsreport.cls
%% LaTeX class file for NPS Theses and Tech Reports
%% Version 1.9
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
\newif\ifcompacttitle\compacttitlefalse
\newif\ifnpstwoside\npstwosidefalse
\newif\ifnpsauthorindex\npsauthorindexfalse
\newif\ifnpsarticle\npsarticlefalse
\newif\ifnpsthesis\npsthesisfalse
\newif\iftwoauthors\twoauthorsfalse
\newif\ifthreeauthors\threeauthorsfalse
\newif\iffourauthors\fourauthorsfalse
\newif\iftwoadvisors\twoadvisorsfalse
\newif\iftwoadvisorsreader\twoadvisorsreaderfalse
\newif\iftworeaders\tworeadersfalse
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
\DeclareOption{traditional}{\npstraditionalfalse}  % no longer supported option
\DeclareOption{compacttitle}{\compacttitletrue}
\DeclareOption{twoside}{\npstwosidetrue}
\DeclareOption{authorindex}{\npsauthorindextrue}   % generate an author index
\DeclareOption{thesis}{\npsthesistrue}             % is this a thesis?
\DeclareOption{twoauthors}{\twoauthorstrue}        % two students? 
\DeclareOption{threeauthors}{\threeauthorstrue}    % or three students?
\DeclareOption{fourauthors}{\fourauthorstrue}      % or four students? 
\DeclareOption{twoadvisors}{\twoadvisorstrue}      % two advisors? (but no second reader)
\DeclareOption{twoadvisorsreader}{\twoadvisorsreadertrue}      % two advisors? (AND also second reader)
\DeclareOption{tworeaders}{\tworeaderstrue}        % two readers
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

\ProcessOptions               % Process options to get \ifnpstwoside
\ifnpstwoside
  \PassOptionsToClass{twoside}{geometry}
  \PassOptionsToClass{twoside}{report}           % Options for report
  \PassOptionsToClass{openright}{report}
  \PassOptionsToClass{twoside}{article}          % Options for article
  \PassOptionsToClass{openright}{article}
\fi

% Now process all the options
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
\usepackage{layout}
\newgeometry{includeheadfoot,            % headers and footers aren't in margins
             right=1.25in,left=1.25in,   % right/left margins
             top=1in,bottom=1in,         % top/bottom margins
             footskip=25pt,              % pg nums in footer need breathing room
             marginparwidth=0pt,         % no marginal paragraphs
             marginparsep=0pt,           % no marginal paragraphs
             head=30pt,headsep=0pt,hoffset=0pt}

%% Font selection
\usepackage[T1]{fontenc}        % http://tex.stackexchange.com/questions/664/why-should-i-use-usepackaget1fontenc
\usepackage[hyphens]{url}       % make\url work (be nice have [lowtidle])
\usepackage{ragged2e}           % RaggedRight puts url linebreaks in slightly better places
\usepackage{eurosym}
\usepackage{amsmath,amsfonts}   % for many types of math equations
\urlstyle{same}                 % don't put \url{} into monospace font

\iffontnameset
  % Font name is set
\else
  \fonttimessettrue
\fi 

\iffonttimesset             % print the thesis in Times
  % \usepackage{mathptmx}   % ugly math font for times: we are no longer using it
  \usepackage{newtxtext}
  \usepackage[varg,cmintegrals,cmbraces]{newtxmath}
  \renewcommand{\sfdefault}{cmss}
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
\usepackage[labelfont=sf,textfont=sf]{caption}
                                % needs to be before tocloft, to avoid conflict
\usepackage[labelfont=sf,textfont=sf,caption=false]{subfig}
\usepackage[subfigure]{tocloft} % TOC Control

% for compatibility with older subfigure package, to get \subfigure{} macro
\@ifundefined{c@subfigure}{\newsubfloat{figure}}{}
\def\subfigure{\subfloat}

\usepackage{bibentry}           % to put full citations directly in text
\nobibliography*                % required for bibentry package

\newcommand{\NPShyperref}{
% Adds the hyperref package. Populate the PDF metadata.
% References and citations will have clickable links.
\makeatletter
\usepackage[pdftex,                % use PDFTeX backend
   hidelinks,                      % No colored links or borders
   breaklinks,                     % use linebreaks w/in urls under pdftex
   pdfkeywords={\sf@SubjectTerms}, % use Subject terms from SF-298
   pdftitle={\@title},             % set the title
\iffourauthors
   pdfauthor={\@author; \@authortwo; \@authorthree; \@authorfour},
\else
 \ifthreeauthors
   pdfauthor={\@author; \@authortwo; \@authorthree},
 \else
  \iftwoauthors
   pdfauthor={\@author; \@authortwo},
  \else
   pdfauthor={\@author},
  \fi %two
 \fi %three
\fi %four
]{hyperref}
\usepackage[all]{hypcap}
\makeatother
}


\pagenumbering{roman}

% Control widows, orphans, and floats
\renewcommand{\topfraction}{0.90}
\renewcommand{\floatpagefraction}{0.90}
\setcounter{topnumber}{10}   % up to 10 floats at the top of the page; Should be enough
\setcounter{totalnumber}{10} % see above

% Make citations look like [1]--[4] instead of [1--4]
\def\citepunct{], [}
\def\citedash{]--[}

% Here are some commands that will help you make more attractive LaTeX
% Notice that \etal is italicized, but not e.g., etc. , or i.e.
% Please see p. 5, Section VI, para. 3, of The IEEE Editorial Style Manual
%\newcommand{\checkmark}{\Pisymbol{pzd}{52}}
\newcommand{\eg}{\@ifnextchar{,}{e.g.}{e.g.,\xspace}}
\newcommand{\ie}{\@ifnextchar{,}{i.e.}{i.e.,\xspace}}
\newcommand{\etc}{\@ifnextchar{.}{etc}{etc.\@\xspace}}
\newcommand{\etal}{\@ifnextchar{.}{et al}{et al.\@\xspace}}
\newcommand{\naive}{na\"{\i}ve\xspace}
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

% For first author
\def\degreedate#1{\date{#1}}
\def\rank#1{\setbox0\hbox{#1} \gdef\@rank{#1}} \rank{}
\def\prevdegrees#1{\gdef\@prevdegrees{#1}} \def\@prevdegrees{}

% For a second author
\def\authortwo#1{\setbox0\hbox{#1} \gdef\@authortwo{#1}} \authortwo{}
\def\ranktwo#1{\setbox0\hbox{#1}  \gdef\@ranktwo{#1}} \ranktwo{}
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

% Single degree or dual degree options
\def\degree#1{\gdef\@degree{#1}}                 \gdef\@degree{}
\gdef\@degreeword{degree}
\def\degreetwo#1{\gdef\@degreetwo{#1}\gdef\@degreeword{degrees}}
\gdef\@degreetwo{}

% Degree abbreviation
\def\degreeabbreviation#1{\setbox0\hbox{#1}\gdef\@degreeabbreviation{#1}}

\def\declassifydate#1{\gdef\@declassifydate{#1}} \gdef\@declassifydate{}
\def\classifiedby#1{\gdef\@classifiedby{#1}}     \gdef\@classifiedby{}
\def\classifiedfrom#1{\gdef\@classifiedfrom{#1}} \gdef\@classifiedfrom{Multiple Sources}

\def\department#1{\gdef\@department{#1}}
\def\departmenttwo#1{\gdef\@departmenttwo{#1}}   \gdef\@departmenttwo{}


% \departmentchair
\DeclareRobustCommand\departmentchair{
  \@ifnextchar[{\@@@departmentchairalt}{\@@@departmentchair}}
\def\@@@departmentchairalt[#1]#2{
  \gdef\@departmentchair{#2}
  \gdef\@@departmentchair{#1}
}
\def\@@@departmentchair#1{
  \gdef\@departmentchair{#1}
  \gdef\@@departmentchair{#1}
}

% \committeechair
\DeclareRobustCommand\committeechair{
  \@ifnextchar[{\@@@committeechairalt}{\@@@committeechair}}
\def\@@@committeechairalt[#1]#2{
  \gdef\@committeechair{#2}
  \gdef\@@committeechair{#1}
}
\def\@@@committeechair#1{
  \gdef\@committeechair{#1}
  \gdef\@@committeechair{#1}
}

% \departmentchairtwo
\DeclareRobustCommand\departmentchairtwo{
  \@ifnextchar[{\@@@departmentchairtwoalt}{\@@@departmentchairtwo}}
\def\@@@departmentchairtwoalt[#1]#2{
  \gdef\@departmentchairtwo{#2}
  \gdef\@@departmentchairtwo{#1}
}
\def\@@@departmentchairtwo#1{
  \gdef\@departmentchairtwo{#1}
  \gdef\@@departmentchairtwo{#1}
}

% \researchchair
\DeclareRobustCommand\researchchair{
  \@ifnextchar[{\@@@researchchairalt}{\@@@researchchair}}
\def\@@@researchchairalt[#1]#2{
  \gdef\@researchchair{#2}
  \gdef\@@researchchair{#1}
}
\def\@@@researchchair#1{
  \gdef\@researchchair{#1}
  \gdef\@@researchchair{#1}
}

% \president
\DeclareRobustCommand\president{
  \@ifnextchar[{\@@@presidentalt}{\@@@president}}
\def\@@@presidentalt[#1]#2{
  \gdef\@president{#2}
  \gdef\@@president{#1}
}
\def\@@@president#1{
  \gdef\@president{#1}
  \gdef\@@president{#1}
}

% \provost
\DeclareRobustCommand\provost{
  \@ifnextchar[{\@@@provostalt}{\@@@provost}}
\def\@@@provostalt[#1]#2{
  \gdef\@provost{#2}
  \gdef\@@provost{#1}
}
\def\@@@provost#1{
  \gdef\@provost{#1}
  \gdef\@@provost{#1}
}

% \viceprovost
\DeclareRobustCommand\viceprovost{
  \@ifnextchar[{\@@@viceprovostalt}{\@@@viceprovost}}
\def\@@@viceprovostalt[#1]#2{
  \gdef\@viceprovost{#2}
  \gdef\@@viceprovost{#1}
}
\def\@@@viceprovost#1{
  \gdef\@viceprovost{#1}
  \gdef\@@viceprovost{#1}
}

% \assocprovost  % legacy macro for backwards compat
\DeclareRobustCommand\assocprovost{
  \@ifnextchar[{\@@@assocprovostalt}{\@@@assocprovost}}
\def\@@@assocprovostalt[#1]#2{
  \gdef\@assocprovost{#2}
  \gdef\@@assocprovost{#1}
}
\def\@@@assocprovost#1{
  \gdef\@assocprovost{#1}
  \gdef\@@assocprovost{#1}
}

% \thesisadvisor
\DeclareRobustCommand\thesisadvisor{
  \@ifnextchar[{\@@@thesisadvisoralt}{\@@@thesisadvisor}}
\def\@@@thesisadvisoralt[#1]#2{
  \gdef\@thesisadvisor{#2}
  \gdef\@@thesisadvisor{#1}
}
\def\@@@thesisadvisor#1{
  \gdef\@thesisadvisor{#1}
  \gdef\@@thesisadvisor{#1}
}

% \thesisadvisorone
\DeclareRobustCommand\thesisadvisorone{
  \@ifnextchar[{\@@@thesisadvisoronealt}{\@@@thesisadvisorone}}
\def\@@@thesisadvisoronealt[#1]#2{
  \gdef\@thesisadvisorone{#2}
  \gdef\@@thesisadvisorone{#1}
}
\def\@@@thesisadvisorone#1{
  \gdef\@thesisadvisorone{#1}
  \gdef\@@thesisadvisorone{#1}
}

% \thesisadvisortwo
\DeclareRobustCommand\thesisadvisortwo{
  \@ifnextchar[{\@@@thesisadvisortwoalt}{\@@@thesisadvisortwo}}
\def\@@@thesisadvisortwoalt[#1]#2{
  \gdef\@thesisadvisortwo{#2}
  \gdef\@@thesisadvisortwo{#1}
}
\def\@@@thesisadvisortwo#1{
  \gdef\@thesisadvisortwo{#1}
  \gdef\@@thesisadvisortwo{#1}
}

% \secondreader
\DeclareRobustCommand\secondreader{
  \@ifnextchar[{\@@@secondreaderalt}{\@@@secondreader}}
\def\@@@secondreaderalt[#1]#2{
  \gdef\@secondreader{#2}
  \gdef\@@secondreader{#1}
}
\def\@@@secondreader#1{
  \gdef\@secondreader{#1}
  \gdef\@@secondreader{#1}
}

% \secondreadertwo
\DeclareRobustCommand\secondreadertwo{
  \@ifnextchar[{\@@@secondreadertwoalt}{\@@@secondreadertwo}}
\def\@@@secondreadertwoalt[#1]#2{
  \gdef\@secondreadertwo{#2}
  \gdef\@@secondreadertwo{#1}
}
\def\@@@secondreadertwo#1{
  \gdef\@secondreadertwo{#1}
  \gdef\@@secondreadertwo{#1}
}

% Dissertation committee members 1--6

% \memberOne
\DeclareRobustCommand\memberOne{
  \@ifnextchar[{\@@@memberOnealt}{\@@@memberOne}}
\def\@@@memberOnealt[#1]#2{
  \gdef\@memberOne{#2}
  \gdef\@@memberOne{#1}
}
\def\@@@memberOne#1{
  \gdef\@memberOne{#1}
  \gdef\@@memberOne{#1}
}

% \memberTwo
\DeclareRobustCommand\memberTwo{
  \@ifnextchar[{\@@@memberTwoalt}{\@@@memberTwo}}
\def\@@@memberTwoalt[#1]#2{
  \gdef\@memberTwo{#2}
  \gdef\@@memberTwo{#1}
}
\def\@@@memberTwo#1{
  \gdef\@memberTwo{#1}
  \gdef\@@memberTwo{#1}
}

% \memberThree
\DeclareRobustCommand\memberThree{
  \@ifnextchar[{\@@@memberThreealt}{\@@@memberThree}}
\def\@@@memberThreealt[#1]#2{
  \gdef\@memberThree{#2}
  \gdef\@@memberThree{#1}
}
\def\@@@memberThree#1{
  \gdef\@memberThree{#1}
  \gdef\@@memberThree{#1}
}

% \memberFour
\DeclareRobustCommand\memberFour{
  \@ifnextchar[{\@@@memberFouralt}{\@@@memberFour}}
\def\@@@memberFouralt[#1]#2{
  \gdef\@memberFour{#2}
  \gdef\@@memberFour{#1}
}
\def\@@@memberFour#1{
  \gdef\@memberFour{#1}
  \gdef\@@memberFour{#1}
}

% \memberFive
\DeclareRobustCommand\memberFive{
  \@ifnextchar[{\@@@memberFivealt}{\@@@memberFive}}
\def\@@@memberFivealt[#1]#2{
  \gdef\@memberFive{#2}
  \gdef\@@memberFive{#1}
}
\def\@@@memberFive#1{
  \gdef\@memberFive{#1}
  \gdef\@@memberFive{#1}
}

% \memberSix
\DeclareRobustCommand\memberSix{
  \@ifnextchar[{\@@@memberSixalt}{\@@@memberSix}}
\def\@@@memberSixalt[#1]#2{
  \gdef\@memberSix{#2}
  \gdef\@@memberSix{#1}
}
\def\@@@memberSix#1{
  \gdef\@memberSix{#1}
  \gdef\@@memberSix{#1}
}

% Provide reasonable defaults
\department{Computer Science}
\departmentchair{Peter Denning}
\researchchair{Jeffrey D. Paduan}
\president{Ronald A. Route}
\provost{Douglas A. Hensler}
\viceprovost{Douglas Moses}
\memberOne[\@@thesisadvisor]{\@thesisadvisor}
\memberTwo[\@committeechair]{\@committeechair}
\memberThree{}
\memberFour{}
\memberFive{}
\memberSix{}


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
\else
  \usepackage{acronym}
\fi
\newcommand{\NPSacrocommon}{}   % custom macro to play with acronym counters

\iffonttimesset
  % fixes the acronym list when using times font (default, arial)
  \ifthenelse{\isundefined{\bflabel}}{% new ver. of acronym uses \aclabel:
    \renewcommand{\aclabelfont}[1]{{\textbf{#1}\hfill}}
  }{% older versions of acronym use \bflabel:
    \renewcommand{\bflabel}[1]{{\textbf{#1}\hfill}}
  }
\fi
\iffontcourierset
  % fixes the acronym list when using courier font
  % if using older versions of acronym, changed via \bflabel:
  \ifthenelse{\isundefined{\bflabel}}{% new ver. of acronym uses \aclabel:
    \renewcommand{\aclabelfont}[1]{{\textbf{\texttt{#1}}\hfill}}
  }{% older versions of acronym use \bflabel:
    \renewcommand{\bflabel}[1]{{\textbf{\texttt{#1}}\hfill}}
  }
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
\def\appendixname{Appendix}
\def\appendicesname{Appendices}
\def\contentsname{Table of Contents}
\def\listacronymname{List of Acronyms and Abbreviations}
\def\distribname{Initial Distribution List}
\def\acknowledgementsname{Acknowledgments}
\def\execsummaryname{Executive Summary}
\def\bibname{List of References}

%
% Title Control
% This is done with the titlesec package
%
\titleformat{\chapter}[display]
          {\singlespacing\vskip 0\p@ \LARGE\filcenter\sffamily\titlerule[1pt]\vspace{1pt}\titlerule}
          {\MakeUppercase{\chaptertitlename} \thechapter:} % label (not for * chapters)
          {-1pc}           % sep
          {}               % before
          [\titlerule]     % after
\titleformat{\section}
          {\singlespacing\normalfont\Large\bfseries}
          {\thesection}
          {1em}
          {}%
\titleformat{\subsection}
          {\singlespacing\normalfont\large\bfseries}
          {\thesubsection}
          {1em}
          {}%
\titleformat{\subsubsection}
          {\singlespacing\normalfont\normalsize\bfseries}
          {\thesubsubsection}
          {1em}
          {}%

% ``The starred version kills the indention of the paragraph following the title.''
% \titlespacing%{<command>}{<left>}{<beforesep>}{<aftersep>}[<right>]
\titlespacing*{\chapter}{0pt}{-.5in}{.25in}
\titlespacing*{\section}{0pt}{0pt plus 2ex}{-2ex plus .2ex}
\titlespacing*{\subsection}{0pt}{0pt plus 2ex}{-2ex plus .2ex}
\titlespacing*{\subsubsection}{0pt}{0pt plus 2ex}{-2ex plus .2ex}
\titlespacing*{\paragraph}{0pt}{0pt plus 2ex}{3pt}
\setlength{\parskip}{2ex}
\setlength{\parindent}{0pt}


%
% Figure / Table Caption Control
% Put captions is a sanserif font, smaller, tighter, single space
%
\captionnamefont{\sffamily\fontsize{11}{12}\selectfont}
\captiontitlefont{\sffamily\fontsize{11}{12}\selectfont}
\captionsetup{font={stretch=1.0}}
\captionsetup{width=0.85\textwidth}
\captionsetup[table]{aboveskip=0pt,belowskip=5pt,labelsep=period}
\captionsetup[figure]{aboveskip=5pt,belowskip=0pt,labelsep=period}

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
  \setcounter{equation}{0}
  \setcounter{figure}{0}
  \setcounter{table}{0}
  \renewcommand{\theequation}{A.\arabic{equation}}
  \renewcommand{\thefigure}{A.\arabic{figure}}
  \renewcommand{\thetable}{A.\arabic{table}}
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
  \setcounter{equation}{0} % need to re-set b/c sections are unnumbered
  \setcounter{figure}{0}
  \setcounter{table}{0}
  \renewcommand{\theequation}{A.\arabic{equation}}
  \renewcommand{\thefigure}{A.\arabic{figure}}
  \renewcommand{\thetable}{A.\arabic{table}}
  \renewcommand{\thesection}{A.\arabic{section}}
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
  %\cftaddtitleline{toc}{chapter}{\appendicesname}{} % Insert ``Appendices'' into TOC
  \def\chaptername{\appendixname}  % not sure why this is needed, but it is
  \addtocontents{toc}{\protect\renewcommand*\protect\cftchappresnum{\appendixname\ }}
  \addtocontents{toc}{\protect\setlength{\cftchapnumwidth}{\widthof{\textbf{\appendixname~999~}}}}
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
% These commands are the first commands that run when printing
% starts, because the \NPScover command appears first
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
  %
  % technical report number
  \ifthenelse{\equal{\sf@POReportNumber}{}}{}{%
    \textbf{\sf@POReportNumber}\\[1ex]\par
  }
  %
  \centering
  \vspace*{0pt minus 100pt}                  % moves logo into margin if needed
  \includegraphics{figs/nps_logo_3clr_cymk}
  \vspace*{5pt plus 1fill minus 1pt}
  \textbf{\huge\ifclassified\Large\fi{}\\NAVAL\\POSTGRADUATE\\SCHOOL\\}
  \vspace{10pt plus 1fill minus 5pt}
  \textbf{\large MONTEREY, CALIFORNIA\\}
  \vspace{10pt plus 1fill minus 5pt}
  \ifnpsthesis
    \ifnpsdissertation
      \textbf{\huge DISSERTATION\\} 
    \else
      \textbf{\huge THESIS\\} 
    \fi
    \vspace{10pt plus 1fill minus 5pt}
  \fi  
  %
  % Print the box on the front page
  \setlength{\fboxrule}{1pt}
  \framebox[4.5in][c]{
  %
    \begin{minipage}{4.45in}
      \vspace{2pt}
      \centering
        \textbf{\MakeUppercase{\@title}}\\
        \vspace{12pt}
        by\\
        \vspace{12pt}
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
        \vspace{12pt}
        \@date\\
        \vspace{2pt}
        \ifnpsthesis
        \vspace{10pt}
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
                    \iftworeaders
                    Second Readers:     & \hspace{1in} & \@secondreader  \\
                                        & \hspace{1in} & \@secondreadertwo  \\
                    \else
                    Second Reader:      & \hspace{1in} & \@secondreader  \\
                    \fi
                  \else
                    Thesis Advisor:     & \hspace{1in} & \@thesisadvisor \\
                    \iftworeaders
                    Second Readers:     & \hspace{1in} & \@secondreader  \\
                                        & \hspace{1in} & \@secondreadertwo  \\
                    \else
                    Second Reader:      & \hspace{1in} & \@secondreader  \\
                    \fi
                  \fi
                \fi
            \fi
          \end{tabularx}
        \fi
    \end{minipage}
  }
  \vspace{2pt plus 1fill minus 2pt}
  %
  % distribution statement
  \newdimen\dsheight       % height of distribution statement w/ normal settings
  \settoheight\dsheight{
    \begin{minipage}{\textwidth} \singlespacing \bf \small \@distribution \end{minipage}
  }
  \begin{minipage}{\textwidth}\begin{singlespace}
  \ifdim\dsheight>20pt     % choose different font for long statements
    \centering \bf \fontsize{9}{11}\selectfont \@distribution
  \else                    % normal setting for short statements
    \centering \bf \small \@distribution
  \fi
  \end{singlespace}\end{minipage}
  %
  % Report Prepared By:
  %   define \RPTpreparedFor when needed in you tex file
  \ifthenelse{\equal{\@RPTpreparedFor}{}}{}{%
    \vspace{\smallskipamount}
    Prepared for: \@RPTpreparedFor
  }
  \ifclassified 
    \vfill
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
    \vspace*{10pt minus 8pt}   % little flex between notice and footer markings
  \fi
  \vfill
  \end{titlepage}
  %
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

% Definitions for the dissertation title page identifications
\newcommand{\NPSsigfont}{\normalsize}
\newcommand{\NPScommitteebox}[1]{\parbox[t]{2.2in}{\raggedright #1}}
\newcommand{\sigspace}{45pt minus 30pt}

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
    %
    % distribution statement
    \newdimen\dsheight       % height of distribution statement w/ normal settings
    \settoheight\dsheight{
      \begin{minipage}{\textwidth} \centering \bf \@distribution \end{minipage}
    }
    \begin{minipage}{\textwidth}
    \ifdim\dsheight>50pt     % choose different font for long statements
      \centering \bf \fontsize{9pt}{10pt}\selectfont \@distribution
    \else                    % normal setting for short statements
      \centering \bf \@distribution
    \fi
    \end{minipage}
    %
    \vspace{20pt minus 5pt} % there is some built-in vspace after minipage
    \textbf{\singlespace \MakeUppercase{\@title}}\\
    \vspace{30pt minus 5pt}
    \@author~\\
    \@rank~\\
    \@prevdegrees\\
    \iftwoauthors
      \vspace{15pt plus 5pt}
      \@authortwo~\\
      \@ranktwo~\\
      \@prevdegreestwo\\
    \fi
    \vspace{30pt minus 15pt}
    Submitted in partial fulfillment of the\\
    requirements for the \@degreeword\ of\\
    \vspace{30pt minus 15pt}
    \textbf{\MakeUppercase{\@degree}}\\
      \ifthenelse{\equal{\@degreetwo}{}}{}{%
            \vspace{\smallskipamount}
            and \\ \vspace{\smallskipamount}
            \textbf{\MakeUppercase{\@degreetwo}}\\
      }
    \vspace{15pt minus 15pt}
    from the\\
    \vspace{15pt minus 15pt}
    \textbf{NAVAL POSTGRADUATE SCHOOL}\\
    \textbf{\@date}
  \end{center}
  \vspace{15pt plus 10pt minus 10pt}
  %%
  %% dissertation:
  %%
  \ifnpsdissertation
      %
      \NPSsigfont
      \begin{tabbing}
      \hspace{1.1in} \= \hspace{2.4in} \= \\      % Set the tabs

      %% Row 1:
      % process member 1
      \ifadvisoralone
      Approved by: \> \@@memberOne \\
                   \> \NPScommitteebox{\@memberOneTitleLine} \\[\sigspace]
      \else
      % process member 1 and 2
      Approved by: \> \@@memberOne
                   \> \@@memberTwo \\
                   \> \NPScommitteebox{\@memberOneTitleLine} \>
                      \NPScommitteebox{\@memberTwoTitleLine} \\[\sigspace]
      \fi
      %% Row 2:
      \ifadvisoralone
      % process member 2 and 3
                   \> \@@memberTwo
                   \> \@@memberThree \\
                   \> \NPScommitteebox{\@memberTwoTitleLine} \>
                      \NPScommitteebox{\@memberThreeTitleLine} \\[\sigspace]
      \else
      % process member 3 and 4
                   \> \@@memberThree
                   \> \@@memberFour \\
                   \> \NPScommitteebox{\@memberThreeTitleLine} \>
                      \NPScommitteebox{\@memberFourTitleLine} \\[\sigspace]
      \fi
      %% Row 3:
      \ifadvisoralone
      % process member 4 and 5
                   \> \@@memberFour
                   \> \@@memberFive \\
                   \> \NPScommitteebox{\@memberFourTitleLine} \>
                      \NPScommitteebox{\@memberFiveTitleLine} \\[\sigspace]
      \else
      \iffivemembers
      % process member 5 and done
                   \> \@@memberFive \\
                   \> \NPScommitteebox{\@memberFiveTitleLine} \\[\sigspace]
      \else
      % process member 5 and 6
                   \> \@@memberFive
                   \> \@@memberSix \\
                   \> \NPScommitteebox{\@memberFiveTitleLine} \> %
                      \NPScommitteebox{\@memberSixTitleLine} \\[\sigspace]
      \fi
      \fi
      Approved by: \> \@@departmentchair \\
                   \> Chair, \@department \\[\sigspace]

      Approved by: \> \@@viceprovost \\
                   \> Vice Provost for Academic Affairs
      \end{tabbing}
      \normalsize
  %%
  %% thesis:
  %%
  \else
    %%
    %% co-advisors
    \iftwoadvisors
      \begin{tabbing}
      \hspace{1.5in}\=\\       % Set the tabs
  
      Approved by:   \> \@@thesisadvisorone \\
                     \> Thesis Co-Advisor \\[\sigspace]

                     \> \@@thesisadvisortwo \\
                     \> Thesis Co-Advisor \\[\sigspace]

                     \> \@@departmentchair \\
                     \>  Chair, \@department

                  \ifthenelse{\equal{\@departmenttwo}{}}{}{%
                     \\[\sigspace]
                     \> \@@departmentchairtwo \\
                     \> Chair, \@departmenttwo
                  }
      \end{tabbing}
    \else
    %%
    %% co-advisors + reader
    \iftwoadvisorsreader
      \ifcompacttitle  % compact version of this section
      \begin{tabbing}
      \hspace{1.5in}\=\hspace{2.5in}\=\\    % Two tab columns

      Approved by:   \> \@@thesisadvisorone   \> \@@thesisadvisortwo \\
                     \> Thesis Co-Advisor     \> Thesis Co-Advisor \\[\sigspace]

      \iftworeaders
                     \> \@@secondreader       \> \@@secondreadertwo \\
                     \> Second Reader         \> Second Reader \\[\sigspace]
      \else
                     \> \@@secondreader \\
                     \> Second Reader \\[\sigspace]
      \fi

                     \> \@@departmentchair \\
                     \>  Chair, \@department

                  \ifthenelse{\equal{\@departmenttwo}{}}{}{%
                     \\[\sigspace]
                     \> \@@departmentchairtwo \\
                     \> Chair, \@departmenttwo
                  }
      \end{tabbing}
      \else            % normal (long) version of this section
      \begin{tabbing}
      \hspace{1.5in}\=\\       % Set the tabs

      Approved by:   \> \@@thesisadvisorone \\
                     \> Thesis Co-Advisor \\[\sigspace]

                     \> \@@thesisadvisortwo \\
                     \> Thesis Co-Advisor \\[\sigspace]

                     \> \@@secondreader \\
                     \> Second Reader \\[\sigspace]

      \iftworeaders
                     \> \@@secondreadertwo \\
                     \> Second Reader \\[\sigspace]
      \fi

                     \> \@@departmentchair \\
                     \>  Chair, \@department

                  \ifthenelse{\equal{\@departmenttwo}{}}{}{%
                     \\[\sigspace]
                     \> \@@departmentchairtwo \\
                     \> Chair, \@departmenttwo
                  }
      \end{tabbing}
      \fi
    %%
    %% advisor + reader
    \else
      \ifcompacttitle  % compact version of this section
      \begin{tabbing}
      \hspace{1.5in}\=\hspace{2.5in}\=\\    % Two tab columns

      \iftworeaders
      Approved by:   \> \@@thesisadvisor \\
                     \> Thesis Advisor \\[\sigspace]

                     \> \@@secondreader   \> \@@secondreadertwo \\
                     \> Second Reader     \> Second Reader \\[\sigspace]
      \else
      Approved by:   \> \@@thesisadvisor   \> \@@secondreader \\
                     \> Thesis Advisor     \> Second Reader \\[\sigspace]
      \fi

                     \> \@@departmentchair \\
                     \>  Chair, \@department

                  \ifthenelse{\equal{\@departmenttwo}{}}{}{%
                     \\[\sigspace]
                     \> \@@departmentchairtwo \\
                     \> Chair, \@departmenttwo
                  }
      \end{tabbing}
      \else            % normal (long) version of this section
      \begin{tabbing}
      \hspace{1.5in}\=\\       % Set the tabs

      Approved by:   \> \@@thesisadvisor \\
                     \> Thesis Advisor \\[\sigspace]

                     \> \@@secondreader \\
                     \> Second Reader \\[\sigspace]

      \iftworeaders
                     \> \@@secondreadertwo \\
                     \> Second Reader \\[\sigspace]
      \fi

                     \> \@@departmentchair \\
                     \>  Chair, \@department

                  \ifthenelse{\equal{\@departmenttwo}{}}{}{%
                     \\[\sigspace]
                     \> \@@departmentchairtwo \\
                     \> Chair, \@departmenttwo
                  }
      \end{tabbing}
      \fi
    \fi
    \fi
  \fi
  \vspace{5pt plus 1fill minus 1pt}
  \cleardoublepage
}

\newif\ifNPSabstractWasPrinted\NPSabstractWasPrintedfalse
\def\NPSabstractpage{
  \begin{center}
  \textbf{{\large\ULABEL ABSTRACT}}\\
  \end{center}
  \begin{minipage}{\textwidth}
  \vspace{2pc}
  \onehalfspacing               % a really bad idea, but apparently required
  \@abstract
  \end{minipage}
  \singlespacing                % back to single spacing
  \NPSabstractWasPrintedtrue
  \acresetall                   % re-set acronym counter
  \NPSacrocommon{}
  \cleardoublepage
}

\def\NPSfrontmatter{
  \lhead{\nouppercase{\rightmark}} % don't use upper-case headers
  \rhead{\nouppercase{\leftmark}}  % must appear after \pagestyle command
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
  \raggedbottom

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
  \acresetall                   % re-set acronym counter
  \NPSacrocommon{}
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
  \acresetall                   % re-set acronym counter
  \NPSacrocommon{}
  \cleardoublepage
}

\newcommand{\NPSacknowledgments}[1]{ % make American spelling compatible
 \NPSacknowledgements{#1}
}

\newcommand{\NPSbibliography}[2][nps_thesis]{
\ifnpsarticle
  \clearpage
\else
  \cleardoublepage
\fi
  \bibliographystyle{#1}
  \RaggedRight      % don't automatically full justify bibliographic references
  \singlespacing    % reduce extra line breaks between entries
\ifnpsarticle
  \addcontentsline{toc}{section}{\ULABEL\bibname}
\else
  \addcontentsline{toc}{chapter}{\ULABEL\bibname}
\fi
  \bibliography{#2}
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
