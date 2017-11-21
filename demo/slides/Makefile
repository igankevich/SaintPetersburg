SOURCE_ROOT = $(shell pwd)

SLIDES_NAME = example
SLIDES_INPUTS = $(SOURCE_ROOT)/src//:$(SOURCE_ROOT)//:

LATEXMK = latexmk
LATEXMK_FLAGS = \
	-interaction=nonstopmode \
	-output-directory=$(SOURCE_ROOT)/build \
	-pdf \
	-xelatex \
	-bibtex

all: build build/$(SLIDES_NAME).pdf

build/$(SLIDES_NAME).pdf: \
Makefile \
example.tex \
build
	TEXINPUTS=$(SLIDES_INPUTS) \
	BIBINPUTS=$(SLIDES_INPUTS) \
	TTFONTS=$(SLIDES_INPUTS) \
	OPENTYPEFONTS=$(SLIDES_INPUTS) \
	$(LATEXMK) $(LATEXMK_FLAGS) -jobname=$(SLIDES_NAME) $(SOURCE_ROOT)/example.tex

build:
	mkdir build

clean:
	rm -rf build
