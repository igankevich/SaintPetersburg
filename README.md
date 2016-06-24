# Saint-Petersburg: X<sub>E</sub>T<sub>E</sub>X Beamer theme for SPbU

A small theme that incorporates university colours, fonts and CoA from
[official web-site](http://pr.spbu.ru/).

## Features

- Load university logo corresponding to the selected language.
- Russian translations for most strings (e.g. Section, Part, Theorem etc.)
- Proper alignment of multicolumn blocks.

## Installation

On Linux type ``make install`` to install everything to standard TeX Live
locations. Alternatively, just copy all *.sty, *.eps and *.otf files into your
project directory so that X<sub>E</sub>T<sub>E</sub>X can find them.

## Usage

Saint-Petersburg theme can be compiled by X<sub>E</sub>T<sub>E</sub>X only.
Here is the minimal working example:
```latex
\documentclass[aspectratio=169]{beamer}
% load polyglossia before theme
\usepackage{polyglossia}
\setdefaultlanguage{english}
% or \setdefaultlanguage{russian}
\usetheme{SaintPetersburg}
```

## License

GPL licensed.
