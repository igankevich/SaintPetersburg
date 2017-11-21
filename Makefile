THEME_NAME = beamertheme-saintpetersburg
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

BEAMER_THEMES_DIR = $(TEXMF_LOCAL_DIR)/tex/latex/beamer/themes

all: sty doc example

sty: \
build/beamercolorthemeSaintPetersburg.sty \
build/beamerfontthemeSaintPetersburg.sty \
build/beamerthemeSaintPetersburg.sty \
	
doc: build/SaintPetersburg.pdf

example:
	$(MAKE) -C demo/slides

build/beamercolorthemeSaintPetersburg.sty \
build/beamerfontthemeSaintPetersburg.sty \
build/beamerthemeSaintPetersburg.sty: build src/SaintPetersburg.ins src/*.dtx
	(cd src && \
		latex -output-directory=$(ROOT)/build SaintPetersburg.ins)

build/SaintPetersburg.pdf: src/*.dtx
	(cd src && \
		TTFONTS=$(INPUTS) OPENTYPEFONTS=$(INPUTS) \
		xelatex -output-directory=$(ROOT)/build SaintPetersburg.dtx)

build:
	mkdir build

check: install
	./test

install: sty
	mkdir -p \
		$(THEME_DIR) \
		$(BEAMER_THEMES_DIR)/theme \
		$(BEAMER_THEMES_DIR)/font \
		$(BEAMER_THEMES_DIR)/color
	install -m644 build/beamerthemeSaintPetersburg.sty $(BEAMER_THEMES_DIR)/theme
	install -m644 build/beamerfontthemeSaintPetersburg.sty $(BEAMER_THEMES_DIR)/font
	install -m644 build/beamercolorthemeSaintPetersburg.sty $(BEAMER_THEMES_DIR)/color
	install -m644 build/SaintPetersburg.pdf $(THEME_DIR)
	mktexlsr

uninstall:
	rm -rfv $(THEME_DIR)
	rm -fv \
		$(BEAMER_THEMES_DIR)/theme/beamerthemeSaintPetersburg.sty \
		$(BEAMER_THEMES_DIR)/font/beamerfontthemeSaintPetersburg.sty \
		$(BEAMER_THEMES_DIR)/color/beamercolorthemeSaintPetersburg.sty
	mktexlsr

ctanify: sty doc
	rm -rf build/$(THEME_NAME)
	mkdir -p build/$(THEME_NAME)
	cp -rv src/*.dtx src/*.ins \
		build/SaintPetersburg.pdf \
		README.md \
		build/$(THEME_NAME)
	cp -rv demo/slides/build/example.pdf \
		demo/slides/example.tex \
		demo/slides/figures \
		build/$(THEME_NAME)
	cd build && \
	tar czvf $(THEME_NAME).tar.gz $(THEME_NAME)

ctanupload:
	CTAN_EMAIL=$(pass show email) \
	ctanupload -F ctanupload.conf

clean:
	rm -rf build
	$(MAKE) -C demo/slides clean
