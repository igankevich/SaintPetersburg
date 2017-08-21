THEME_NAME = SaintPetersburg
LATEXMK = latexmk
LATEXMK_FLAGS = \
	-interaction=nonstopmode \
	-output-directory=build \
	-pdf \
	-xelatex \
	-bibtex \
	-jobname=$(THEME_NAME)

# recursively search inputs in the current directory
# and then in system directories
INPUTS = .//:

TEXMF_LOCAL_DIR = $(shell kpsewhich --var-value TEXMFLOCAL)
THEME_DIR = $(TEXMF_LOCAL_DIR)/tex/latex/$(THEME_NAME)
THEME_FONT_DIR = $(TEXMF_LOCAL_DIR)/fonts/opentype/public/$(THEME_NAME)

build/$(THEME_NAME).pdf: build
build/$(THEME_NAME).pdf: *.sty example.tex refs.bib
build/$(THEME_NAME).pdf: fonts/* art/*
build/$(THEME_NAME).pdf: export TEXINPUTS=$(INPUTS)
build/$(THEME_NAME).pdf: export BIBINPUTS=$(INPUTS)
build/$(THEME_NAME).pdf: export TTFONTS=$(INPUTS)
build/$(THEME_NAME).pdf: export OPENTYPEFONTS=$(INPUTS)
build/$(THEME_NAME).pdf:
	$(LATEXMK) $(LATEXMK_FLAGS) example.tex

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
