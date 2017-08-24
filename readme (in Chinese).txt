FITEE LaTeX模板使用说明    % 2017.07.01

%%%%%%%%%%%%%%%%%
模板文件介绍：

sample.tex    	% tex文件
fitee.sty     	% FITEE模板宏包
authblk.sty   	% FITEE Author Block宏包
bibsample.bib 	% 参考文献数据示例
fitee.bst     	% FITEE参考文献格式文件，用于设置参考文献的排版格式
orcid16.eps   	% ORCID logo图片
fitee.eps     	% FITEE logo图片
uarial.sty    	% 无衬线字体文件

%%%%%%%%%%%%%%%%%%
authblk.sty说明：

authblk.sty定义了稿件中作者及其机构的输出形式。

对于作者均属于同一个机构的情形，作者及机构的输入形式为：
\author{Zi-yang ZHAI$^\dagger$}
\author{Xian-liang HU$^\dagger$}
\affil{Editorial Office of Journal of Zhejiang University-SCIENCE, Hangzhou 310027, China}


对于作者属于多个不同机构的情形，输入方式为：
\author[$\dagger$1]{Zi-yang ZHAI}%
\author[$\dagger$2]{Xian-liang HU}
\affil[1]{Editorial Office of Journal of Zhejiang University-SCIENCE, Hangzhou 310027, China}
\affil[2]{Department of Mathematics, Zhejiang University, Hangzhou 310027, China}

%%%%%%%%%%%%%%%%%%
利用LaTeX的编译步骤举例（工作文件夹中需包含pics, bibsample.bib, fitee.bst, fitee.eps, fitee.sty, orcid16.eps, sample.tex）：

首次编译：
第一步：执行LaTeX     	% 生成.aux文件
第二步：执行BibTex    	% 生成.bbl文件
第三步：执行LaTex两次 	% 生成.dvi文件
第四步：执行dvi2ps    	% 利用.dvi文件生成.ps文件
第五步：执行ps2pdf    	% 利用.ps文件生成.pdf文件

生成正确的.bbl文件后，编译过程简化为：LaTeX -> dvi2ps -> ps2pdf

% 作者也可使用PDFLaTeX等工具编译生成pdf文件

%%%%%%%%%%%%%%%%%%
投稿操作说明：

FITEE利用Editorial Manager（EM）进行投审稿操作。使用LaTeX模板向EM投稿，可采用以下两种方法之一：

1. 利用模板生成.pdf文件，直接将生成的.pdf文件上传至EM系统，作者在预览后可确认投稿。

2. 将.tex, fitee.sty, .bib, fitee.bst, orcid.eps, fitee.eps, uarial.sty和稿件中的图片文件上传至EM系统，EM系统可根据上述文件自动生成pdf文件，作者在预览后可确认投稿。

注意：采用第2种方法时，稿件相关图片应与.tex处于同一目录。

%%%%%%%%%%%%%%%%%%
www.jzus.zju.edu.cn