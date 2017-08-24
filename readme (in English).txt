Instructions for the FITEE LaTeX template    % July 1, 2017

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Summary of the files contained in the template folder:

sample.tex		% tex file
fitee.sty		% FITEE package
authblk.sty		% FITEE Author Block package
bibsample.bib		% List of references formatted using BibTeX formatting
fitee.bst		% FITEE bibliography style file
orcid16.eps		% ORCID logo
fitee.eps		% FITEE logo
uarial.sty		% Arial font package

%%%%%%%%%%%%%%%%%%
Instructions for compiling:

You will need the following style files in the same folder: pics, bibsample.bib, fitee.bst, fitee.eps, fitee.sty, orcid16.eps, and sample.tex.

Compile for the first time:
1. Excute LaTeX		% to generate .aux file
2. Excute BibTeX	% to generate .bbl file
3. Excute LaTeX twice	% generate .dvi file
4. Excute dvi2ps	% use .dvi file to generate .ps file
5. Excute ps2pdf	% use .ps file to generate .pdf file

After the .bbl file is obtained, the compiling process will be simplified to: LaTeX -> dvi2ps -> ps2pdf

% Authors may also use PDFLaTeX or other tools to generate their .pdf file

%%%%%%%%%%%%%%%%%%
Instruction for online submission:

FITEE uses Editorial Manager (EM) to handle the peer review process.

To submit your manuscript to EM using the LaTeX template, you may take one of the following two approaches:

1. Use the template to generate .pdf file, and upload the .pdf file itself to the EM. After previewing the file, the author can approve it.

2. Upload .tex, fitee.sty, authblk.sty, .bib, fitee.bst, orcid.eps, fitee.eps, uarial.sty, along with files for figures, to EM. EM will generate a .pdf file accordingly. After previewing the file, the author can approve it.

Note that when using the second approach, all the files for figures should be placed in the same directory as the .tex file.

%%%%%%%%%%%%%%%%%%
www.jzus.zju.edu.cn
