# Saint-Petersburg: LaTeX Beamer theme for SPbU

A small theme that incorporates university colours, fonts and CoA from
[official web-site](http://pr.spbu.ru/).

## Features

- Load university logo corresponding to the selected language.
- Russian translations for most strings (e.g. Section, Part, Theorem etc.)
- Proper alignment of multicolumn blocks.

## Installation

On Linux type ``make install`` to install everything to standard TeX Live
locations. Alternatively, just copy all `*.sty`, `*.eps` and `*.otf` files into
your project directory so that LaTeX can find them.

## Usage

Saint-Petersburg theme can be compiled by LaTeX or XeTeX. Here is the minimal
working example:
```latex
\documentclass[aspectratio=169]{beamer}
% add \usepackage{beamerposter} for the poster

% XeTeX
\usepackage{polyglossia}
\setdefaultlanguage{english}
% or \setdefaultlanguage{russian}

% LaTeX
\usepackage[utf8]{inputenc}
\usepackage[english]{babel}
% or \usepackage[english,russian]{babel}

\usetheme{SaintPetersburg}
% or \usetheme[nologo]{SaintPetersburg} to disable logo on the title page
% or \usetheme[poster]{SaintPetersburg} for poster format

\title{Saint Petersburg \LaTeX~Beamer theme}
\author{Ivan Gankevich}
\institute{Saint Petersburg State University}
\date{2017}

\begin{document}
\frame{\titlepage}
\end{document}
```

Compilation
```shell
latexmk -pdf -xelatex example.tex  # XeTeX
latexmk -pdf example.tex           # LaTeX
```

## License

GPL licensed.
