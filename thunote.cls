\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{../thunote}[2020/09/08 Tsinghua University Note Template]

\newcommand\thu@error[1]{
  \ClassError{thuthesis}{#1}{}
}

\LoadClass[a4paper, UTF8, openany, oneside]{ctexbook}

% Fandol lacks some technical characters (e.g. exergy/anergy in thermodynamics).
% Keep the platform's main fonts and use Noto only for missing CJK glyphs.
\IfFontExistsTF{Noto Serif CJK SC}{%
  \xeCJKsetup{AutoFallBack=true}
  \setCJKfallbackfamilyfont{\CJKrmdefault}[
    BoldFont={Noto Serif CJK SC Bold},
    ItalicFont={Noto Serif CJK SC},
    BoldItalicFont={Noto Serif CJK SC Bold}
  ]{Noto Serif CJK SC}
}{}

\author{Dait}
\date{}

\RequirePackage[margin=3cm]{geometry}

% \RequirePackage[T1]{fontenc}  % font encoding

\catcode`\。=\active 
\newcommand{。}{．}
\catcode`\（=\active 
\newcommand{（}{(}
\catcode`\）=\active 
\newcommand{）}{)}

\RequirePackage{anyfontsize}

\renewcommand{\contentsname}{目　录}
\renewcommand{\listfigurename}{插　图}
\let\oldlistoffigures\listoffigures
\let\oldnumberline\numberline
\renewcommand{\listoffigures}{%
  \renewcommand{\numberline}{\figurename~\oldnumberline}%
  \oldlistoffigures%
  \renewcommand{\numberline}{\oldnumberline}}
\renewcommand{\listtablename}{表　格}
\let\oldlistoftables\listoftables
\renewcommand{\listoftables}{%
  \renewcommand{\numberline}{\tablename~\oldnumberline}%
  \oldlistoftables%
  \renewcommand{\numberline}{\oldnumberline}}

\newcommand{\preface}{\chapter{前　言}}

\RequirePackage[title]{appendix}

\RequirePackage{amsmath,amssymb,amsthm,mathrsfs,cancel}
\theoremstyle{definition}
\newtheorem*{corollary}{推论}
\newtheorem*{remark}{注}
\newtheorem*{lemma}{引理}
\everymath{\displaystyle}
% \allowdisplaybreaks[4] % 0: no-break; 4: force-break

\RequirePackage{paralist}
\let\itemize\compactitem
\let\enditemize\endcompactitem
\let\enumerate\compactenum
\let\endenumerate\endcompactenum

\renewcommand{\thempfootnote}{\Roman{mpfootnote}}
\renewcommand{\thefootnote}{\Roman{footnote}}

% Hang the optional-reading mark in the number–title gap, including in the TOC.
\DeclareRobustCommand{\thu@optionalmark}{%
  \texorpdfstring{\llap{\scalebox{.75}{*}\kern.1em}}{* }}
\newcommand{\sectionstar}[1]{\section{\thu@optionalmark#1}}
\newcommand{\subsectionstar}[1]{\subsection{\thu@optionalmark#1}}
\newcommand{\subsubsectionstar}[1]{\subsubsection{\thu@optionalmark#1}}

\RequirePackage{xr-hyper}
\RequirePackage{hyperref}
\hypersetup{
	% pdftitle={\coursename},
	% pdfauthor={\authorname},
	colorlinks=true, breaklinks=true,
	linkcolor=black, citecolor=black, urlcolor=blue
}
% The title page and the main matter both use page 1. Only the latter
% should create a page anchor, otherwise PDF links have duplicate targets.
\AddToHook{cmd/maketitle/before}{\hypersetup{pageanchor=false}}
\AddToHook{cmd/maketitle/after}{\hypersetup{pageanchor=true}}
\renewcommand{\eqref}[1]{(\ref{#1})}
\newcommand{\chapref}[1]{第\ref{#1}章}
\newcommand{\secref}[1]{第 \ref{#1} 节}
\newcommand{\ssecref}[1]{第 \ref{#1} 小节}
\newcommand{\appref}[1]{附录 \ref{#1}}
\newcommand{\dfnref}[1]{定义 \ref{#1}}
\newcommand{\thmref}[1]{定理 \ref{#1}}
\newcommand{\exmref}[1]{例 \ref{#1}}
\newcommand{\figref}[1]{图 \ref{#1}}
\newcommand{\tabref}[1]{表 \ref{#1}}
% \let\oldpageref\pageref
% \renewcommand{\pageref}[1]{第 \oldpageref{#1} 页}
\RequirePackage{refcount}
\newcommand{\pagenumref}[1]{\getpagerefnumber{#1}}

\RequirePackage{float}
\RequirePackage{graphicx}
\newcommand{\tikzfigure}[2][]{%
  \IfRefUndefinedExpandable{tikz:#2}{%
    \ClassError{thunote}{Unknown TikZ figure '#2'}%
      {Build figures/tikz.tex first, then check its label and the externaldocument path.}%
  }{%
    \includegraphics[#1,page=\pagenumref{tikz:#2}]{figures/tikz.pdf}%
  }%
}
\RequirePackage[hypcap=false]{caption}
\RequirePackage{subcaption}
\RequirePackage{booktabs}
% Keep an in-place illustration or short table with its caption, also inside breakable boxes.
\newenvironment{notecaptionblock}
  {\begin{center}\begin{minipage}{\linewidth}\centering}
  {\end{minipage}\end{center}}

\RequirePackage{siunitx}[2021/05/17]
\sisetup{
  inter-unit-product = \ensuremath{{}\cdot{}},
  per-mode = power-positive-first,
  range-units = single,
  uncertainty-mode = separate,
  range-phrase = {\,\text{至}\,}
}
\DeclareSIUnit\atm{atm}

\RequirePackage{tcolorbox}
\tcbuselibrary{theorems, skins, breakable}
\definecolor{MatchaGreen}{HTML}{73C088}
\newtcbtheorem[number within = section]{example}{例}{
  enhanced, breakable, sharp corners,
  attach boxed title to top left = {yshifttext = -1mm},
  before skip = 2ex,
  colback = MatchaGreen!5,                % 文本框内的底色
  colframe = MatchaGreen,                 % 文本框框沿的颜色
  fonttitle = \bfseries,                  % 标题字体用粗体    
  % coltitle default white,
  boxed title style = {
		sharp corners, size = small, colback = MatchaGreen,
	}
}{exm}
\definecolor{MelancholyBlue}{HTML}{9EAABA}
\newcounter{pslt}
\newtcbtheorem[use counter = pslt]{postulate}{假设}{
  enhanced, breakable, sharp corners,
  attach boxed title to top left = {yshifttext = -1mm}, 
	before skip = 2ex,
  colback = MelancholyBlue!5, 
	colframe = MelancholyBlue, 
	fonttitle = \bfseries,
  boxed title style = {
		sharp corners, size = small, colback = MelancholyBlue,
	}
}{psl}
\definecolor{PureBlue}{HTML}{80A3D0}
\newtcbtheorem[number within = section]{definition}{定义}{
  enhanced, breakable, sharp corners,
  attach boxed title to top left = {yshifttext = -1mm}, 
	before skip = 2ex,
  colback = PureBlue!5, 
	colframe = PureBlue, 
	fonttitle = \bfseries,
  boxed title style = {
		sharp corners, size = small, colback = PureBlue,
	}
}{dfn}
\definecolor{PeachRed}{HTML}{EA868F}
\newtcbtheorem[number within = section]{theorem}{定理}{
  enhanced, breakable, sharp corners,
  attach boxed title to top left = {yshifttext = -1mm}, 
	before skip = 2ex,
  colback = PeachRed!5, 
	colframe = PeachRed, 
	fonttitle = \bfseries,
  boxed title style = {
		sharp corners, size = small, colback = PeachRed,
	}
}{thm}
\definecolor{SchembriumYellow}{HTML}{fbd26a}
\newtcbtheorem[number within = section]{method}{方法}{
  enhanced, breakable, sharp corners,
  attach boxed title to top left = {yshifttext = -1mm}, 
	before skip = 2ex,
  colback = SchembriumYellow!5, 
	colframe = SchembriumYellow, 
	fonttitle = \bfseries,
  boxed title style = {
		sharp corners, size = small, colback = SchembriumYellow,
	}
}{mtd}


