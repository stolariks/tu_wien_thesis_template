%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Document class for a TU Wien "Diplomarbeit" (master's thesis).
%
% Styling and the required front matter follow the TU Wien template of the
% NumPDEs group (title page, Kurzfassung, Abstract, Danksagung, Eidesstattliche
% Erklaerung). The usage workflow follows the FIT BUT template: fill in one
% \projectinfo{...} block in thesis.tex and write the body in a single file.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{thesis}[2026/07/06 TU Wien Diplomarbeit template, FIT-BUT-style workflow]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Base class: pass all unknown options on to scrbook (KOMA-Script)

% Class option "print": black hyperlinks for printing (default: coloured links).
\newif\if@printmode \@printmodefalse
\DeclareOption{print}{\@printmodetrue}
% All other options are forwarded to scrbook. In particular:
%   oneside  -> single-sided (default in thesis.tex; margins are the same on
%               every page).
%   twoside  -> double-sided printing; the text block shifts towards the binding
%               on alternating pages (left/right), governed by BCOR below.
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrbook}}
\ProcessOptions\relax
\LoadClass{scrbook}

% Page layout
\KOMAoptions{footinclude=false} % footer is not counted into the type area
\KOMAoptions{headsepline=true}  % separating line between header and text
\KOMAoptions{DIV=12}            % type area
\KOMAoptions{BCOR=8mm}          % binding correction
\pagestyle{headings}            % running heads
\recalctypearea

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Packages
% English is the main language; ngerman is available for the parts that must be
% German (Kurzfassung, Eidesstattliche Erklaerung, title page).

\RequirePackage[ngerman,english]{babel}
\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}
\RequirePackage{csquotes}
\RequirePackage{etoolbox}
\RequirePackage{amsmath,amssymb}
\RequirePackage{graphicx}
\RequirePackage[dvipsnames]{xcolor}
\RequirePackage{microtype}
\RequirePackage{enumitem}
\RequirePackage{booktabs}
\RequirePackage{keyval}
\RequirePackage{hyperref}
\RequirePackage{cleveref} % must be loaded after hyperref

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Colours (TU Wien)

\definecolor{change}{rgb}{0,.55,.55} % highlight colour for fields to fill in
\definecolor{TUBlue}{HTML}{006699}
\definecolor{TUGreen}{HTML}{007E71}
\definecolor{TUGrey}{HTML}{646363}
\definecolor{TUMagenta}{HTML}{BA4682}
\definecolor{TUYellow}{HTML}{E18922}

% Hyperlink colours: black in "print" mode, coloured otherwise.
\if@printmode
  \hypersetup{colorlinks=true, citecolor=black, linkcolor=black, urlcolor=black}
\else
  \hypersetup{colorlinks=true, citecolor=ForestGreen, linkcolor=BrickRed, urlcolor=NavyBlue}
\fi

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Bibliography (BibLaTeX + biber)

\RequirePackage[backend=biber,style=trad-alpha,safeinputenc]{biblatex}
\ExecuteBibliographyOptions{
  maxnames=20,
  maxalphanames=4,
  minalphanames=3,
  giveninits=true,
  useprefix=false,
}
% Do not force capitalisation from the .bib file
\DeclareFieldFormat{titlecase}{#1}
% Drop a few redundant fields from the bibliography entries
\AtEveryBibitem{
  \clearlist{language}%
  \clearfield{urlyear}%
  \clearfield{note}%
  \clearfield{month}%
  \ifentrytype{article}{%
    \clearfield{issn}%
    \clearfield{issue}%
    \clearfield{url}}{}%
  \ifentrytype{book}{%
    \clearfield{volume}%
    \clearfield{isbn}%
    \clearfield{series}%
    \clearfield{pages}}{}%
  \ifentrytype{inproceedings}{%
    \clearfield{series}%
    \clearname{editor}%
    \clearfield{pages}}{}%
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Lists, captions and numbering

\setlist[enumerate,1]{label={\upshape(\roman*)}}
\setlist[enumerate,2]{label={\upshape(\alph*)}}
\setlist[enumerate,3]{label={\upshape(\Roman*)}}

\counterwithout{figure}{chapter} % continuous figure numbering (no chapter prefix)
\counterwithout{table}{chapter}  % continuous table numbering (no chapter prefix)
\RequirePackage[format=plain]{caption}
\RequirePackage{subcaption}
\captionsetup{width=0.9\textwidth}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Project information (FIT-BUT-style key/value store)
% Fill these in thesis.tex via \projectinfo{ key = value, ... }.

\makeatletter

% Defaults (overwritten by \projectinfo)
\def\@thesistitle{Title of the thesis}
\def\@thesisauthor{Firstname Lastname}
\def\@thesismatrikel{}
\def\@thesisstreet{}
\def\@thesiscity{}
\def\@thesisinstitute{Institut f\"ur\\[1ex] Analysis und Scientific Computing}
\def\@thesisuniversity{TU Wien}
\def\@thesissupervisor{Name of the supervisor}
\def\@thesisplace{Wien}
\def\@thesisdate{\today}
\def\@thesiskurzfassung{}
\def\@thesisabstract{}
\def\@thesisacknowledgement{} % optional: empty means the page is skipped
\def\@thesisdeclaration{%
  Ich erkl\"are an Eides statt, dass ich die vorliegende Diplomarbeit
  selbstst\"andig und ohne fremde Hilfe verfasst, andere als die angegebenen
  Quellen und Hilfsmittel nicht benutzt bzw.\ die w\"ortlich oder sinngem\"a{\ss}
  entnommenen Stellen als solche kenntlich gemacht habe.%
}

\define@key{projectinfo}{title}{\def\@thesistitle{#1}}
\define@key{projectinfo}{author}{\def\@thesisauthor{#1}}
\define@key{projectinfo}{matrikelnummer}{\def\@thesismatrikel{#1}}
\define@key{projectinfo}{street}{\def\@thesisstreet{#1}}
\define@key{projectinfo}{city}{\def\@thesiscity{#1}}
\define@key{projectinfo}{institute}{\def\@thesisinstitute{#1}}
\define@key{projectinfo}{university}{\def\@thesisuniversity{#1}}
\define@key{projectinfo}{supervisor}{\def\@thesissupervisor{#1}}
\define@key{projectinfo}{place}{\def\@thesisplace{#1}}
\define@key{projectinfo}{date}{\def\@thesisdate{#1}}
\define@key{projectinfo}{kurzfassung}{\def\@thesiskurzfassung{#1}}
\define@key{projectinfo}{abstract}{\def\@thesisabstract{#1}}
\define@key{projectinfo}{acknowledgement}{\def\@thesisacknowledgement{#1}}
\define@key{projectinfo}{declaration}{\def\@thesisdeclaration{#1}}

\newcommand{\projectinfo}[1]{\setkeys{projectinfo}{#1}}

% --- Multiple supervisors ---------------------------------------------------
% The "supervisor" field may list several names separated by commas, e.g.
%   supervisor={First Supervisor, Second Supervisor}
% Each name then gets its own line under "unter der Anleitung von" and its own
% signature field on the title page. A single supervisor renders as before.

% Supervisor names, one per line (no trailing line break).
\newcommand{\@svname}[1]{\@svsep #1\def\@svsep{\\[1ex]}}
\newcommand{\@svloopnames}[1]{\forcsvlist{\@svname}{#1}}
\newcommand{\thesissupervisornames}{%
  \def\@svsep{}%
  \expandafter\@svloopnames\expandafter{\@thesissupervisor}% expand list, then split
}

% One signature field per supervisor, stacked vertically (gap before each field
% except the first, so there is no trailing space).
\newcommand{\@svsig}[1]{%
  \@svsigsep
  \underline{\hspace*{4cm}}\\
  \small{\color{change}#1}%
  \def\@svsigsep{\\[8mm]}%
}
\newcommand{\@svloopsigs}[1]{\forcsvlist{\@svsig}{#1}}
\newcommand{\thesissupervisorsignatures}{%
  \def\@svsigsep{}%
  \expandafter\@svloopsigs\expandafter{\@thesissupervisor}% expand list, then split
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Title page (TU Wien styling)

\renewcommand{\maketitle}{%
  \pagenumbering{Alph}%
  \selectlanguage{ngerman}%
  \begin{titlepage}
    \begin{center}
      \includegraphics[width=0.45\textwidth]{figures/TULogo.pdf}
      \vskip 1cm
      {\LARGE D~\Large I~P~L~O~M~A~R~B~E~I~T}
      \vskip 8mm
      {\huge\bfseries\color{change}\@thesistitle}
      \vskip 1cm
      \large
      ausgef\"uhrt am
      \vskip 0.75cm
      {\Large \@thesisinstitute}\\[1ex]
      {\Large \@thesisuniversity}
      \vskip 0.75cm
      unter der Anleitung von
      \vskip 0.75cm
      {\Large\bfseries\color{change}\thesissupervisornames}\\[1ex]
      \vskip 0.5cm
      durch
      \vskip 0.5cm
      {\Large\bfseries\color{change}\@thesisauthor}\\[1ex]
      Matrikelnummer: {\color{change}\@thesismatrikel}\\[1ex]
      {\color{change}\@thesisstreet}\\[1ex]
      {\color{change}\@thesiscity}
    \end{center}

    \vfill

    \noindent
    \begin{minipage}[t]{4cm}
      \small \@thesisplace, am {\color{change}\@thesisdate}
    \end{minipage}
    \hfill % signature fields (only needed for the printed submission version)
    \begin{minipage}[t]{4cm}
      \centering
      \thesissupervisorsignatures
    \end{minipage}
    \hfill
    \begin{minipage}[t]{4cm}
      \centering
      \underline{\hspace*{4cm}}\\
      \small{\color{change}\@thesisauthor}
    \end{minipage}
    \vspace*{-15mm}
  \end{titlepage}
  \cleardoublepage
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Kurzfassung (German abstract, obligatory)

\newcommand{\makekurzfassung}{%
  \chapter*{Kurzfassung}
  \thispagestyle{empty}%
  \selectlanguage{ngerman}%
  \@thesiskurzfassung
  \cleardoublepage
}

% Abstract (English, obligatory)
\newcommand{\makeenglishabstract}{%
  \chapter*{Abstract}
  \thispagestyle{empty}%
  \selectlanguage{english}%
  \@thesisabstract
  \cleardoublepage
}

% Danksagung / Acknowledgement (optional: skipped when empty)
\newcommand{\makedanksagung}{%
  \ifx\@thesisacknowledgement\@empty\else
    \chapter*{Danksagung}
    \thispagestyle{empty}%
    \@thesisacknowledgement
    \cleardoublepage
  \fi
}

% Eidesstattliche Erklaerung (declaration, obligatory)
\newcommand{\makeerklaerung}{%
  \chapter*{Eidesstattliche Erkl\"arung}
  \thispagestyle{empty}%
  \selectlanguage{ngerman}%
  \vspace*{2cm}

  \@thesisdeclaration

  \vspace*{3cm}

  \noindent
  \@thesisplace, am {\color{change}\@thesisdate}%
  \hfill
  \begin{minipage}[t]{5cm}
    \centering
    \underline{\hspace*{5cm}}\\
    \small\color{change}\@thesisauthor
  \end{minipage}
  \cleardoublepage
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Convenience: render all obligatory (and the optional) front-matter pages.

\newcommand{\makefrontmatter}{%
  \maketitle
  \makekurzfassung
  \makeenglishabstract
  \makedanksagung
  \makeerklaerung
  \selectlanguage{english}%
}

\makeatother
