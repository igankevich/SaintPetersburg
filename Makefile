THEME_NAME = SaintPetersburg
LATEXMK = latexmk
LATEXMK_FLAGS = \
	-interaction=nonstopmode \
	-output-directory=$(ROOT)/build \
	-pdf \
	-xelatex \
	-bibtex

ROOT=$(shell pwd)

# recursively search inputs in the current directory
# and then in system directories
INPUTS = $(ROOT)//:

TEXMF_LOCAL_DIR = $(shell kpsewhich --var-value TEXMFLOCAL)
THEME_DIR = $(TEXMF_LOCAL_DIR)/tex/latex/$(THEME_NAME)
THEME_DOC_DIR = $(TEXMF_LOCAL_DIR)/doc/latex/$(THEME_NAME)

all: sty doc demo

sty: \
build/beamercolorthemeSaintPetersburg.sty \
build/beamerfontthemeSaintPetersburg.sty \
build/beamerthemeSaintPetersburg.sty \
	
doc: build/SaintPetersburg.pdf

demo: build/slides.pdf build/poster.pdf

build/beamercolorthemeSaintPetersburg.sty \
build/beamerfontthemeSaintPetersburg.sty \
build/beamerthemeSaintPetersburg.sty: build src/SaintPetersburg.ins src/*.dtx
	(cd src && \
		latex -output-directory=$(ROOT)/build SaintPetersburg.ins)

build/SaintPetersburg.pdf: src/*.dtx
	(cd src && \
		TTFONTS=$(INPUTS) OPENTYPEFONTS=$(INPUTS) \
		xelatex -output-directory=$(ROOT)/build SaintPetersburg.dtx)


build/slides.pdf: build
build/slides.pdf: demos/slides.tex demos/refs.bib
build/slides.pdf: export TEXINPUTS=$(INPUTS)
build/slides.pdf: export BIBINPUTS=$(INPUTS)
build/slides.pdf: export TTFONTS=$(INPUTS)
build/slides.pdf: export OPENTYPEFONTS=$(INPUTS)
build/slides.pdf:
	(cd demos && $(LATEXMK) $(LATEXMK_FLAGS) -jobname=slides slides.tex)

build/poster.pdf: build
build/slides.pdf: demos/poster.tex demos/refs.bib
build/poster.pdf: export TEXINPUTS=$(INPUTS)
build/poster.pdf: export BIBINPUTS=$(INPUTS)
build/poster.pdf: export TTFONTS=$(INPUTS)
build/poster.pdf: export OPENTYPEFONTS=$(INPUTS)
build/poster.pdf:
	(cd demos && $(LATEXMK) $(LATEXMK_FLAGS) -jobname=poster poster.tex)

build:
	mkdir build

check: install
	./test

install: sty
	mkdir -p $(THEME_DIR) $(THEME_DOC_DIR)
	install -m644 build/beamerthemeSaintPetersburg.sty $(THEME_DIR)
	install -m644 build/beamerfontthemeSaintPetersburg.sty $(THEME_DIR)
	install -m644 build/beamercolorthemeSaintPetersburg.sty $(THEME_DIR)
	install -m644 build/SaintPetersburg.pdf $(THEME_DOC_DIR)
	mktexlsr

uninstall:
	rm -rf $(THEME_DIR) $(THEME_DOC_DIR)
	mktexlsr

ctanify: sty doc
	rm -rf build/dist
	mkdir -p build/dist
	cp -rv src/*.dtx src/*.ins build/*.sty \
		build/SaintPetersburg.pdf \
		README.md \
		build/dist
	cd build/dist && \
	ctanify \
		--pkgname=$(THEME_NAME) \
		"SaintPetersburg.pdf" \
		"SaintPetersburg.ins" \
		"README.md"
	mv -v build/dist/$(THEME_NAME).tar.gz build


clean:
	rm -rf build
