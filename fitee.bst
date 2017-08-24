%%
%% This is file fitee.bst',
%% generated with the docstrip utility.
%% 
%% August 22, 2017
%% Modified by Ph.D. Shengke Xue with the College of Information Science  
%% and Electronic Engineering, Zhejiang University
%% 
%% The original source files were:
%%
%% merlin.mbs  (with options: `ay,alk,seq-lab,nm-rvvc,nmlm,x3,m3,keyxyr,dt-beg,yr-com,note-yr,trtit-b,vol-bf,num-xser,btit-rm,bt-rm,doi,edpar,bkedcap,in-col,in-it,pp,ed,xedn,xand,etal-it,url,url-blk,nfss,')
%% ----------------------------------------
%% *** NONE ***
%% 
%% Copyright 1994-2011 Patrick W Daly
%% ===============================================================
%% IMPORTANT NOTICE:
%% This bibliographic style (bst) file has been generated from one or
%% more master bibliographic style (mbs) files, listed above.
%%
%% This generated file can be redistributed and/or modified under the terms
%% of the LaTeX Project Public License Distributed from CTAN
%% archives in directory macros/latex/base/lppl.txt; either
%% version 1 of the License, or any later version.
%% ===============================================================
%% Name and version information of the main mbs file:
%% \ProvidesFile{merlin.mbs}[2011/11/18 4.33 (PWD, AO, DPC)]
%%   For use with BibTeX version 0.99a or later
%%-------------------------------------------------------------------
%% This bibliography style file is intended for texts in ENGLISH
%% This is an author-year citation style bibliography. As such, it is
%% non-standard LaTeX, and requires a special package file to function properly.
%% Such a package is    natbib.sty   by Patrick W. Daly
%% or:                  apalike.sty  by Oren Patashnik
%% The form of the \bibitem entries is
%%   \bibitem[Jones et al., 1990]{key}...
%%---------------------------------------------------------------------

ENTRY
  { author
    booktitle
    chapter
    edition
    editor
    institute 
    source
    location    
    language 
    series
    number
    journal
    address
    key
    note
    publisher
    publishinginfo
    nationality
    organization
    howpublished 
    year
    title
    type
    volume
    issue
    pages
    school
    doi
    url
    date
    lab
  }
  {}
  { label extra.label sort.label }

INTEGERS { output.state before.all mid.sentence after.sentence after.block }

FUNCTION {init.state.consts}
{ #0 'before.all :=
  #1 'mid.sentence :=
  #2 'after.sentence :=
  #3 'after.block :=
}

STRINGS { s t }		% two variables

FUNCTION {output.nonnull}
{ 's :=		% pop  1st stack, save to s
  output.state mid.sentence =
    {
		   ", " * write$	% append a comma to the 2nd stack, and write it to *.bbl file
	}
    {  output.state after.block =
		{ 	add.period$ write$
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
  s		% push s back to the 1st stack
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
    {  pop$ "empty " 
	   { t "u" change.case$ } * 
	   " in " * cite$ * warning$   % warning if the filed is empty
	}
    'output.nonnull
  if$
}

FUNCTION {output.year.check}
{ year empty$
    { "empty YEAR in " cite$ * warning$ }
    { write$
      ", " year * extra.label *
      mid.sentence 'output.state :=
    }
  if$
}


FUNCTION {output.bibitem}
{ newline$
  "\bibitem[" write$
  label write$
  "]{" write$
  cite$ write$
  "}" write$
  newline$
  ""
  before.all 'output.state :=
}

FUNCTION {fin.entry}
{  doi empty$		% if the last item is DOI, no period
	{ 
	  add.period$ 
	  write$
	}
	'skip$
	if$
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

FUNCTION {new.block.checkb}
{ empty$
  swap$ empty$
  and
    'skip$
    'new.block
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
%    { s nameptr "{vv~}{ll}{, jj}{, ff}" format.name$ 't :=    % last name firts
    { s nameptr "{vv~}{ll}{, jj}{, f{.}.}" format.name$ 't :=  % last name ahead, first name abbreviated
      nameptr #1 >
		{
          nameptr #3
          #1 + =
          numnames #3 > and
            { "others" 't :=
              #1 'namesleft := }
            'skip$
          if$
          namesleft #1 >
            { ", " * t * }
            {
              s nameptr "{ll}" format.name$ duplicate$ "others" =
                { 't := }
                { pop$ }
              if$
              "," *
              t "others" =
                {
                  " \emph{et~al.}" *
                }
                { " " * t * }
              if$
            }
          if$
        }
        't
      if$
      nameptr   #1 + 'nameptr   :=
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

%           There are three apalike cases: one person (Jones),
%           two (Jones and de~Bruijn), and more (Jones et~al.).
%           This function is much like format.crossref.editors.
%
FUNCTION {format.lab.names}
{ 's :=
  s #1 "{ll}" format.name$
  s num.names$ duplicate$
  #2 >
    { pop$ " \emph{et~al.}" * }
    { #2 <
    'skip$
%    { s #2 "{vv~}{ ll}{, jj}{, ff}" format.name$ "others" =
    { s #2 "{vv~}{ll}{, jj}{, f{.}.}" format.name$ "others" =  % last name ahead, first name abbreviated
        { " \emph{et~al.}" * }
        { " and " * s #2 "{ll}" format.name$ * }
      if$
    }
      if$
    }
  if$
}

FUNCTION {format.key}           % this function is just for apalike
{ empty$
    { key field.or.null }
    { "" }
  if$
}

FUNCTION {format.editors}
{ editor empty$
    { "" }
    { editor format.names
      editor num.names$ #1 >
    { " (Eds.), " * }
    { " (Ed.), " * }
      if$
    }
  if$
}

FUNCTION {format.title}
{ title empty$
    { "" }
    { title "t" change.case$ }
  if$
}

FUNCTION {format.atitle} 
{ title empty$
    { "" }
    { title "t" change.case$ } % 'u' for upper case and 't' only captalize the first one
  if$
}

FUNCTION {n.dashify} 
{ 't := ""
    { t empty$ not }
    { t #1 #1 substring$ "--" =
		{ t #1 #2 substring$ "--" = not
			{ "-" *
			  t #2 global.max$ substring$ 't :=
			}
			{   
				{ t #1 #1 substring$ "-" = }
				{   "-" *
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

FUNCTION {format.btitle}
{ title empty$
    { "" }
    { title "t" change.case$ }
  if$
}

FUNCTION {tie.or.space.connect}
{ duplicate$ text.length$ #3 <
    { "~" }
    { "" }
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
        { "empty SERIES in " cite$ * warning$ }
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

FUNCTION {format.pages}
{ pages empty$
    { "empty PAGES in " cite$ * warning$ }
    { 
		pages multi.page.check
		{ ", p." pages * n.dashify tie.or.space.connect }
		{ ", p." pages * tie.or.space.connect }
		if$
    }
  if$
}

FUNCTION {format.cpages}	% separate pages from the last stack 
{ pages empty$
    { "empty PAGES in " cite$ * warning$ }
    { pages multi.page.check
    { "p." pages n.dashify tie.or.space.connect }
    { "p." pages tie.or.space.connect }
      if$
    }
  if$
}

FUNCTION {format.vol.number.pages}
{ 
  volume  empty$
    { ", " * field.or.null  "empty VOLUME in " cite$ * warning$ } % warning if the field is empty
    { "{\bf " volume * "}" * field.or.null }
  if$
  number empty$
    { "empty NUMBER in " cite$ * warning$ } % warning if the field is empty
    { "(" number * ")" * * }
  if$
  pages empty$
    { "empty PAGES in " cite$ * warning$ skip$ } % warning if the field is empty
    { duplicate$ empty$
      { pop$ format.pages }
      { ":" * pages n.dashify *	}
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
%    { "In " booktitle emphasize * }
%    { "In " format.editors * ", " * booktitle emphasize * }
    { booktitle }
    { format.editors ", " * booktitle * }
      if$
    }
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

FUNCTION {format.url.note}
{  
  note empty$   
    'skip$
    { 
     write$ " (" note * ")" *
    }
  if$
  url empty$
    'skip$
    { 
      " \\ " url * output
      write$ ", "
      pop$  ""    % pop up the last word "," and therefore no "."
    }
  if$
}

FUNCTION {format.doi} {
    doi empty$
     { skip$ "empty DOI in " cite$ * warning$ }
     {
		url empty$
		{ write$ "." }
		{ "" }
		if$	 
		write$ 
		" \\ http://dx.doi.org/" doi * 
		write$ ", " 
		pop$  % pop up the last word "," and therefore no "."	  
     }
  if$
}


FUNCTION {article}
{ output.bibitem
  format.authors "author" output.check
  output.year.check                 % apalike
  new.block
  format.atitle "title" output.check
  new.block
  journal emphasize "journal" output.check
  format.vol.number.pages output
  new.block  
  format.url.note 
  new.block 
  format.doi
  fin.entry
}

FUNCTION {book}
{ output.bibitem
  format.authors "author" output.check
  output.year.check             % special for apalike
  new.block
  title "title" output.check
  new.block   
  publisher "publisher" output.check
  address output
  format.cpages 
  pages empty$
	'skip$
	{ output }
  if$
  format.url.note
  new.block
  format.doi
  fin.entry
}


FUNCTION {inbook}
{ output.bibitem
  format.authors "author" output.check
  output.year.check             % special for apalike
  new.block
  title "title" output.check
  new.block
   "{\it In}: " format.editors * booktitle * output
  new.block
  publisher "publisher" output.check
  address output
  pages empty$
    'skip$
	{ output }
  if$
  new.block
  format.url.note
  new.block
  format.doi
  fin.entry
}

FUNCTION {conference}
{ output.bibitem
  format.authors "author" output.check
  output.year.check    % apalike
  new.block
  format.title "title" output.check
  new.block
  booktitle  "booktitle" output.check
  address  output
  volume empty$
    { format.cpages output }
    { format.vol.number.pages output }
  if$
  format.url.note
  format.doi
  fin.entry
}

FUNCTION {inproceedings} {conference}

FUNCTION {thesis} { 
  output.bibitem
  format.authors "author" output.check
  output.year.check                 % apalike
  new.block
  title "title" output.check
  new.block
  type "thesis type" output.check
  school "school" output.check
%  address output
  address  "address" output.check
  pages empty$
    'skip$
    { format.pages output }
  if$
  format.url.note
  new.block
  format.doi
  fin.entry
}


FUNCTION {techreport}
{ output.bibitem
  format.authors "author" output.check
  output.year.check                 % apalike
  new.block
  title "title" output.check
  new.block
  type output
  number output
  new.block
  institute "institute" output.check
  address output
  new.block
  fin.entry
}


FUNCTION {preprints}
{ output.bibitem
  format.authors "author" output.check
  output.year.check                 % apalike
  new.block
  format.title "title" output.check
  new.block
  journal emphasize output
  new.block
  format.url.note
  new.block
  format.doi
  fin.entry
}

FUNCTION {unpublished} { preprints }

FUNCTION {patent}
{ output.bibitem
  format.authors "author" output.check
  output.year.check                 % apalike
  new.block
  title "title" output.check
  new.block
  nationality "paten nationality" output.check
  number " patent number" output.check
  new.block
  fin.entry
}


FUNCTION {misc}
{ output.bibitem
  organization output
  output.year.check                 % apalike
  new.block
  format.title output
  new.block
  howpublished output
  new.block
  url empty$
    'skip$
    {
      "\\" url * output
      write$ ","
      pop$
    }
  if$
  fin.entry
}


FUNCTION {default.type} { misc }

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


FUNCTION {author.key.label}
{ author empty$
    { key empty$
    { cite$ #1 #3 substring$ }
    'key                    % apalike uses the whole key
      if$
    }
    { author format.lab.names }
  if$
}

FUNCTION {author.editor.key.label}
{ author empty$
    { editor empty$
    { key empty$
        { cite$ #1 #3 substring$ }
        'key                % apalike uses the whole key
      if$
    }
    { editor format.lab.names }
      if$
    }
    { author format.lab.names }
  if$
}

FUNCTION {editor.key.label}
{ editor empty$
    { key empty$
    { cite$ #1 #3 substring$ }
    'key            % apalike uses the whole key, no organization
      if$
    }
    { editor format.lab.names }
  if$
}

FUNCTION {calc.label}      % this function came from ASTRON.BST (ARR)
{ 
  type$ "book" =
  type$ "inbook" =
  or
    'author.editor.key.label
    { type$ "proceedings" =
        'editor.key.label                       % apalike ignores organization
        {
          type$ "misc" =
          'lab
          'author.key.label                       % for labeling and sorting 
          if$
        }
      if$
    }
  if$
  "\protect\astroncite{" swap$ * "}{"                   % these three lines are
  *                                                     % for apalike, which
  year field.or.null purify$ #-1 #4 substring$          % uses all four digits
  *                       % the mathing closing "}" comes in at the reverse.pass
  'label :=
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
%      	   s nameptr "{ff{ } }{ vv{ }}{  ll{ }}{  jj{ }}" format.name$ 't := % <= here  % sort by first names
	  s nameptr "{ll{ } }{ vv{ }}{  ff{ }}{  jj{ }}" format.name$ 't := % <= here    % sort by last names
%   	nameptr numnames = t "others" = and
%	    { "\emph{et al}" * }
	  nameptr #1 >
		{
			nameptr #3
		    #1 + =
			numnames #3 > and
			  {	"others" 't :=
				#1 'namesleft := }
			  'skip$
			if$
			"   "  *
			namesleft #1 = t "others" = and
				{ "zzzzz" 't := }
				'skip$
			if$
			numnames #2 > nameptr #2 = and
				{ "zz" * year field.or.null * "   " * }
				'skip$
			if$
			t sortify *
		}
		{ t sortify * }
		if$
		nameptr   #1 + 'nameptr :=
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

FUNCTION {editor.sort}
{ editor empty$
    { key empty$
    { "to sort, need editor or key in " cite$ * warning$
      ""
    }
    { key sortify }
      if$
    }
    { editor sort.format.names }
  if$
}

%           apalike uses two sorting passes; the first one sets the
%           labels so that the `a's, `b's, etc. can be computed;
%           the second pass puts the references in "correct" order.
%           The presort function is for the first pass. It computes
%           label, sort.label, and title, and then concatenates.
FUNCTION {presort}
{ ""	% set an empty value in stack, otherwise error occurs
  calc.label
  author field.or.null
  sort.format.names
  *
  "    "
  *
  type$ "book" =
  type$ "inbook" =
  or
    'author.editor.sort
    { type$ "proceedings" =
        'editor.sort
        'author.sort
      if$
    }
  if$     
  #1 entry.max$ substring$ 
  'sort.label :=        
  sort.label            
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

SORT        % by label, sort.label, title---for final label calculation

STRINGS { last.label next.extra }   % apalike labels are only for the text;

INTEGERS { last.extra.num }     % there are none in the bibliography

FUNCTION {initialize.extra.label.stuff} % and hence there is no `longest.label'
{ #0 int.to.chr$ 'last.label :=
  "" 'next.extra :=
  #0 'last.extra.num :=
}

FUNCTION {forward.pass}
{ last.label label =
    { last.extra.num #1 + 'last.extra.num :=
      last.extra.num int.to.chr$ 'extra.label :=
    }
    { "a" chr.to.int$ 'last.extra.num :=
      "" 'extra.label :=
      label 'last.label :=
    }
  if$
}

FUNCTION {reverse.pass}       % this function came from ASTRON.BST (ARR)
{ next.extra "b" =
    { "a" 'extra.label := }
    'skip$
  if$
  label extra.label * "}" * 'label :=
  extra.label 'next.extra :=
}

EXECUTE {initialize.extra.label.stuff}

ITERATE {forward.pass}

REVERSE {reverse.pass}

%               Now that the label is right we sort for real,
%               on sort.label then year then title.  This is
%               for the second sorting pass.
FUNCTION {bib.sort.order}
{ 
  sort.label
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

ITERATE {bib.sort.order}

SORT        % by sort.label, year, title---giving final bibliography order

FUNCTION {begin.bib}
{ preamble$ empty$              % no \etalchar in apalike
    'skip$
    { preamble$ write$ newline$ }
  if$
  "\balance" write$ newline$	% require package balance
  "\begin{thebibliography}{}\footnotesize" write$ newline$
  "\itemsep -4pt" write$ newline$
  "\vspace{-8pt}" write$ newline$
}

EXECUTE {begin.bib}

EXECUTE {init.state.consts}

ITERATE {call.type$}

FUNCTION {end.bib}
{ newline$
  "\end{thebibliography}" write$ newline$
}

EXECUTE {end.bib}
