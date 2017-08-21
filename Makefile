THEME_NAME = SaintPetersburg
LATEXMK = latexmk
LATEXMK_FLAGS = \
	-interaction=nonstopmode \
	-output-directory=build \
	-pdf \
	-xelatex \
	-bibtex

# recursively search inputs in the current directory
# and then in system directories
INPUTS = .//:

TEXMF_LOCAL_DIR = $(shell kpsewhich --var-value TEXMFLOCAL)
THEME_DIR = $(TEXMF_LOCAL_DIR)/tex/latex/$(THEME_NAME)
THEME_FONT_DIR = $(TEXMF_LOCAL_DIR)/fonts/opentype/public/$(THEME_NAME)

all: build/slides.pdf build/poster.pdf

build/slides.pdf: build
build/slides.pdf: *.sty example.tex refs.bib
build/slides.pdf: fonts/* art/*
build/slides.pdf: export TEXINPUTS=$(INPUTS)
build/slides.pdf: export BIBINPUTS=$(INPUTS)
build/slides.pdf: export TTFONTS=$(INPUTS)
build/slides.pdf: export OPENTYPEFONTS=$(INPUTS)
build/slides.pdf:
	$(LATEXMK) $(LATEXMK_FLAGS) -jobname=slides example.tex

build/poster.pdf: build
build/poster.pdf: *.sty poster.tex
build/poster.pdf: fonts/* art/*
build/poster.pdf: export TEXINPUTS=$(INPUTS)
build/poster.pdf: export BIBINPUTS=$(INPUTS)
build/poster.pdf: export TTFONTS=$(INPUTS)
build/poster.pdf: export OPENTYPEFONTS=$(INPUTS)
build/poster.pdf:
	$(LATEXMK) $(LATEXMK_FLAGS) -jobname=poster poster.tex

build:
	mkdir build

check: install
	./test

install:
	mkdir -p $(THEME_DIR) $(THEME_FONT_DIR)
	install -m644 beamerthemeSaintPetersburg.sty $(THEME_DIR)
	install -m644 beamerfontthemeSaintPetersburg.sty $(THEME_DIR)
	install -m644 beamercolorthemeSaintPetersburg.sty $(THEME_DIR)
	install -m644 art/spbu-block-en.pdf $(THEME_DIR)
	install -m644 art/spbu-block-ru.pdf $(THEME_DIR)
	install -m644 art/spbu-CoA.pdf $(THEME_DIR)
	install -m644 fonts/OldStandard-Bold.otf $(THEME_FONT_DIR)
	install -m644 fonts/OldStandard-Italic.otf $(THEME_FONT_DIR)
	install -m644 fonts/OldStandard-Regular.otf $(THEME_FONT_DIR)
	mktexlsr

uninstall:
	rm -rf $(THEME_DIR) $(THEME_FONT_DIR)
	mktexlsr

ctanify:
	ctanify \
		--pkgname=$(THEME_NAME) \
		beamerthemeSaintPetersburg.sty \
		beamerfontthemeSaintPetersburg.sty \
		beamercolorthemeSaintPetersburg.sty \
		"fonts/OldStandard-*.otf=fonts/opentype/public/$(THEME_NAME)" \
		"art/*.pdf=tex/latex/$(THEME_NAME)"
	mv -v $(THEME_NAME).tar.gz build


clean:
	rm -rf build
