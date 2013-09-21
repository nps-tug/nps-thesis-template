%% NPS BibTex file
%% Simson L. Garfinkel, 2008
%% Modified from a BibTex file producted automatically by xbtxbst, but with additional fields

ENTRY
  { address
    author
    booktitle
    chapter
    coden
    day
    edition
    editor
    howpublished
    institution
    lastchecked
    isbn
    issn
    journal
    key
    lccn
    month
    note
    number
    organization
    pages
    price
    publisher
    school
    series
    title
    type
    URL
    volume
    year
    classification
  }
  {}

  { label }


INTEGERS { output.state before.all mid.sentence after.sentence after.block }

FUNCTION {init.state.consts}
{ #0 'before.all :=
  #1 'mid.sentence :=
  #2 'after.sentence :=
  #3 'after.block :=
}


STRINGS { b e new.pages original.t s t }

FUNCTION {output.nonnull}
{ 's :=
  output.state mid.sentence =
    { ", " * write$ }
    { output.state after.block =
        { add.period$ write$
          newline$
          "\newblock " write$
        }
        { output.state before.all =
            'write$
            { add.period$ " " * write$ }
          if$
        }
      if$
      mid.sentence 'output.state :=
    }
  if$
  s
}

FUNCTION {output}
{ duplicate$ empty$
    'pop$
    'output.nonnull
  if$
}

FUNCTION {output.check}
{ 't :=
  duplicate$ empty$
    { pop$ "empty " t * " in " * cite$ * warning$ }
    'output.nonnull
  if$
}

FUNCTION {output.bibitem}
{ newline$

  "\bibitem{" write$

  cite$ write$
  "}" write$
  newline$
  ""
  before.all 'output.state :=
}


FUNCTION {fin.entry}
{ add.period$
  write$
  newline$
}

FUNCTION {new.block}
{ output.state before.all =
    'skip$
    { after.block 'output.state := }
  if$
}

FUNCTION {new.sentence}
{ output.state after.block =
    'skip$
    { output.state before.all =
        'skip$
        { after.sentence 'output.state := }
      if$
    }
  if$
}


FUNCTION {not}
{   { #0 }
    { #1 }
  if$
}

FUNCTION {and}
{   'skip$
    { pop$ #0 }
  if$
}

FUNCTION {or}
{   { pop$ #1 }
    'skip$
  if$
}


FUNCTION {new.block.checka}
{ empty$
    'skip$
    'new.block
  if$
}

FUNCTION {new.block.checkb}
{ empty$
  swap$ empty$
  and
    'skip$
    'new.block
  if$
}


FUNCTION {new.sentence.checka}
{ empty$
    'skip$
    'new.sentence
  if$
}

FUNCTION {new.sentence.checkb}
{ empty$
  swap$ empty$
  and
    'skip$
    'new.sentence
  if$
}


FUNCTION {field.or.null}
{ duplicate$ empty$
    { pop$ "" }
    'skip$
  if$
}

FUNCTION {emphasize}
{ duplicate$ empty$
    { pop$ "" }
    { "{\em " swap$ * "}" * }
  if$
}

INTEGERS { nameptr namesleft numnames }

FUNCTION {format.names}
{ 's :=
  #1 'nameptr :=
  s num.names$ 'numnames :=
  numnames 'namesleft :=
    { namesleft #0 > }

    { s nameptr "{ff~}{vv~}{ll}{, jj}" format.name$ 't :=

      nameptr #1 >
        { namesleft #1 >
            { ", " * t * }
            { numnames #2 >
                { "," * }
                'skip$
              if$
              t "others" =
                { " et~al." * }
                { " and " * t * }
              if$
            }
          if$
        }
        't
      if$
      nameptr #1 + 'nameptr :=
      namesleft #1 - 'namesleft :=
    }
  while$
}

FUNCTION {format.authors}
{ author empty$
    { "" }
    { author format.names }
  if$
}


FUNCTION {format.classification}
{ classification empty$
     { "" }
     { "\textbf{" classification * "}" *}
   if$
}

FUNCTION {format.coden}
{ coden empty$
    { "" }
    { new.block "\showCODEN{" coden * "}" *}
  if$
}


FUNCTION {format.editors}
{ editor empty$
    { "" }
    { editor format.names
      editor num.names$ #1 >
        { ", editors" * }
        { ", editor" * }
      if$
    }
  if$
}


FUNCTION {format.isbn}
{ isbn empty$
    { "" }
    { new.block "\showISBN{" isbn * "}" *}
  if$
}



FUNCTION {format.issn}
{ issn empty$
    { "" }
    { new.block "\showISSN{" issn * "}" *}
  if$
}



FUNCTION {format.lccn}
{ lccn empty$
    { "" }
    { new.block "\showLCCN{" lccn * "}" *}
  if$
}



FUNCTION {format.price}
{ price empty$
    { "" }
    { new.block "\showPRICE{" price * "}" *}
  if$
}

FUNCTION {format.url}
{ url empty$
    { "" }
    { new.block "\ifshowURL {\showURL \path|" url * "|}\fi" *}
  if$
}

FUNCTION {format.lastchecked}
{ lastchecked empty$
   { "" }
   { new.block "Retrieved " lastchecked *}
  if$
}

FUNCTION {format.title}
{ title empty$
    { "" }

    { title "t" change.case$ }

  if$
}



FUNCTION {collapse.pagerange}
{ 't :=				% save input page range string
  t 'original.t :=		% save original page range
  "" 'b :=			% beginning page number
  "" 'e :=			% ending page number
    { t empty$ not }		% while-loop Boolean condition
    {				% while-loop body
      t #1 #2 substring$ "--" =	% have we found the en-dash?
	{
	   t #3 global.max$ substring$ 'e :=	% yes, save ending page number
	   "" 't := 		% and set t to empty string to terminate loop
	}
	{
	   b t #1 #1 substring$ * 'b := % no, just accumulate this character
	   t #2 global.max$ substring$ 't := % and set t to the remaining string
	}
      if$
    }
  while$			% on exit, t has ending page number string
  e b =				% are beginning and ending numbers the same?
    { b	}			% yes, return the beginning page number string
    { original.t }		% no, return the original page number string
  if$
}


FUNCTION {n.dashify}
{ 't :=
  ""
    { t empty$ not }
    { t #1 #1 substring$ "-" =
        { t #1 #2 substring$ "--" = not
            { "--" *
              t #2 global.max$ substring$ 't :=
            }
            {   { t #1 #1 substring$ "-" = }
                { "-" *
                  t #2 global.max$ substring$ 't :=
                }
              while$
            }
          if$
        }
        { t #1 #1 substring$ *
          t #2 global.max$ substring$ 't :=
        }
      if$
    }
  while$
}


FUNCTION {format.date}
{ year empty$
    { month empty$
        {
          ""                    % output empty date if year/month both empty
	  day empty$
	    {  }
	    { "there's a day but no month or year in " cite$ * warning$ }
	  if$
	}
        { "there's a month but no year in " cite$ * warning$
          month
	  day empty$
            { }
	    { " " * day * }
          if$
        }
      if$
    }
    { month empty$
	{
          year                  % output only year if month empty
	  day empty$
	    {  }
	    { "there's a day and year but no month in " cite$ * warning$ }
	  if$
	}
        {
          month " " *
	  day empty$
            { }
	    { day * ", " * }
          if$
          year *
        }
      if$
    }
  if$
}


FUNCTION {format.btitle}
{ title emphasize
}


FUNCTION {tie.or.space.connect}
{ duplicate$ text.length$ #3 <
    { "~" }
    { " " }
  if$
  swap$ * *
}


FUNCTION {either.or.check}
{ empty$
    'pop$
    { "can't use both " swap$ * " fields in " * cite$ * warning$ }
  if$
}


FUNCTION {format.bvolume}
{ volume empty$
    { "" }
    { "volume" volume tie.or.space.connect
      series empty$
        'skip$
        { " of " * series emphasize * }
      if$
      "volume and number" number either.or.check
    }
  if$
}


FUNCTION {format.number.series}
{ volume empty$
    { number empty$
        { series field.or.null }
        { output.state mid.sentence =
            { "number" }
            { "Number" }
          if$
          number tie.or.space.connect
          series empty$
            { "there's a number but no series in " cite$ * warning$ }
            { " in " * series * }
          if$
        }
      if$
    }
    { "" }
  if$
}


FUNCTION {format.edition}
{ edition empty$
    { "" }
    { output.state mid.sentence =
        { edition "l" change.case$ " edition" * }
        { edition "t" change.case$ " edition" * }
      if$
    }
  if$
}


INTEGERS { multiresult }

FUNCTION {multi.page.check}
{ 't :=
  #0 'multiresult :=
    { multiresult not
      t empty$ not
      and
    }
    { t #1 #1 substring$
      duplicate$ "-" =
      swap$ duplicate$ "," =
      swap$ "+" =
      or or
        { #1 'multiresult := }
        { t #2 global.max$ substring$ 't := }
      if$
    }
  while$
  multiresult
}


FUNCTION {format.book.pages}
{ pages empty$
    { "" }
    { new.block pages " pp." * }
  if$
}



FUNCTION {format.pages}
{ pages empty$
    { "" }
    {
      pages multi.page.check
        { pages collapse.pagerange 'new.pages := }
	{ pages 'new.pages := }
      if$
      new.pages multi.page.check
        { "pages" new.pages n.dashify tie.or.space.connect }
        { "page" new.pages tie.or.space.connect }
      if$
    }
  if$
}


FUNCTION {format.vol.num.pages}
{ volume field.or.null
  number empty$
    'skip$
    { "\penalty0 (" number * ")" * *
      volume empty$
        { "there's a number but no volume in " cite$ * warning$ }
        'skip$
      if$
    }
  if$
  pages empty$
    'skip$
    { duplicate$ empty$
        { pop$ format.pages }
        { ":\penalty0 " * pages collapse.pagerange n.dashify * }
      if$
    }
  if$
}



FUNCTION {format.chapter.pages}
{ chapter empty$
    'format.pages
    { type empty$
        { "chapter" }
        { type "l" change.case$ }
      if$
      chapter tie.or.space.connect
      pages empty$
        'skip$
        { ", " * format.pages * }
      if$
    }
  if$
}


FUNCTION {format.in.ed.booktitle}
{ booktitle empty$
    { "" }
    { editor empty$
        { "In " booktitle emphasize * }
        { "In " format.editors * ", " * booktitle emphasize * }
      if$
    }
  if$
}


FUNCTION {empty.misc.check}
{ author empty$ title empty$ howpublished empty$
  month empty$ year empty$ note empty$
  and and and and and

  key empty$ not and

    { "all relevant fields are empty in " cite$ * warning$ }
    'skip$
  if$
}


FUNCTION {format.thesis.type}
{ type empty$
    'skip$
    { pop$
      type "t" change.case$
    }
  if$
}


FUNCTION {format.tr.number}
{ type empty$
    { "Technical Report" }
    'type
  if$
  number empty$
    { "t" change.case$ }
    { number tie.or.space.connect }
  if$
}


FUNCTION {format.article.crossref}
{ key empty$
    { journal empty$
        { "need key or journal for " cite$ * " to crossref " * crossref *
          warning$
          ""
        }
        { "In {\em " journal * "\/}" * }
      if$
    }
    { "In " key * }
  if$
  " \cite{" * crossref * "}" *
}


FUNCTION {format.crossref.editor}
{ editor #1 "{vv~}{ll}" format.name$
  editor num.names$ duplicate$
  #2 >
    { pop$ " et~al." * }
    { #2 <
        'skip$
        { editor #2 "{ff }{vv }{ll}{ jj}" format.name$ "others" =
            { " et~al." * }
            { " and " * editor #2 "{vv~}{ll}" format.name$ * }
          if$
        }
      if$
    }
  if$
}


FUNCTION {format.book.crossref}
{ volume empty$
    { "empty volume in " cite$ * "'s crossref of " * crossref * warning$
      "In "
    }
    { "Volume" volume tie.or.space.connect
      " of " *
    }
  if$
  editor empty$
  editor field.or.null author field.or.null =
  or
    { key empty$
        { series empty$
            { "need editor, key, or series for " cite$ * " to crossref " *
              crossref * warning$
              "" *
            }
            { "{\em " * series * "\/}" * }
          if$
        }
        { key * }
      if$
    }
    { format.crossref.editor * }
  if$
  " \cite{" * crossref * "}" *
}


FUNCTION {format.incoll.inproc.crossref}
{ editor empty$
  editor field.or.null author field.or.null =
  or
    { key empty$
        { booktitle empty$
            { "need editor, key, or booktitle for " cite$ * " to crossref " *
              crossref * warning$
              ""
            }
            { "In {\em " booktitle * "\/}" * }
          if$
        }
        { "In " key * }
      if$
    }
    { "In " format.crossref.editor * }
  if$
  " \cite{" * crossref * "}" *
}


FUNCTION {article}
{ output.bibitem
  format.authors "author" output.check
  new.block
  format.title "title" output.check
  new.block
  crossref missing$
    { journal emphasize "journal" output.check
      format.vol.num.pages output
      format.date "year" output.check
    }
    { format.article.crossref output.nonnull
      format.pages output
    }
  if$

  format.coden output


  format.isbn output


  format.issn output

  format.url output

  new.block
  note output
  fin.entry
}

FUNCTION {book}
{ output.bibitem

  author empty$
    { format.editors "author and editor" output.check }
    { format.authors output.nonnull
      crossref missing$
        { "author and editor" editor either.or.check }
        'skip$
      if$
    }
  if$
  new.block
  format.btitle "title" output.check
  crossref missing$
    { format.bvolume output
      new.block
      format.number.series output
      new.sentence
      publisher "publisher" output.check
      address output
    }
    { new.block
      format.book.crossref output.nonnull
    }
  if$
  format.edition output
  format.date "year" output.check

  format.coden output
  format.isbn output
  format.issn output
  format.book.pages output
  format.lccn output
  format.price output
  format.url output
  new.block
  note output
  format.classification output
  fin.entry
}


FUNCTION {booklet}
{ output.bibitem
  format.authors output
  new.block
  format.title "title" output.check
  howpublished address new.block.checkb
  howpublished output
  address output
  format.date output

  format.coden output


  format.isbn output


  format.issn output


  format.book.pages output


  format.lccn output


  format.price output


  format.url output

  new.block
  note output
  format.classification output
  fin.entry
}



FUNCTION {inbook}
{ output.bibitem
  author empty$
    { format.editors "author and editor" output.check }
    { format.authors output.nonnull
      crossref missing$
        { "author and editor" editor either.or.check }
        'skip$
      if$
    }
  if$
  new.block
  format.btitle "title" output.check
  crossref missing$
    { format.bvolume output
      format.chapter.pages "chapter and pages" output.check
      new.block
      format.number.series output
      new.sentence
      publisher "publisher" output.check
      address output
    }
    { format.chapter.pages "chapter and pages" output.check
      new.block
      format.book.crossref output.nonnull
    }
  if$
  format.edition output
  format.date "year" output.check

  format.coden output
  format.isbn output
  format.issn output
  format.lccn output
  format.price output
  format.url output
  new.block
  note output
  format.classification output
  fin.entry
}


FUNCTION {incollection}
{ output.bibitem
  format.authors "author" output.check
  new.block
  format.title "title" output.check
  new.block
  crossref missing$
    { format.in.ed.booktitle "booktitle" output.check
      format.bvolume output
      format.number.series output
      format.chapter.pages output
      new.sentence
      publisher "publisher" output.check
      address output
      format.edition output
      format.date "year" output.check
    }
    { format.incoll.inproc.crossref output.nonnull
      format.chapter.pages output
    }
  if$

  format.coden output
  format.isbn output
  format.issn output
  format.lccn output
  format.price output
  format.url output

  new.block
  note output
  format.classification output
  fin.entry
}


FUNCTION {inproceedings}
{ output.bibitem
  format.authors "author" output.check
  new.block
  format.title "title" output.check
  new.block
  crossref missing$
    { format.in.ed.booktitle "booktitle" output.check
      format.bvolume output
      format.number.series output
      format.pages output
      address empty$
        { organization publisher new.sentence.checkb
          organization output
          publisher "publisher" output.check
          format.date "year" output.check
        }
        { new.sentence
          organization output
          publisher "publisher" output.check
          address output.nonnull
          format.date "year" output.check
        }
      if$
    }
    { format.incoll.inproc.crossref output.nonnull
      format.pages output
    }
  if$

  format.coden output


  format.isbn output


  format.issn output


  format.lccn output


  format.price output


  format.url output

  new.block
  note output
  format.classification output
  fin.entry
}


FUNCTION {conference} { inproceedings }


FUNCTION {manual}
{ output.bibitem
  author empty$
    { organization empty$
        'skip$
        { organization output.nonnull
          address output
        }
      if$
    }
    { format.authors output.nonnull }
  if$
  new.block
  format.btitle "title" output.check
  author empty$
    { organization empty$
        { address new.block.checka
          address output
        }
        'skip$
      if$
    }
    { organization address new.block.checkb
      organization output
      address output
    }
  if$
  format.edition output
  format.date output

  format.book.pages output
  format.price output
  format.url output
  new.block
  note output
  format.classification output
  fin.entry
}


FUNCTION {mastersthesis}
{ output.bibitem
  format.authors "author" output.check
  new.block
  format.title "title" output.check
  new.block
  "Master's thesis" format.thesis.type output.nonnull
  school "school" output.check
  address output
  format.date "year" output.check
  format.book.pages output
  format.url output
  new.block
  note output
  format.classification output
  fin.entry
}


FUNCTION {misc}
{ output.bibitem
  format.authors output
  title howpublished new.block.checkb
  format.title output
  howpublished new.block.checka
  howpublished output
  format.date output
  format.coden output
  format.isbn output
  format.issn output
  format.price output
  format.lastchecked output
  format.url output
  new.block
  note output
  format.classification output
  fin.entry
  empty.misc.check
}
FUNCTION {webpage} { misc }

FUNCTION {phdthesis}
{ output.bibitem
  format.authors "author" output.check
  new.block
  format.btitle "title" output.check
  new.block
  "PhD thesis" format.thesis.type output.nonnull
  school "school" output.check
  address output
  format.date "year" output.check

  format.book.pages output
  format.url output
  new.block
  note output
  format.classification output
  fin.entry
}


FUNCTION {periodical}
{ output.bibitem
  editor empty$
    { organization output }
    { format.editors output.nonnull }
  if$
  new.block
  title emphasize "title" output.check
  format.vol.num.pages output
  format.date output

  format.coden output
  format.isbn output
  format.issn output
  format.price output
  format.url output
  new.sentence
  publisher output
  address output
  howpublished new.block.checka
  howpublished output
  new.block
  note output
  format.classification output
  fin.entry
}


FUNCTION {proceedings}
{ output.bibitem
  editor empty$
    { organization output }
    { format.editors output.nonnull }
  if$
  new.block
  format.btitle "title" output.check
  format.bvolume output
  format.number.series output
  address empty$
    { editor empty$
        { publisher new.sentence.checka }
        { organization publisher new.sentence.checkb
          organization output
        }
      if$
      publisher "publisher" output.check %%% <- new check for missing
      format.date "year" output.check
    }
    { new.sentence
      editor empty$
        'skip$
        { organization output }
      if$
      publisher "publisher" output.check
      address output.nonnull
      format.date "year" output.check
    }
  if$

  format.coden output

  format.isbn output
  format.issn output
  format.lccn output
  format.price output
  format.url output
  new.block
  note output
  format.classification output
  fin.entry
}


FUNCTION {techreport}
{ output.bibitem
  format.authors "author" output.check
  new.block
  format.title "title" output.check
  new.block
  format.tr.number output.nonnull
  institution "institution" output.check
  address output
  format.date "year" output.check

  format.isbn output		% NB: TechReports occasionally have ISBNs


  format.book.pages output


  format.price output


  format.url output

  new.block
  note output
  format.classification output
  fin.entry
}


FUNCTION {unpublished}
{ output.bibitem
  format.authors "author" output.check
  new.block
  format.title "title" output.check
  new.block
  note "note" output.check
  format.date output
  format.url output
  format.classification output
  fin.entry
}


FUNCTION {default.type} { misc }


MACRO {jan} {"January"}
MACRO {feb} {"February"}
MACRO {mar} {"March"}
MACRO {apr} {"April"}
MACRO {may} {"May"}
MACRO {jun} {"June"}
MACRO {jul} {"July"}
MACRO {aug} {"August"}
MACRO {sep} {"September"}
MACRO {oct} {"October"}
MACRO {nov} {"November"}
MACRO {dec} {"December"}


MACRO {acmcs} {"ACM Computing Surveys"}

MACRO {acta} {"Acta Informatica"}

MACRO {cacm} {"Communications of the ACM"}

MACRO {ibmjrd} {"IBM Journal of Research and Development"}

MACRO {ibmsj} {"IBM Systems Journal"}

MACRO {ieeese} {"IEEE Transactions on Software Engineering"}

MACRO {ieeetc} {"IEEE Transactions on Computers"}

MACRO {ieeetcad} {"IEEE Transactions on Computer-Aided Design of Integrated Circuits"}

MACRO {ipl} {"Information Processing Letters"}

MACRO {jacm} {"Journal of the ACM"}

MACRO {jcss} {"Journal of Computer and System Sciences"}

MACRO {scp} {"Science of Computer Programming"}

MACRO {sicomp} {"SIAM Journal on Computing"}

MACRO {tocs} {"ACM Transactions on Computer Systems"}

MACRO {tods} {"ACM Transactions on Database Systems"}

MACRO {tog} {"ACM Transactions on Graphics"}

MACRO {toms} {"ACM Transactions on Mathematical Software"}

MACRO {toois} {"ACM Transactions on Office Information Systems"}

MACRO {toplas} {"ACM Transactions on Programming Languages and Systems"}

MACRO {tcs} {"Theoretical Computer Science"}




READ




FUNCTION {sortify}
{ purify$
  "l" change.case$
}

INTEGERS { len }

FUNCTION {chop.word}
{ 's :=
  'len :=
  s #1 len substring$ =
    { s len #1 + global.max$ substring$ }
    's
  if$
}









FUNCTION {sort.format.names}
{ 's :=
  #1 'nameptr :=
  ""
  s num.names$ 'numnames :=
  numnames 'namesleft :=
    { namesleft #0 > }
    { nameptr #1 >
        { "   " * }
        'skip$
      if$

      s nameptr "{vv{ } }{ll{ }}{  ff{ }}{  jj{ }}" format.name$ 't :=

      nameptr numnames = t "others" = and
        { "et al" * }
        { t sortify * }
      if$
      nameptr #1 + 'nameptr :=
      namesleft #1 - 'namesleft :=
    }
  while$
}


FUNCTION {sort.format.title}
{ 't :=
  "A " #2
    "An " #3
      "The " #4 t chop.word
    chop.word
  chop.word
  sortify
  #1 global.max$ substring$
}


FUNCTION {author.sort}
{ author empty$
    { key empty$
        { "to sort, need author or key in " cite$ * warning$
          ""
        }
        { key sortify }
      if$
    }
    { author sort.format.names }
  if$
}

FUNCTION {author.editor.sort}
{ author empty$
    { editor empty$
        { key empty$
            { "to sort, need author, editor, or key in " cite$ * warning$
              ""
            }
            { key sortify }
          if$
        }
        { editor sort.format.names }
      if$
    }
    { author sort.format.names }
  if$
}

FUNCTION {author.organization.sort}
{ author empty$
    { organization empty$
        { key empty$
            { "to sort, need author, organization, or key in " cite$ * warning$
              ""
            }
            { key sortify }
          if$
        }
        { "The " #4 organization chop.word sortify }
      if$
    }
    { author sort.format.names }
  if$
}

FUNCTION {editor.organization.sort}
{ editor empty$
    { organization empty$
        { key empty$
            { "to sort, need editor, organization, or key in " cite$ * warning$
              ""
            }
            { key sortify }
          if$
        }
        { "The " #4 organization chop.word sortify }
      if$
    }
    { editor sort.format.names }
  if$
}


FUNCTION {presort}

{ type$ "book" =

  type$ "inbook" =
  or
    'author.editor.sort
    { type$ "proceedings" =
        'editor.organization.sort
        { type$ "manual" =
            'author.organization.sort
            'author.sort
          if$
        }
      if$
    }
  if$

  "    "
  *
  year field.or.null sortify
  *
  "    "
  *
  title field.or.null
  sort.format.title
  *
  #1 entry.max$ substring$
  'sort.key$ :=
}

ITERATE {presort}


% SORT

STRINGS { longest.label }

INTEGERS { number.label longest.label.width }

FUNCTION {initialize.longest.label}
{ "" 'longest.label :=
  #1 'number.label :=
  #0 'longest.label.width :=
}

FUNCTION {longest.label.pass}
{ number.label int.to.str$ 'label :=
  number.label #1 + 'number.label :=
  label width$ longest.label.width >
    { label 'longest.label :=
      label width$ 'longest.label.width :=
    }
    'skip$
  if$
}

EXECUTE {initialize.longest.label}

ITERATE {longest.label.pass}




FUNCTION {begin.bib}

{ preamble$ empty$

    'skip$
    { preamble$ write$ newline$ }
  if$
  "\begin{thebibliography}{"  longest.label  * "}" * write$ newline$

  "\ifx \showCODEN  \undefined \def \showCODEN #1{CODEN #1}  \fi" write$ newline$


  "\ifx \showISBN   \undefined \def \showISBN  #1{ISBN #1}   \fi" write$ newline$


  "\ifx \showISSN   \undefined \def \showISSN  #1{ISSN #1}   \fi" write$ newline$


  "\ifx \showLCCN   \undefined \def \showLCCN  #1{LCCN #1}   \fi" write$ newline$


  "\ifx \showPRICE  \undefined \def \showPRICE #1{#1}        \fi" write$ newline$


  "\ifx \showURL    \undefined \def \showURL {URL }          \fi" write$ newline$
  "\ifx \path       \undefined \input path.sty               \fi" write$ newline$
  "\ifx \ifshowURL \undefined" write$ newline$
  "     \newif \ifshowURL"     write$ newline$
  "     \showURLtrue"          write$ newline$
  "\fi" write$ newline$

}

EXECUTE {begin.bib}

EXECUTE {init.state.consts}


ITERATE {call.type$}


FUNCTION {end.bib}
{ newline$
  "\end{thebibliography}" write$ newline$
}

EXECUTE {end.bib}
