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

build/$(THEME_NAME).pdf: build
build/$(THEME_NAME).pdf: *.sty example.tex
build/$(THEME_NAME).pdf: fonts/* art/*
build/$(THEME_NAME).pdf: export TEXINPUTS=$(INPUTS)
build/$(THEME_NAME).pdf: export BIBINPUTS=$(INPUTS)
build/$(THEME_NAME).pdf: export TTFONTS=$(INPUTS)
build/$(THEME_NAME).pdf: export OPENTYPEFONTS=$(INPUTS)
build/$(THEME_NAME).pdf:
	$(LATEXMK) $(LATEXMK_FLAGS) example.tex

build:
	mkdir build

install:
	install -m644 -D -t $(TEXMF_LOCAL_DIR)/tex/latex/$(THEME_NAME)/ \
		beamerthemeSaintPetersburg.sty \
		art/spbu-block-en.eps \
		art/spbu-block-ru.eps \
		art/spbu-CoA.eps
	install -m644 -D -t $(TEXMF_LOCAL_DIR)/fonts/opentype/public/$(THEME_NAME)/ \
		fonts/OldStandard-Bold.otf \
		fonts/OldStandard-Italic.otf \
		fonts/OldStandard-Regular.otf
	mktexlsr

uninstall:
	rm -rf \
		$(TEXMF_LOCAL_DIR)/fonts/opentype/public/$(THEME_NAME)/ \
		$(TEXMF_LOCAL_DIR)/tex/latex/$(THEME_NAME)/
	mktexlsr

ctanify:
	ctanify \
		--pkgname=$(THEME_NAME) \
		beamerthemeSaintPetersburg.sty \
		"fonts/OldStandard-*.otf=fonts/opentype/public/$(THEME_NAME)" \
		"eps/*=tex/latex/$(THEME_NAME)"
	mv -v $(THEME_NAME).tar.gz build


clean:
	rm -rf build
