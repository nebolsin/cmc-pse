%% This is file `rusthesis.cls',
%% Updated from file "ucthesis.cls"  by A. Yu. Smolin. (TeTeX version)
%%	e-mail		= "asmolin@ispms.tsc.ru"
%% 
% RUSTHESIS DOCUMENT CLASS -- Release info is below.
%    for LaTeX version 2e - 11/3/94

%%% ====================================================================
%%%  @LaTeX-class-file{
%%%     filename        = "rusthesis.cls",
%%%     version         = "1.2",
%%%     date            = "04 November 1999",
%%%	portedby	= "Alexey Yu. Smolin",
%%%	address		= "Институт физики прочности и материаловедения СО РАН
%%%			   пр. Академический, 2/1
%%%			   Томск, 634055, Россия",
%%%	telephone	= "(382-2) 25-88-81",
%%%	email		= "asmolin@ispms.tsc.ru",
%%%     codetable       = "ISO/ASCII",
%%%     keywords        = "LaTeX, ucthesis",
%%%     supported       = "until November 30, 1994",
%%%     docstring       = "This file is the main file for the ucthesis
%%%                        class, which is intended to meet the requirements
%%%                        for University of California Ph.D. dissertations.
%%%			   It is a direct port to LaTeX2e from UCTHESIS
%%%			   v2.7 by Ethan V. Munson, with no changes other 
%%%			   than those for compatibility.  The major modifictions
%%%			   are in the font selection commands in the option
%%%			   files ast1x.cli.
%%%			   
%%%			   UCTHESIS.STY v2.7 is based on the standard
%%%			   report.sty as modified by Mittelbach and Schopf in
%%%			   Jan 1992.  The primary differences are (1) the use
%%%			   of pseudo-double-spacing, except in certain special
%%%                        environments; and (2) the use of a 6 inch line
%%%                        with 4em paragraph indentation.  It is only
%%%			   intended for single-sided printing.  Double-sided
%%%			   printing may be possible, but you're on
%%%			   your own.
%%%
%%%                        I know of no bugs in this implementation,
%%%                        but would be happy to hear of any problems
%%%                        that arise with it.
%%%
%%%			   Version 2.x fixes a bug in the previous
%%%			   version of 20 Jun 1988.  The bug was that 
%%%			   "draft" optional mode didn't work because of
%%%			   problems in handling optional arguments.
%%%                        This file does not seem to work with earlier 
%%%                        versions of LaTeX (pre-Jan 1992).
%%%
%%%			   Version 2.3 includes a single-spaced 
%%%			   tabular* environment.
%%%			
%%%			   Version 2.4 sets \evensidemargin correctly
%%%			   for two-sided style.  It also adds new
%%%			   environments (\smalltabular and
%%%			   \scriptsizetabular) which produce tables
%%%			   with smaller fonts.  The obvious methods
%%%			   of producing small-font tables don't work
%%%			   in ucthesis style.
%%%
%%%			   Version 2.5 adds support for the \maketitle
%%%			   macro.
%%%
%%%			   Version 2.6 adds support for complete and
%%%			   correct front matter.  Some dead code was
%%%			   removed, too.
%%%
%%%                        Version 2.7 adds front matter support for
%%%                        thesis committees of more than 3 people
%%%                        and for a labeled signature line on the
%%%                        abstract page.
%%%
%%%			   Version 3.0 is a direct port of version 2.7
%%%			   to LaTeX2e.  The major revisions in ucthesis.cls
%%%			   are converting option processing to LaTeX2e 
%%%			   conventions.  The uct1x files have been revised
%%%			   to use the new font selection commands.
%%%
%%%			   Some users have had problems with the 
%%%			   margins ending up too small on one side.
%%%			   This appears to be a DVI-to-PostScript
%%%			   driver or printer-adjustment problem.
%%%			   If you have such trouble, make small adjustments
%%%			   to the \textwidth and \oddsidemargin
%%%			   settings in your document preamble.
%%%			   
%%%			   Another problem some people have had is
%%%			   that you can't use \pagestyle{headings}
%%%			   and \markboth if you use \part.  The solution
%%%			   is to get the headerfooter style, which is
%%%			   nice and simple to use."
%%%  }
%%% ====================================================================

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{rusthesis}[1996/11/04 v1.2 A. Smolin Thesis Class fot TeTeX]

%    ****************************************
%    *               OPTIONS                *
%    ****************************************
%
% Option values are now declared first thing.  Defaults are set to
% 12 point, onesided, final (ie not draft) mode (BBF 10/31/94)
\newcommand\@ptsize{}
\newcommand\@draftmark{}
\DeclareOption{10pt}{\renewcommand\@ptsize{0}}
\DeclareOption{11pt}{\renewcommand\@ptsize{1}}
\DeclareOption{12pt}{\renewcommand\@ptsize{2}}
\DeclareOption{14pt}{\renewcommand\@ptsize{4}}
\DeclareOption{oneside}{\@twosidefalse \@mparswitchfalse}
\DeclareOption{twoside}{\@twosidetrue  \@mparswitchtrue}
\DeclareOption{draft}{\renewcommand\@draftmark{1}}
\DeclareOption{final}{\renewcommand\@draftmark{0}}
%%\ExecuteOptions{12pt,oneside,final}
\ExecuteOptions{14pt,oneside,final}


% CHOOSING THE TYPE SIZE:
%
%  The type size option is handled by reading a different file for each
%  size, as follows, to define font size-specific commands:
%       10pt : AST10, 11pt : AST11, 12pt : AST12
%

%  Two-side or one-side printing.
%
% \@twosidefalse               %  Default is one-sided printing.
\def\ds@twoside{\@twosidetrue  %  Defines twoside option.
           \@mparswitchtrue}   %    Marginpars go on outside of page.

% This is a tricky solution to a tough bootstrapping problem.  The
% "draft" option requires the definition of the \ssp macro.  However,
% the \ssp macro requires that the uct1?.clo file has been loaded.  This
% loading is done by the \@options command which also invokes the
% \ds@draft macro.  This was a cyclic dependency in the previous
% version.  To break this dependency, I have made \ds@draft set a marker
% which is later tested to determine whether to actually do the draft
% mode actions.
% 
% Ethan Munson (October 16, 1992)

% FMi 91/03/30: made twocolum.sty a file and twocolumn an option.

% RmS 91/10/15: moved actual reading of twocolumn.sty
%               to the end of this file.
\def\ds@twocolumn{\@twocolumntrue}

% The \ProcessOptions command causes the execution of every option command
% FOO which is declared and for which the user typed the FOO option in his
% \documentclass.  For every undeclared option BAR there will be a warning 
% message. (BBF 10/31/94)

\ProcessOptions

\input ast1\@ptsize.cli\relax

% For some environments we switch back to single-spacing, also
% provides \dsp in case you need double-spacing where single-spacing
% is otherwise used.
\def\ssp{\def\baselinestretch{1.0}\large\normalsize}
\def\dsp{\def\baselinestretch{1.37}\large\normalsize}

% \smallssp is used to produce tabular environments in the small font.
% This is required because single-spacing requires a change in font size.
% \scriptsizessp is a still smaller version of the same thing.

\def\smallssp{\def\baselinestretch{1.0}\large\small}
\def\scriptsizessp{\def\baselinestretch{1.0}\large\scriptsize}

%  draft option (this is where the draft option is actually implemented)
%
% \overfullrule = 0pt             % Default is don't mark overfull hboxes.
\ifnum \@draftmark = 1
\ssp				  % Single-spaces and
\overfullrule 5pt		  % causes overfull hboxes to be marked.
\fi


% PREPARING A FOREIGN LANGUAGE VERSION:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This document style is for documents prepared in the English language.%
% To prepare a version for another language, various English words must %
% be replaced.  Many of the English words that required replacement are %
% indicated below, where we give the name of the command in which the   %
% words appear, and which must be redefined, with the actual words      %
% underlined.                                                           %
% Other English words that need replacement can be found in the macros  %
% supporting the title and approval pages.                              %
% --------------------------------------------------------------------- %
% Это было из ucthesis, а я добавил русификацию  --- А. Смолин          %
%
%
% \tableofcontents:
%\def\contentsname{СОДЕРЖАНИЕ}
\def\contentsname{Содержание}
%                 ~~~~~~~~~~
%
% \listoffigures:
\def\listfigurename{СПИСОК РИСУНКОВ}
%                   ~~~~~~~~~~~~~~~
%
% \listoftables:
\def\listtablename{СПИСОК ТАБЛИЦ}
%                  ~~~~~~~~~~~~~
%
% \thebibliography:
%\def\bibname{ЛИТЕРАТУРА}
\def\bibname{Литература}
%            ~~~~~~~~~~
%
% \theindex:
\def\indexname{Алфавитный указатель}
%              ~~~~~~~~~~~~~~~~~~~~
%
% figure environment:
\def\figurename{Рис.}
%               ~~~~
%
% table environment:
\def\tablename{Таблица}
%              ~~~~~~~
%
% \chapter:
\def\chaptername{Глава}
%                ~~~~~
% \appendix:
\def\appendixname{Приложение}
%                 ~~~~~~~~~~
% \part
\def\partname{Часть}
%             ~~~~~
% abstract environment:
\def\abstractname{Аннотация}
%                 ~~~~~~~~~
%
% acknowledge environment:
\def\acknowledgename{Благодарности автора}
%                    ~~~~~~~~~~~~~~~~~~~~~
\def\ccname{Копия}
\def\headtoname{К}
\def\pagename{Страница}
\def\seename{смотри}
\def\alsoname{смотри также}

%% And here I try Number Sign
%                 ~~~~~~~~~~~
\def\no{N$\!\frac{\scriptscriptstyle 0}{}$}% Number sign

%% Тангенс по-русски
%  ~~~~~~~~~~~~~~~~~
\def\tan{\mathop{\operator@font tg}\nolimits}

% we define today's date in European format
%  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
\def\today{\number\day\space
     \ifcase\month\or
       января\or февраля\or марта\or апреля\or мая\or июня\or
       июля\or августа\or сентября\or октября\or ноября\or декабря\fi
     \space\number\year}

%    ****************************************
%    *             FRONT MATTER             *
%    ****************************************
%

% DECLARATIONS
%
% These macros are used to declare arguments needed for the
% construction of the front matter.  

% The full (unabbreviated) name of the degree
\def\degree#1{\gdef\@degree{#1}}

% All previous degrees: one per line in chronological order
\def\prevdegrees#1{\gdef\@prevdegrees{#1}}

% The name of your committee's chair
\def\chair#1{\gdef\@chair{#1}}

% The names of your other committe members, one per line
\def\othermembers#1{\gdef\@othermembers{#1}}

% The number of committee members, which affects both the
% number of lines and the amount of space between lines
% on the approval page.
\def\@numberofmembers{3}
\def\@approvalspace{.75in}
\def\numberofmembers#1{\gdef\@numberofmembers{#1}
\ifnum \@numberofmembers > 3
\gdef\@approvalspace{.5in}
\fi}

% The name of your degree's field (e.g. Psychology, Computer Science)
\def\field#1{\gdef\@field{#1}}

%% Following lines are of A.Yu. Smolin

% You have to define the institut name twice because I can't figure out
% how to get the TeX \uppercase macro to work for me (EVM, 9/21/94)

% The name of your institution CAPITALIZED
% (e.g. ИНСТИТУТ ФИЗИКИ ПРОЧНОСТИ И МАТЕРАЛОВЕДЕНИЯ)
\def\institut#1{\gdef\@institut{#1}}

% The name of your Ministery CAPITALIZED
% (e.g. СИБИРСКОЕ ОТДЕЛЕНИЕ РАН)
\def\minister#1{\gdef\@minister{#1}}

% The name of your chief and his degree
\def\chiefdegree#1{\gdef\@chiefdegree{#1}}

% The name of your chief and his degree
\def\chief#1{\gdef\@chief{#1}}

% The city where the degree will be officially conferred
\def\degreecity#1{\gdef\@degreecity{#1}}

% The year when the degree will be officially conferred
\def\degreeyear#1{\gdef\@degreeyear{#1}}

% \alwayssingle and \endalwayssingle
%
% These macros define an environment for front matter that is always 
% single column even in a double-column document.

\def\alwayssingle{\@restonecolfalse\if@twocolumn\@restonecoltrue\onecolumn
     \else \newpage \fi}

\def\endalwayssingle{\if@restonecol\twocolumn \else \newpage \fi}

% \maketitle outputs the complete titlepage.  It requires all the
% above macros except \campuscap.  It is probably not correct for 
% joint (e.g. UCSD/SDSU) degrees.

% Some definition due to wrong encoding in TeTeX:
\def\napravax#1{\gdef\@napravax{#1}}
\def\dnsus#1{\gdef\@dnsus{#1}}
\def\nauk#1{\gdef\@nauk{#1}}
\def\nauruk#1{\gdef\@nauruk{#1}}

\def\maketitle{
{\dsp
\begin{alwayssingle}
	\let\footnotesize\small
	\let\footnoterule\relax
	\thispagestyle{empty}
	\setcounter{page}{1}

%	\null\vfil
	\begin{center}
		\fmfont
		{\bfseries {\@minister} \par}
		{\bfseries {\@institut} \par}
	\end{center}
	\medskip

	\begin{flushright}
		{\bfseries {\@napravax} \par}
	\end{flushright}
	\vspace{3cm}

	\begin{center}

		\bigskip \medskip
		{\bfseries {\@author}} \par			% Автор
		\bigskip \medskip
		{\bfseries {\@title} \par}	% Название
		\bigskip \medskip
		\vspace{6ex}
		\bigskip \medskip
		{\bfseries {\@field}} \par		% Специальность
		\vspace{6ex}
		{\bfseries {\@dnsus} } \par
		\smallskip
		{\bfseries {\@degree} {\@nauk}} \par
		\bigskip \medskip
	\end{center}

	\vspace{6ex}
	\begin{flushright}
		\begin{tabular}{c}
			\bfseries
			{\@nauruk} \\
			{\bfseries {\@chiefdegree} {\@nauk}} \\
			{\bfseries \@chief} \\
		\end{tabular}
	\end{flushright}

    \vfil
	\begin{center}
		\vspace*{\fill}
		\bfseries
		{\@degreecity} {\@degreeyear} \par	% Город
	\end{center}
%    \vfil\null

\end{alwayssingle}
\setcounter{footnote}{0}
}}	% End of \def\maketitle

\def\titul{
	\begin{center}
		\textsf{ \@author} \par			% Автор
		\bigskip
		\textsf{ \@title} \par	% Название
		\bigskip
		\textsf{\small {\@field}} \par		% Специальность
		\bigskip
		\textsf{\small Диссертация на соискание уч\"еной степени } %% \par
		\textsf{\small {\@degree} наук} \par
	\end{center}
}	% End of \def\makewhat

% APPROVALPAGE
%
% The \approvalpage macro emits a UC-approved approval page ready for
% your committee's signature.  It is not an automatic part of the 
% output because there's really no point in printing it until you are
% ready to get signatures.  It requires the the \year, \author, and
% \institut macros have been defined.  It uses lots of tricky spacing
% that is probably better handled with tabular environment code, but
% I'm too lazy to fix it. (EVM, 9/19/94)

\def\approvalpage{
\begin{alwayssingle}
\thispagestyle{empty}
\null\vfill
\begin{center}
\fmfont The dissertation of {\@author} is approved: \\
\vspace{.25in}
\vspace{\@approvalspace}
$\:\overline{~~~~ \mbox{\rule{0in}{0.16in}\small Chair%
\hspace{3.15in} Date }}\:$ \\
\vspace{\@approvalspace}
$\:\overline{~~~~ \mbox{\rule{0in}{0.16in}\small ~\hspace{3.5in} Date }}\:$ \\
\vspace{\@approvalspace}
$\:\overline{~~~~ \mbox{\rule{0in}{0.16in}\small ~\hspace{3.5in} Date }}\:$ \\
\vspace{\@approvalspace}
\ifnum \@numberofmembers > 3
$\:\overline{~~~~ \mbox{\rule{0in}{0.16in}\small ~\hspace{3.5in} Date }}\:$ \\
\vspace{\@approvalspace}
\fi
\ifnum \@numberofmembers > 4
$\:\overline{~~~~ \mbox{\rule{0in}{0.16in}\small ~\hspace{3.5in} Date }}\:$ \\
\vspace{\@approvalspace}
\fi
\ifnum \@numberofmembers > 5
$\:\overline{~~~~ \mbox{\rule{0in}{0.16in}\small ~\hspace{3.5in} Date }}\:$ \\
\vspace{\@approvalspace}
\fi
{\fmfont University of California at {\@campus}} \\
\vspace{-.25in}
\vspace{\@approvalspace}
{\fmfont \@degreeyear}
\end{center}
\vfill\null
\end{alwayssingle}
}

% COPYRIGHTPAGE
%
% While it's technically optional, you probably want a copyright page.
% This is a macro, not an environment, because it can be generated
% with the \title, \author, and \year macros.

\def\copyrightpage{
\begin{alwayssingle}
\thispagestyle{empty}
\begin{center}
{\fmfont
{\bfseries\@title}\par
\vspace{1in}
Copyright \@degreeyear\par
by\par
\@author}
\end{center}
\end{alwayssingle}}

% ABSTRACT
%
% The ABSTRACT environment allows for multi-page abstracts which,
% in accordance with UC rules, is numbered separately from the rest
% of the rest of the dissertation in Arabic.  It requires definition
% of the \title, \author, \degree, \field, \institut, and \chair macros.


\def\abstract{
\begin{alwayssingle}
\pagestyle{plain}
\thispagestyle{plain}
\setcounter{page}{1}
\begin{center}
{\fmfont
{\bfseries \abstractname}\par
\vspace{.5in}
\@title\par
\vspace{.1in}
by\par
\vspace{.1in}
\@author\par
{\@degree} in \@field\par
\vspace{.1in}
University of California at {\@campus}\par
\vspace{.1in}
{\@chair}, Chair}
\vspace{.1in}
\end{center}}

\def\endabstract{\par\vfil\null\end{alwayssingle}
}
 
\def\abstractsignature{
\hspace*{\fill}
\begin{minipage}[t]{3.25in}
\addtolength{\baselineskip}{-.5\baselineskip}
\vspace{1.7cm}
\rule{3.2in}{.5pt}\\
\@chair\\
Dissertation Committee Chair
\end{minipage}}

% DEDICATION
%
% The dedication environment just makes sure the dedication gets its
% own page.

\newenvironment{dedication}
{\begin{alwayssingle}}
{\end{alwayssingle}}

% ACKNOWLEDGEMENTS
%
% The acknowledgements environment puts a large, bold, centered 
% "Acknowledgements" label at the top of the page.

\newenvironment{acknowledgements}
{\begin{alwayssingle}
\begin{center}
{\large \bfseries \acknowledgename}
\end{center}
}
{\end{alwayssingle}}

% FRONTMATTER environment
%
% The FRONTMATTER environment makes sure that page numbering is set
% correctly (roman, lower-case, starting at 3) for the front matter
% that follows the abstract.  It also resets page-numbering for
% the remainder of the dissertation (arabic, starting at 1).

\newenvironment{frontmatter}
{\setcounter{page}{3}\renewcommand{\thepage}{\roman{page}}}
{\newpage\renewcommand{\thepage}{\arabic{page}}\setcounter{page}{1}}


%    ****************************************
%    *                LISTS                 *
%    ****************************************
%

% ENUMERATE
%  Enumeration is done with four counters: enumi, enumii, enumiii
%  and enumiv, where enumN controls the numbering of the Nth level
%  enumeration.  The label is generated by the commands \labelenumi
%  ... \labelenumiv.  The expansion of \p@enumN\theenumN defines the
%  output of a \ref command.
%
% 16 Mar 88 -- changed defs of \labelenum... to use \theenum...

\def\labelenumi{\theenumi.}
\def\theenumi{\arabic{enumi}}

\def\labelenumii{(\theenumii)}
\def\theenumii{\alph{enumii}}
\def\p@enumii{\theenumi}

\def\labelenumiii{\theenumiii.}
\def\theenumiii{\roman{enumiii}}
\def\p@enumiii{\theenumi(\theenumii)}

\def\labelenumiv{\theenumiv.}
\def\theenumiv{\Alph{enumiv}}
\def\p@enumiv{\p@enumiii\theenumiii}

% ITEMIZE
% Itemization is controlled by four commands: \labelitemi, \labelitemii,
% \labelitemiii, and \labelitemiv, which define the labels of the
% various itemization levels.

\def\labelitemi{$\m@th\bullet$}
\def\labelitemii{\bfseries --}
\def\labelitemiii{$\m@th\ast$}
\def\labelitemiv{$\m@th\cdot$}


% VERSE
%   The verse environment is defined by making clever use of the
%   list environment's parameters.  The user types \\ to end a line.
%   This is implemented by \let'in \\ equal \@centercr.
%
\def\verse{\par\let\\=\@centercr
  \list{}{\ssp\itemsep\z@ \itemindent -1.5em\listparindent \itemindent
          \rightmargin\leftmargin\advance\leftmargin 1.5em}\item[]}
\let\endverse\endlist

% QUOTATION
%   Fills lines
%   Indents paragraph
%
\def\quotation{\par\list{}{\ssp\listparindent 1.5em
    \itemindent\listparindent
    \rightmargin\leftmargin\parsep \z@ plus\p@}\item[]}
\let\endquotation=\endlist

% QUOTE -- same as quotation except no paragraph indentation,
%
\def\quote{\par\list{}{\ssp\rightmargin\leftmargin}\item[]}
\let\endquote=\endlist

% DESCRIPTION
%
%  To change the formatting of the label, you must redefine
%  \descriptionlabel.

\def\descriptionlabel#1{\hspace\labelsep \bfseries #1}
\def\description{\list{}{\labelwidth\z@ \itemindent-\leftmargin
       \let\makelabel\descriptionlabel}}

\let\enddescription\endlist

\newdimen\descriptionmargin
\descriptionmargin=3em


%    ****************************************
%    *         OTHER ENVIRONMENTS           *
%    ****************************************
%
%
% VERBATIM
%
% standard verbatim mode driver macro is modified to use
% single-spacing.  There appears to be a small problem with extra
% vertical space (1 or 2 points worth) after this environment.
% Probably, this results from returning to double-spacing before
% issuing a \parskip, but I'm not enough of TeX hacker to figure out
% the source of the problem. (EVM, 9/25/94)
% 94/11/03 BBF converted \tt to \ttfamily

\def\@verbatim{\trivlist\ssp \item[]\if@minipage\else\vskip\parskip\fi
\leftskip\@totalleftmargin\rightskip\z@
\parindent\z@\parfillskip\@flushglue\parskip\z@
%%RmS 91/08/26 Added \@@par to clear possible \parshape definition
%%from a surrounding list (the verbatim guru says)
\@@par
\@tempswafalse \def\par{\if@tempswa\hbox{}\fi\@tempswatrue\@@par
\penalty\interlinepenalty}%
\obeylines \ttfamily \catcode``=13 \@noligs \let\do\@makeother \dospecials}

% ARRAY AND TABULAR
%

\arraycolsep 5pt     % Half the space between columns in an array
                     % environment.
\tabcolsep 6pt       % Half the space between columns in a tabular
                     % environment.
\arrayrulewidth .4pt % Width of rules in array and tabular environment.
\doublerulesep 2pt   % Space between adjacent rules in array or tabular
                     % environment.

% We have to redefine array here in order to make it single-spaced.
% (Not sure if this is really necessary.)
\def\array{\let\@acol\@arrayacol \let\@classz\@arrayclassz
 \let\@classiv\@arrayclassiv \let\\\@arraycr\let\@halignto\@empty\@tabarray}

% TABBING
%
\tabbingsep \labelsep   % Space used by the \' command.
                        %  (See LaTeX manual.)

% We have to redefine tabular here in order to make it single-spaced.
\def\tabular{\par\ssp\let\@halignto\@empty\@tabular}
\expandafter \def\csname tabular*\endcsname #1%
{\par\ssp\def\@halignto{to#1}\@tabular}

% \smalltabular and \smalltabular* are alternative tabular styles
% in the \small font.  They are required because single-spacing implies a 
% change of font to a particular size.
% EVM, 7/20/93 
\def\smalltabular{\par\smallssp\let\@halignto\@empty\@tabular}
\def\endsmalltabular{\endtabular}
\expandafter \def\csname smalltabular*\endcsname #1%
{\par\smallssp\def\@halignto{to#1}\@tabular}
\expandafter \let \csname endsmalltabular*\endcsname = \endtabular

% \scriptsizetabular and \scriptsizetabular* are analogs of \smalltabular
\def\scriptsizetabular{\par\scriptsizessp\let\@halignto\@empty\@tabular}
\def\endscriptsizetabular{\endtabular}
\expandafter \def\csname scriptsizetabular*\endcsname #1%
{\par\scriptsizessp\def\@halignto{to#1}\@tabular}
\expandafter \let \csname endscriptsizetabular*\endcsname = \endtabular

% MINIPAGE
%  \@minipagerestore is called upon entry to a minipage environment to
%  set up things that are to be handled differently inside a minipage
%  environment. In the current styles, it does nothing.
%
% \skip\@mpfootins : plays same role for footnotes in a minipage as
%                    \skip\footins does for ordinary footnotes

\skip\@mpfootins = \skip\footins

% FRAMEBOX
%
\fboxsep = 3pt    % Space left between box and text by \fbox and
                  % \framebox.
\fboxrule = .4pt  % Width of rules in box made by \fbox and \framebox.


%    ****************************************
%    *        CHAPTERS AND SECTIONS         *
%    ****************************************
%
% DEFINE COUNTERS:
%
% \newcounter{NEWCTR}[OLDCTR] : Defines NEWCTR to be a counter, which is
%                               reset to zero when counter OLDCTR is
%                               stepped.
%                               Counter OLDCTR must already be defined.

% Must redefine @startsection so that we always get indentation.
\def\@startsection#1#2#3#4#5#6{\if@noskipsec \leavevmode \fi
   \par \@tempskipa #4\relax
   \@afterindenttrue
   \ifdim \@tempskipa <\z@ \@tempskipa -\@tempskipa \relax\fi
   \if@nobreak \everypar{}\else
     \addpenalty{\@secpenalty}\addvspace{\@tempskipa}\fi
     \@ifstar
     {\@ssect{#3}{#4}{#5}{#6}}%
     {\@dblarg{\@sect{#1}{#2}{#3}{#4}{#5}{#6}}}%
}
\def\@sect#1#2#3#4#5#6[#7]#8{%
     \ifnum #2>\c@secnumdepth
       \let\@svsec\@empty\else
       \refstepcounter{#1}%
       \protected@edef\@svsec{\@seccntformat{#1}\relax}%
     \fi
     \@tempskipa #5\relax
      \ifdim \@tempskipa>\z@
        \begingroup #6\relax
          \@hangfrom{\hskip #3\relax\@svsec}%
                    {\interlinepenalty \@M #8\par}%
        \endgroup
       \csname #1mark\endcsname{#7}\addcontentsline
         {toc}{#1}{\ifnum #2>\c@secnumdepth \else
                      \protect\numberline{\csname the#1\endcsname}\fi
                    #7}\else
        \def\@svsechd{#6\hskip #3\relax  %% \relax added 2 May 90
                   \@svsec #8\csname #1mark\endcsname
                      {#7}\addcontentsline
                           {toc}{#1}{\ifnum #2>\c@secnumdepth \else
                           \protect\numberline{\csname the#1\endcsname}%
                                     \fi
                       #7}}\fi
     \@xsect{#5}%
}
\def\@xsect#1{\@tempskipa #1\relax
      \ifdim \@tempskipa>\z@
       \par \nobreak
       \vskip \@tempskipa
       \@afterheading
    \else \global\@nobreakfalse \global\@noskipsectrue
       \everypar{\if@noskipsec \global\@noskipsecfalse
                   \clubpenalty\@M \hskip -\parindent
                   \begingroup \@svsechd \endgroup \unskip
                   \@tempskipa #1\relax
                   \hskip -\@tempskipa
                  \else \clubpenalty \@clubpenalty
                    \everypar{}\fi}\fi\ignorespaces}
%%%\def\@seccntformat#1{\csname the#1\endcsname\quad}
\def\@seccntformat#1{\csname the#1\endcsname.\quad}
\def\@ssect#1#2#3#4#5{\@tempskipa #3\relax
   \ifdim \@tempskipa>\z@
     \begingroup #4\@hangfrom{\hskip #1}{\interlinepenalty \@M #5\par}%
     \endgroup
   \else \def\@svsechd{#4\hskip #1\relax #5}\fi
    \@xsect{#3}%
}
\newif\if@afterindent \@afterindenttrue
\def\@afterheading{\global\@nobreaktrue
      \everypar{\if@nobreak
                   \global\@nobreakfalse
                   \clubpenalty \@M
                   \if@afterindent \else {\setbox\z@\lastbox}\fi
                 \else \clubpenalty \@clubpenalty
                    \everypar{}\fi}}

\newcounter {part}
\newcounter {chapter}
\newcounter {section}[chapter]
\newcounter {subsection}[section]
\newcounter {subsubsection}[subsection]
\newcounter {paragraph}[subsubsection]
\newcounter {subparagraph}[paragraph]

% For any counter CTR, \theCTR is a macro that defines the printed
% version of counter CTR.  It is defined in terms of the following
% macros:
%
%  \arabic{COUNTER} : The value of COUNTER printed as an arabic numeral.
%  \roman{COUNTER}  : Its value printed as a lower-case roman numberal.
%  \Roman{COUNTER}  : Its value printed as an upper-case roman numberal.
%  \alph{COUNTER}   : Value of COUNTER printed as a lower-case letter:
%                         1 = a, 2 = b, etc.
%  \Alph{COUNTER}   : Value of COUNTER printed as an upper-case letter:
%                           1 = A, 2 = B, etc.
%

\def\thepart			{\Roman{part}}
\def\thechapter			{\arabic{chapter}}
\def\thesection			{\thechapter.\arabic{section}}
%%%\def\thesection			{{\bf\S}~\thechapter.\arabic{section}}
\def\thesectionforsub	{\thechapter.\arabic{section}}
\def\thesubsection		{\thesectionforsub.\arabic{subsection}}
\def\thesubsubsection	{\thesubsection .\arabic{subsubsection}}
\def\theparagraph		{\thesubsubsection.\arabic{paragraph}}
\def\thesubparagraph	{\theparagraph.\arabic{subparagraph}}

% \@chapapp is initially defined to be '\chaptername'.  The \appendix
% command redefines it to be '\appendixname'.
%
\def\@chapapp{\chaptername}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                        PART                          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\def\part{\cleardoublepage   % Starts new page.
   \thispagestyle{plain}%    % Page style of part page is 'plain'
  \if@twocolumn              % IF two-column style
     \onecolumn              %  THEN \onecolumn
     \@tempswatrue           %       @tempswa := true
    \else \@tempswafalse     %  ELSE @tempswa := false
  \fi                        % FI
  \hbox{}\vfil               % Add fil glue to center title
%%  \bgroup  \centering      % BEGIN centering %% Removed 19 Jan 88
  \secdef\@part\@spart}

\def\@part[#1]#2{\ifnum \c@secnumdepth >-2\relax  % IF secnumdepth > -2
        \refstepcounter{part}%                    %   THEN step
                                                  %         part counter
        \addcontentsline{toc}{part}{\thepart      %        add toc line
        \hspace{1em}#1}\else                      %   ELSE add
                                                  %         unnumb. line
        \addcontentsline{toc}{part}{#1}\fi        % FI
   \markboth{}{}%
   {\centering                       % %% added 19 Jan 88
    \interlinepenalty \@M            %% RmS added 11 Nov 91
    \ifnum \c@secnumdepth >-2\relax  % IF secnumdepth > -2
      \huge\bfseries \partname~\thepart    %   THEN Print '\partname' and
    \par                             %         number in \huge bold.
    \vskip 20\p@\fi                  %        Add space before title.
    \Huge \bfseries                        % FI
    #2\par}\@endpart}                % Print Title in \Huge bold.
                                     % Bug Fix 13 Nov 89: #1 -> #2


% \@endpart finishes the part page
%
\def\@endpart{\vfil\newpage   % End page with 1fil glue.
   \if@twoside                % IF twoside printing
       \hbox{}%               %   THEN Produce totally blank page
       \thispagestyle{empty}%
       \newpage
   \fi                        % FI
   \if@tempswa                % IF @tempswa = true
     \twocolumn               %   THEN \twocolumn
   \fi}                       % FI

\def\@spart#1{{\centering      % %% added 19 Jan 88
   \interlinepenalty \@M       %% RmS added 11 Nov 91
   \Huge \bfseries                   % Print title in \Huge boldface
   #1\par}\@endpart}





%    ****************************************
%    *         TABLE OF CONTENTS, ETC.      *
%    ****************************************
%
% A \subsection command writes a
%       \contentsline{subsection}{TITLE}{PAGE}
% command on the .toc file, where TITLE contains the contents of the
% entry and PAGE is the page number.  If subsections are being numbered,
% then TITLE will be of the form
%       \numberline{NUM}{HEADING}
% where NUM is the number produced by \thesubsection.  Other sectioning
% commands work similarly.
%
% A \caption command in a 'figure' environment writes
%    \contentsline{figure}{\numberline{NUM}{CAPTION}}{PAGE}
% on the .lof file, where NUM is the number produced by \thefigure and
% CAPTION is the figure caption.  It works similarly for a 'table'
% environment.
%
% The command \contentsline{NAME} expands to \l@NAME.  So, to specify
% the table of contents, we must define \l@chapter, \l@section,
% \l@subsection, ... ; to specify the list of figures, we must define
% \l@figure; and so on.  Most of these can be defined with the
% \@dottedtocline command, which works as follows.
%
% \@dottedtocline{LEVEL}{INDENT}{NUMWIDTH}{TITLE}{PAGE}
%    LEVEL    : An entry is produced only if LEVEL < or = value of
%               'tocdepth' counter.  Note, \chapter is level 0, \section
%               is level 1, etc.
%    INDENT   : The indentation from the outer left margin of the start
%               of the contents line.
%    NUMWIDTH : The width of a box in which the section number is to go,
%               if TITLE includes a \numberline command.
%
% This command uses the following three parameters, which are set
% with a \def (so em's can be used to make them depend upon the font).
%   \@pnumwidth : The width of a box in which the page number is put.
%   \@tocrmarg  : The right margin for multiple line entries.  One
%                 wants \@tocrmarg > or = \@pnumwidth
%   \@dotsep    : Separation between dots, in mu units.  Should be
%                 \def'd to a number like 2 or 1.7

\def\@pnumwidth{1.55em}
\def\@tocrmarg {2.55em}
\def\@dotsep{4.5}
\setcounter{tocdepth}{2}


% TABLEOFCONTENTS
%  In ucthesis style, \tableofcontents, \listoffigures, etc. are always
%  set in single-column style.  @restonecol

\def\tableofcontents{\@restonecolfalse
  \if@twocolumn\@restonecoltrue\onecolumn\fi
  \chapter*{\uppercase{\contentsname}
%%        \@mkboth{\uppercase{\contentsname}}{\uppercase{\contentsname}}
        \@mkboth{}{}}%
  {\@starttoc{toc}}\if@restonecol\twocolumn\fi}
%%%  {\ssp\@starttoc{toc}}\if@restonecol\twocolumn\fi}

\def\l@part#1#2{\addpenalty{-\@highpenalty}%
%%   \addvspace{2.25em plus\p@}% space above part line
   \begingroup
   \@tempdima 3em         % width of box holding part number, used by
     \parindent \z@ \rightskip \@pnumwidth             %% \numberline
     \parfillskip -\@pnumwidth
     {\large \bfseries          % set line in \large boldface
     \leavevmode          % TeX command to enter horizontal mode.
     #1\hfil \hbox to\@pnumwidth{\hss #2}}\par
     \nobreak             % Never break after part entry
    \global\@nobreaktrue                        %% Added 24 May 89 as
    \everypar{\global\@nobreakfalse\everypar{}}%% suggested by
                                               %% Jerry Leichter
   \endgroup}

%% First line of l@chapter changed 24 May 89, as suggested
%% by Jerry Leichter.
%%
\def\l@chapter#1#2{\addpenalty{-\@highpenalty}%
   \vskip 1.0em plus\p@   % space above chapter line
   \@tempdima 1.5em       % width of box holding chapter number
   \begingroup
     \parindent \z@ \rightskip \@pnumwidth
     \parfillskip -\@pnumwidth
%     \bfseries                  % Boldface.
     \large \bfseries                  % Boldface.
     \leavevmode          % TeX command to enter horizontal mode.
      \advance\leftskip\@tempdima  %% added 5 Feb 88 to conform to
      \hskip -\leftskip            %% 25 Jan 88 change to \numberline
     #1\nobreak\hfil \nobreak\hbox to\@pnumwidth{\hss #2}\par
     \penalty\@highpenalty %% added 24 May 89, suggested by J. Leichter
   \endgroup}

\def\l@section{\@dottedtocline{1}{1.5em}{2.3em}}
\def\l@subsection{\@dottedtocline{2}{3.8em}{3.2em}}
\def\l@subsubsection{\@dottedtocline{3}{7.0em}{4.1em}}
\def\l@paragraph{\@dottedtocline{4}{10em}{5em}}
\def\l@subparagraph{\@dottedtocline{5}{12em}{6em}}

% LIST OF FIGURES
%
% Single-space list of figures, add it to the table of contents.
\def\listoffigures{\@restonecolfalse
  \if@twocolumn\@restonecoltrue\onecolumn\fi
  \chapter*{\listfigurename\@mkboth{\uppercase{\listfigurename}}%
{\uppercase{\listfigurename}}}
   \addcontentsline{toc}{chapter}{\listfigurename}
   {\ssp\@starttoc{lof}}\if@restonecol
    \twocolumn\fi}

\def\l@figure{\@dottedtocline{1}{1.5em}{2.3em}}

% LIST OF TABLES
%
\def\listoftables{\@restonecolfalse
  \if@twocolumn\@restonecoltrue\onecolumn\fi
  \chapter*{\listtablename\@mkboth{\uppercase{\listtablename}}%
   {\uppercase{\listtablename}}}\@starttoc{lot}\if@restonecol
  \twocolumn\fi}
\def\listoftables{\@restonecolfalse
  \if@twocolumn\@restonecoltrue\onecolumn\fi
  \chapter*{\listtablename\@mkboth{\uppercase{\listtablename}}%
{\uppercase{\listtablename}}}
   \addcontentsline{toc}{chapter}{\listtablename}
   {\ssp\@starttoc{lot}}\if@restonecol
  \twocolumn\fi}


\let\l@table\l@figure



%    ****************************************
%    *             BIBLIOGRAPHY             *
%    ****************************************
%
% The thebibliography environment executes the following commands:
%
%  \def\newblock{\hskip .11em plus .33em minus .07em} --
%      Defines the `closed' format, where the blocks (major units of
%      information) of an entry run together.
%
%  \sloppy  -- Used because it's rather hard to do line breaks in
%      bibliographies,
%
%  \sfcode`\.=1000\relax --
%      Causes a `.' (period) not toproduce an end-of-sentence space.

%% RmS 91/10/27 [ .. ] replaced by \@biblabel{ .. }
%% RmS 91/11/13: Changed counter enumi to enumiv,
%%               as it says in the comment in latex.tex
%% RmS 92/01/14: Set \p@enumiv to {} and \theenumiv to \arabic{enumiv}
%%               to get correct references
\def\thebibliography#1{\chapter*{\bibname\@mkboth
  {\uppercase{\bibname}}{\uppercase{\bibname}}}
  \addcontentsline{toc}{chapter}{\bibname}
  \list{\@biblabel{\arabic{enumiv}}}{\settowidth\labelwidth{\@biblabel{#1}}%
    \leftmargin\labelwidth
    \advance\leftmargin\labelsep
    \usecounter{enumiv}%
    \let\p@enumiv\@empty
    \def\theenumiv{\arabic{enumiv}}}%
    \def\newblock{\hskip .11em plus.33em minus.07em}%
    \sloppy\clubpenalty4000\widowpenalty4000
    \sfcode`\.=\@m}


%% 91/08/26 FMI & RmS: introduced warning instead of error

\def\endthebibliography{%
  \def\@noitemerr{\@warning{Empty `thebibliography' environment}}%
  \endlist}


% \def\@biblabel#1{[#1]\hfill}  % Produces the label for a \bibitem[...]
                                % command.
\def\@biblabel#1{#1.\hfill}   % Produces the label for a \bibitem as NN.
% \def\@cite#1{[#1]}            % Produces the output of the \cite
                                % command.



%    ****************************************
%    *              THE INDEX               *
%    ****************************************
%
% THE THEINDEX ENVIRONMENT
% Produces double column format, with each paragraph a separate entry.
% The user commands \item, \subitem and \subsubitem are used to
% produce the entries, and \indexspace adds an extra vertical space
% that's the right size to put above the first entry with a new letter
% of the alphabet.

\newif\if@restonecol

\def\theindex{\@restonecoltrue\if@twocolumn\@restonecolfalse\fi
\columnseprule \z@
\columnsep 35\p@\twocolumn[\@makeschapterhead{\indexname}]%
    \@mkboth{\uppercase{\indexname}}{\uppercase{\indexname}}%
    \thispagestyle{plain}\parindent\z@
    \parskip\z@ plus .3\p@\relax\let\item\@idxitem}

\def\@idxitem{\par\hangindent 40\p@}

\def\subitem{\par\hangindent 40\p@ \hspace*{20\p@}}

\def\subsubitem{\par\hangindent 40\p@ \hspace*{30\p@}}

\def\endtheindex{\if@restonecol\onecolumn\else\clearpage\fi}

\def\indexspace{\par \vskip 10\p@ plus5\p@ minus3\p@\relax}


%    ****************************************
%    *             FOOTNOTES                *
%    ****************************************
%
% \footnoterule is a macro to draw the rule separating the footnotes
% from the text.  It should take zero vertical space, so it needs a
% negative skip to compensate for any positive space taken by the rule.
% (See PLAIN.TEX.)

\def\footnoterule{\kern-3\p@
  \hrule width .4\columnwidth
  \kern 2.6\p@}                 % The \hrule has default height of .4pt.

% \newcounter{footnote}
\@addtoreset{footnote}{chapter}  % Numbers footnotes within chapters

%   \@makefntext{NOTE} :
%        Must produce the actual footnote, using \@thefnmark as the mark
%        of the footnote and NOTE as the text.  It is called when
%        effectively inside a \parbox of width \columnwidth (i.e., with
%        \hsize = \columnwidth).
%
%        The following macro indents all lines of the footnote by 10pt,
%        and indents the first line of a new paragraph by 1em.  To
%        change these dimensions, just substitute the desired value for
%        '10pt' [in both places] or '1em'.  The mark is flushright
%        against the footnote.
%          \long\def\@makefntext#1{\@setpar{\@@par\@tempdima \hsize
%             \advance\@tempdima-10pt\parshape \@ne 10pt \@tempdima}\par
%             \parindent 1em\noindent
%             \hbox to \z@{\hss$\m@th^{\@thefnmark}$}#1}
%
%        A simpler macro is used, in which the footnote text is
%        set like an ordinary text paragraph, with no indentation except
%        on the first line of a paragraph, and the first line of the
%        footnote.  Thus, all the macro must do is set \parindent
%        to the appropriate value for succeeding paragraphs and put the
%        proper indentation before mark.

\long\def\@makefntext#1{\parindent 1em\noindent
            \hbox to 1.8em{\hss$\m@th^{\@thefnmark}$}#1}

% \@makefnmark : A macro to generate the footnote marker that goes
%    in the text.  Default used.
%


% Single-space footnotes.
\long\def\@footnotetext#1{\insert\footins{\ssp\reset@font\footnotesize
    \interlinepenalty\interfootnotelinepenalty
    \splittopskip\footnotesep
    \splitmaxdepth \dp\strutbox \floatingpenalty \@MM
    \hsize\columnwidth \@parboxrestore
   \edef\@currentlabel{\csname p@footnote\endcsname\@thefnmark}\@makefntext
    {\rule{\z@}{\footnotesep}\ignorespaces
      #1\strut}}}
 
%    ****************************************
%    *         FIGURES AND TABLES           *
%    ****************************************
%
% Float placement parameters.  See LaTeX manual for their definition.
%
\setcounter{topnumber}{2}
\def\topfraction{.7}
\setcounter{bottomnumber}{1}
\def\bottomfraction{.3}
\setcounter{totalnumber}{3}
\def\textfraction{.2}
\def\floatpagefraction{.5}
\setcounter{dbltopnumber}{2}
\def\dbltopfraction{.7}
\def\dblfloatpagefraction{.5}

% \@makecaption{NUMBER}{TEXT} : Macro to make a figure or table caption.
%      NUMBER : Figure or table number--e.g., 'Figure 3.2'
%      TEXT   : The caption text.
%  Macro should be called inside a \parbox of right width, with
%  \normalsize.
% changed 25 Jun 86 to fix according to Howard Trickey:
% instead of \unhbox\@tempboxa\par we do #1: #2\par

% 15 Nov 93: further changes to support captions BEFORE the figure
% or table.  Changes suggested by Donald Arseneau, installed by Ethan
% Munson.  Detailed reasons are:
%	The \unhbox allows \vadjust material (\vspace) to get out;
%	the \vbox to\topskip{} is for captions at the top of top-floats;
%	the \ifdim is for captions above the figure or table;
%	the strut is for tables below the caption.

\long\def\@makecaption#1#2{% Add space only if something is ...
   \par\ifdim\prevdepth>-\p@ \vskip 10\p@\relax \fi % above the caption
%%   \setbox\@tempboxa\hbox{\vbox to\topskip{}#1: #2\unskip\strut}% 
   \setbox\@tempboxa\hbox{\vbox to\topskip{}#1. #2\unskip\strut}% 
   \ifdim \wd\@tempboxa >\hsize      % IF longer than one line:
%%       {\ssp#1: #2\unskip\strut\par} %   THEN set as ordinary paragraph.
       {#1. #2\unskip\strut\par} %  ASMOLIN.
     \else                           %   ELSE  center.
       \hbox to\hsize{\hfil\unhbox\@tempboxa\hfil}%
   \fi}

% To define a float of type TYPE (e.g., TYPE = figure), the document
% style must define the following.
%
%  \fps@TYPE   : The default placement specifier for floats of type
%                TYPE.
%
% \ftype@TYPE : The type number for floats of type TYPE.  Each TYPE
%                has associated a unique positive TYPE NUMBER, which
%                is a power of two.  E.g., figures might have type
%                number 1, tables type number 2, programs type number
%                4, etc.
%
% \ext@TYPE : The file extension indicating the file on which the
%                contents list for float type TYPE is stored.  For
%                example, \ext@figure = 'lof'.
%
%  \fnum@TYPE  : A macro to generate the figure number for a caption.
%                For example, \fnum@TYPE == Figure \thefigure.
%
%  The actual float-making environment commands--e.g., the commands
%  \figure and \endfigure--are defined in terms of the macros \@float
%  and \end@float, which are described below.
%
% \@float{TYPE}[PLACEMENT] : Macro to begin a float environment for a
%     single-column float of type TYPE with PLACEMENT as the placement
%     specifier.  The default value of PLACEMENT is defined by
%     \fps@TYPE.  The environment is ended by \end@float.  E.g.,
%     \figure == \@float{figure}, \endfigure == \end@float.


% FIGURE

\newcounter{figure}[chapter]
\def\thefigure{\thechapter.\@arabic\c@figure}

\def\fps@figure{tbp}
\def\ftype@figure{1}
\def\ext@figure{lof}
\def\fnum@figure{\figurename~\thefigure}
\def\figure{\@float{figure}}
\let\endfigure\end@float
\@namedef{figure*}{\@dblfloat{figure}}
\@namedef{endfigure*}{\end@dblfloat}

% TABLE
%
\newcounter{table}[chapter]
\def\thetable{\thechapter.\@arabic\c@table}

\def\fps@table{tbp}
\def\ftype@table{2}
\def\ext@table{lot}
\def\fnum@table{\tablename~\thetable}
\def\table{\@float{table}}
\let\endtable\end@float
\@namedef{table*}{\@dblfloat{table}}
\@namedef{endtable*}{\end@dblfloat}


%    ****************************************
%    *            PAGE STYLES               *
%    ****************************************
%
% The page style 'foo' is defined by defining the command \ps@foo.  This
% command should make only local definitions.  There should be no stray
% spaces in the definition, since they could lead to mysterious extra
% spaces in the output.
%
% The \ps@... command defines the macros \@oddhead, \@oddfoot,
% \@evenhead, and \@evenfoot to define the running heads and
% feet---e.g., \@oddhead is the macro to produce the contents of the
% heading box for odd-numbered pages.  It is called inside an \hbox of
% width \textwidth.
%
% To make headings determined by the sectioning commands, the page style
% defines the commands \chaptermark, \sectionmark, ... , where
% \chaptermark{TEXT} is called by \chapter to set a mark, and so on.
% The \...mark commands and the \...head macros are defined with the
% help of the following macros.  (All the \...mark commands should be
% initialized to no-ops.)
%
% MARKING CONVENTIONS:
% LaTeX extends TeX's \mark facility by producing two kinds of marks
% a 'left' and a 'right' mark, using the following commands:
%     \markboth{LEFT}{RIGHT} : Adds both marks.
%     \markright{RIGHT}      : Adds a 'right' mark.
%     \leftmark  : Used in the \@oddhead, \@oddfoot, \@evenhead or
%                  \@evenfoot macro, gets the current 'left' mark.
%                  Works like TeX's \botmark command.
%     \rightmark : Used in the \@oddhead, \@oddfoot, \@evenhead or
%                  \@evenfoot macro, gets the current 'right' mark.
%                  Works like TeX's \firstmark command.
% The marking commands work reasonably well for right marks 'numbered
% within' left marks--e.g., the left mark is changed by a \chapter
% command and the right mark is changed by a \section command.  However,
% it does produce somewhat anomalous results if two \bothmark's occur on
% the same page.
%
%
% Commands like \tableofcontents that should set the marks in some
% page styles use a \@mkboth command, which is \let by the pagestyle
% command (\ps@...)  to \markboth for setting the heading or
% \@gobbletwo to do nothing.

\mark{{}{}}   % Initializes TeX's marks

% \ps@empty defined in LATEX.TEX

% Definition of 'headings' page style
%  Note the use of ##1 for parameter of \def\chaptermark inside the
%  \def\ps@headings.
%
% 91/03/26 FMi: Added extra set of braces arround |\sl| in |\@oddhead|
% to support NFSS (|\sl| is a shape |\rm| a family). Also remove
% unnecessary |\hbox{}| commands.
%
% 94/11/3 BBF: Eliminated two letter font selection commands \rm and \sl
% in favor of \rmfamily and \slshape.
%

\if@twoside         % If two-sided printing.
\def\ps@headings{\let\@mkboth\markboth
 \def\@oddfoot{}\def\@evenfoot{}%       No feet.
 \def\@evenhead{\rmfamily \thepage\hfil \slshape \leftmark}%    Left heading.
 \def\@oddhead{{\slshape \rightmark}\hfil \rmfamily\thepage}% Right heading.
 \def\chaptermark##1{\markboth {\uppercase{\ifnum \c@secnumdepth >\m@ne
%%%      \@chapapp\ \thechapter. \ \fi ##1}}{}}%
      \thechapter. \ \fi ##1}}{}}%
 \def\sectionmark##1{\markright {\uppercase{\ifnum \c@secnumdepth >\z@
   \thesection. \ \fi ##1}}}}
\else               % If one-sided printing.
\def\ps@headings{\let\@mkboth\markboth
\def\@oddfoot{}\def\@evenfoot{}%     No feet.
\def\@oddhead{{\slshape \rightmark}\hfil \rmfamily\thepage}% Heading.
\def\chaptermark##1{\markright {\uppercase{\ifnum \c@secnumdepth >\m@ne
  \thechapter. \ \fi ##1}}}}
%%  \@chapapp\ \thechapter. \ \fi ##1}}}}
\fi

% Definition of 'myheadings' page style.
%
\def\ps@myheadings{\let\@mkboth\@gobbletwo
% \def\@oddhead{{\slshape\rightmark}\hfil \rmfamily\thepage} %
 \def\@oddhead{\hfil \fmsmallfont\rmfamily\thepage \hfil}%
 \def\@oddfoot{}\def\@evenhead{\rmfamily \thepage\hfil\slshape\leftmark}%
 \def\@evenfoot{}\def\chaptermark##1{}\def\sectionmark##1{}%
 \def\subsectionmark##1{}}

% Definition of 'plain' page style.
%
\def\ps@plain{\let\@mkboth\markboth
\def\@oddfoot{}\def\@evenfoot{}				% no feet
\def\@oddhead{\hfil \fmsmallfont\rmfamily\thepage \hfil}	% heading (right)
\def\@evenhead{\hfil \fmsmallfont\rmfamily\thepage \hfil}}	% heading (left)
%\def\@oddhead{\hbox{}\hfil\rmfamily\thepage}		% heading (right)
%\def\@evenhead{\rmfamily\thepage\hfil\hbox{}}}		% heading (left)



%    ****************************************
%    *            MISCELLANEOUS             *
%    ****************************************
%
% DATE
%
%\def\today{\ifcase\month\or
%  January\or February\or March\or April\or May\or June\or
%  July\or August\or September\or October\or November\or December\fi
%  \space\number\day, \number\year}
% we define today's date in European format
\def\today{\number\day\space
     \ifcase\month\or
       января\or февраля\or марта\or апреля\or мая\or июня\or
       июля\or августа\or сентября\or октября\or ноября\or декабря\fi
     \space\number\year}

% EQUATION and EQNARRAY -- put here because it must follow \chapter
% definition
%
% \newcounter{equation}
%
\@addtoreset{equation}{chapter}   % Makes \chapter reset 'equation'
                                  % counter.

\def\theequation{\thechapter.\arabic{equation}}

% \jot = 3pt      % Extra space added between lines of an eqnarray
                  % environment

% The macro \@eqnnum defines how equation numbers are to appear in
% equations.
%
% \def\@eqnnum{(\theequation)}

% ********************************************************
% * Чтобы при include не начинал новую страницу A.Smolin *
%
\def\include#1{\relax
  \ifnum\@auxout=\@partaux
    \@latex@error{\string\include\space cannot be nested}\@eha
  \else \@include#1 \fi}
\def\@include#1 {%
%%  \clearpage
  \if@filesw
    \immediate\write\@mainaux{\string\@input{#1.aux}}%
  \fi
  \@tempswatrue
  \if@partsw
    \@tempswafalse
    \edef\reserved@b{#1}%
    \@for\reserved@a:=\@partlist\do
      {\ifx\reserved@a\reserved@b\@tempswatrue\fi}%
  \fi
  \if@tempswa
    \let\@auxout\@partaux
    \if@filesw
      \immediate\openout\@partaux #1.aux
      \immediate\write\@partaux{\relax}%
    \fi
    \@input@{#1.tex}%
%%   \clearpage
    \@writeckpt{#1}%
    \if@filesw
      \immediate\closeout\@partaux
    \fi
  \else
    \@nameuse{cp@#1}%
  \fi
  \let\@auxout\@mainaux%
}%% END OF\def\@include#1 %%
%
%    *************************************************
%    * Here I try to make Citation as /1-4/ A.Smolin *
%
%%
%% Here I try to make Citation as /1-4/ A.Smolin
\def\printcitestart{[}%         left bracket	-	will be My
\def\printcitefinish{]}%        right bracket	-	will be My
%%% from eplain.tex
% \def\printcitestart{[}%         left bracket
% \def\printcitefinish{]}%        right bracket
% \def\printbetweencitations{, }% comma, space
% \def\printcitenote#1{, #1}%     comma, space, note (if it exists)
% \let\citation = \@gobble
% \def\cite{\@getoptionalarg\@cite}%
% \def\@cite#1{%
%    \let\@citenotetext = \@optionalarg
%    \printcitestart
%    \nocite{#1}%
%    \@notfirstcitationfalse
%    \@for \@citation :=#1\do
%    {%
%      \expandafter\@onecitation\@citation\@@
%    }%
%    \ifx\empty\@citenotetext\else
%       \printcitenote{\@citenotetext}%
%    \fi
%    \printcitefinish
% }%
% \def\@onecitation#1\@@{%
%    \if@notfirstcitation
%       \printbetweencitations
%    \fi
%    \expandafter \ifx \csname\@citelabel{#1}\endcsname \relax
%       \if@citewarning
%          \message{\@linenumber Undefined citation `#1'.}%
%       \fi
%       \expandafter\gdef\csname\@citelabel{#1}\endcsname{%
%          {\tt
%             \escapechar = -1
%             \nobreak\hskip0pt
%             \expandafter\string\csname#1\endcsname
%             \nobreak\hskip0pt
%          }%
%       }%
%    \fi
%    \csname\@citelabel{#1}\endcsname
%    \@notfirstcitationtrue
% }%
% \def\@citelabel#1{b@#1}%
% \def\@citedef#1#2{\expandafter\gdef\csname\@citelabel{#1}\endcsname{#2}}%
%%% END of "from eplain.tex"
%
%%% from latex.ltx
%   ~~~~~~~~~~~~~~
%\DeclareRobustCommand\cite{%
%	\@ifnextchar [{\@tempswatrue\@citex}{\@tempswafalse\@citex[]}
%}%
%\def\@citex[#1]#2{%
%	\let\@citea\@empty
%	\@cite{\@for\@citeb:=#2\do
%			{\@citea\def\@citea{,\penalty\@m\ }%
%			\edef\@citeb{\expandafter\@firstofone\@citeb}%
%			\if@filesw\immediate\write\@auxout{\string\citation{\@citeb}}\fi
%			\@ifundefined{b@\@citeb}{\mbox{\reset@font\bfseries ?}%
%				\G@refundefinedtrue
%				\@latex@warning
%				 {Citation Вот `\@citeb' on page \thepage \space undefined}}%
%			{\hbox{\csname b@\@citeb\endcsname}}}}{#1}}% def
%\expandafter\let\csname b@*\endcsname\@empty
%\def\@cite#1#2{\printcitestart{#1\if@tempswa , #2\fi}\printcitefinish}
\def\@cite#1#2{\printcitestart{#1\if@tempswa , #2\fi}\printcitefinish}
% END of "from latex.ltx"
\DeclareRobustCommand\batchcite{%
	\@ifnextchar [{\@tempswatrue\@batchcitex}{\@tempswafalse\@batchcitex[]}
}%
\def\@batchcitex[#1]#2{%
	\let\@batchcitea\@empty
	\@batchcite{\@for\@batchciteb:=#2\do
			{\@batchcitea\def\@batchcitea{~--\penalty\@m\ }%
			\edef\@batchciteb{\expandafter\@firstofone\@batchciteb}%
			\if@filesw\immediate\write\@auxout{\string\citation{\@batchciteb}}\fi
			\@ifundefined{b@\@batchciteb}{\mbox{\reset@font\bfseries ?}%
				\G@refundefinedtrue
				\@latex@warning
{Пакетная ссылка `\@batchciteb' на странице \thepage \space неопределна}}%
			{\hbox{\csname b@\@batchciteb\endcsname}}}}{#1}}% def
%\expandafter\let\csname b@*\endcsname\@empty
\def\@batchcite#1#2{\printcitestart{#1\if@tempswa , #2\fi}\printcitefinish}
%%
%% Неудачная подмена \nocite !!!!
\DeclareRobustCommand\hiddencite{%
	\@ifnextchar [{\@tempswatrue\@hiddencitex}{\@tempswafalse\@hiddencitex[]}
}%
\def\@hiddencitex[#1]#2{%
	\let\@hiddencitea\@empty
	\@hiddencite{\@for\@hiddenciteb:=#2\do{%			\edef\@hiddenciteb{\expandafter\@firstofone\@hiddenciteb}%
			\if@filesw\immediate\write\@auxout{\string\citation{\@hiddenciteb}}\fi
			\@ifundefined{b@\@hiddenciteb}{\mbox{\reset@font\bfseries ?}%
				\G@refundefinedtrue
				\@latex@warning
{Скрытая ссылка `\@hiddenciteb' на странице \thepage \space неопределна}}%
			}}{#1}}
\expandafter\let\csname b@*\endcsname\@empty
\def\@hiddencite#1#2{{#1\if@tempswa , #2\fi}}
%% END of "Here I try to make Citation as /1-4/ A.Smolin"

%    ****************************************
%    *           INITIALIZATION             *
%    ****************************************
%
% Default initializations

%\ps@plain                   % 'plain' page style
\ps@myheadings               % 'myheadings' page style
\pagenumbering{arabic}      % Arabic page numbers
\if@twoside\else\raggedbottom\fi % Ragged bottom unless twoside
                                 % option.
\if@twocolumn
 \@@input twocolum.sty\relax
\else
 \onecolumn                 % Single-column.
\fi

% --------------------------------------------------------------------- %
% Это конец ucthesis, а я добавил русификацию по КОИ8 --- А. Смолин     %
%
%% Но для TeTeX она не нужна!!!!
%%\input cyrfont.sty\relax
%%
%%% from hyphen.cfg-russian: Для переносов в КОИ8
%%\def\Russian{\language\l@russian\lefthyphenmin=2\righthyphenmin=2}
%%\def\English{\language\l@plain\lefthyphenmin=2\righthyphenmin=3}
%%
%%{% setup uccode/lccode/mathcode for russian characters
%%\def\letter#1#2{%
%%\global\catcode`#1=11\global\catcode`#2=11%
%%\global\uccode`#1=`#1\global\lccode`#1=`#2%
%%\global\uccode`#2=`#1\global\lccode`#2=`#2%
%%\count0=`#1\advance\count0 by "7100\global\mathcode`#1=\count0%
%%\count0=`#2\advance\count0 by "7100\global\mathcode`#2=\count0}%
%%%
%%\letter{Й}{й}\letter{Ц}{ц}\letter{У}{у}\letter{К}{к}\letter{Е}{е}%
%%\letter{Н}{н}\letter{Г}{г}\letter{Ш}{ш}\letter{Щ}{щ}\letter{З}{з}%
%%\letter{Э}{э}\letter{Ф}{ф}\letter{Ы}{ы}\letter{В}{в}\letter{А}{а}%
%%\letter{П}{п}\letter{Р}{р}\letter{О}{о}\letter{Л}{л}\letter{Д}{д}%
%%\letter{Ж}{ж}\letter{Я}{я}\letter{Ч}{ч}\letter{С}{с}\letter{М}{м}%
%%\letter{И}{и}\letter{Т}{т}\letter{Ь}{ь}\letter{Б}{б}\letter{Ю}{ю}%
%%\letter{Ъ}{ъ}\letter{Х}{х}%
%%% special for letter yo (if any)
%%\global\catcode`Е=11%
%%\global\catcode`е=11%
%%\global\uccode`Е=`Е%
%%\global\lccode`Е=`е%
%%\global\uccode`е=`Е%
%%\global\lccode`е=`е%
%%\count0=`Е\advance\count0 by "7100\global\mathcode`Е=\count0%
%%\count0=`е\advance\count0 by "7100\global\mathcode`е=\count0%
%%}%
%%
%%\def\@alph#1{\ifcase#1\or а\or б\or в\or г\else\@ialph{#1}\fi}%
%%\def\@ialph#1{\ifcase#1\or \or \or \or \or д\or е\or ж\or з\or и\or й\or
%%   к\or л\or м\or н\or о\or п\or р\or с\or т\or у\or ф\or х\or ц\or ч\or ш\or
%%   щ\or ъ\or ы\or ь\or э\or ю\or я\else\@ctrerr\fi}%
%%\def\@Alph#1{\ifcase#1\or А\or Б\or В\or Г\else\@Ialph{#1}\fi}%
%%\def\@Ialph#1{\ifcase#1\or \or \or \or \or Д\or Е\or Ж\or З\or И\or Й\or
%%   К\or Л\or М\or Н\or О\or П\or Р\or С\or Т\or У\or Ф\or Х\or Й\or Ч\or Ш\or
%%   Щ\or Ъ\or Ы\or Ь\or Э\or Ю\or Я\else\@ctrerr\fi}%
%%%
%%%   macro \| might be used instead of ``-'' in complicated words
%%%
%%% from GERMAN.STY
%%%
%%\def\|{%                % Ligaturen aufbrechen (wenn nicht im math mode)
%%   \ifmmode  \Vert
%%   \else  \allowhyphens-\allowhyphens\fi}%
%%{\catcode`\@=11\gdef\allowhyphens{\penalty\@M\hskip\z@skip}}%
%%%     vorlaeufige Aenderung der Umbruchparameter -- wird bei V3.0 geaendert!
%%\tolerance=2500\hbadness=1500%   % Umbruchparameter: lange deutsche Woerter
%%%%
%%\Russian% Русский язык
%%\frenchspacing%

\endinput
%
