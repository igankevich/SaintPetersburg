SOURCE_ROOT = $(shell pwd)

SLIDES_NAME = slides-16-arma
SLIDES_INPUTS = $(SOURCE_ROOT)/src//:$(SOURCE_ROOT)//:

LATEXMK = latexmk
LATEXMK_FLAGS = \
	-interaction=nonstopmode \
	-output-directory=$(SOURCE_ROOT)/build \
	-pdf \
	-xelatex \
	-bibtex

export GNUPLOT_LIB=$(SOURCE_ROOT)/gnuplot:$(SOURCE_ROOT)/data
# recursively search inputs in the current directory
# and then in system directories

all: build build/$(SLIDES_NAME).pdf

build/$(SLIDES_NAME).pdf: \
Makefile \
build/standing-acf-0.eps \
build/standing-acf-1.eps \
build/standing-acf-2.eps \
build/standing-acf-3.eps \
build/standing-acf-4.eps \
build/standing-acf-5.eps \
build/standing-acf-6.eps \
build/standing-acf-7.eps \
build/standing-acf-8.eps \
build/standing-acf-9.eps \
build/propagating-acf-00.eps \
build/propagating-acf-01.eps \
build/propagating-acf-02.eps \
build/propagating-acf-03.eps \
build/propagating-acf-04.eps \
build/propagating-acf-05.eps \
build/propagating-acf-06.eps \
build/propagating-acf-07.eps \
build/propagating-acf-08.eps \
build/propagating-acf-09.eps \
build/propagating-acf-10.eps \
build/propagating-acf-11.eps \
build/propagating-acf-12.eps \
build/propagating-acf-13.eps \
build/propagating-acf-14.eps \
build/propagating-acf-15.eps \
build/propagating-acf-16.eps \
build/propagating-acf-17.eps \
build/propagating-acf-18.eps \
build/propagating-acf-19.eps \
build/standing-elevation.eps \
build/standing-white-noise.eps \
build/standing-wave-height-x.eps \
build/standing-wave-height-y.eps \
build/standing-wave-length-x.eps \
build/standing-wave-length-y.eps \
build/standing-wave-period.eps \
build/propagating-elevation.eps \
build/propagating-white-noise.eps \
build/propagating-wave-height-x.eps \
build/propagating-wave-height-y.eps \
build/propagating-wave-length-x.eps \
build/propagating-wave-length-y.eps \
build/propagating-wave-period.eps \
build \
gnuplot/* \
data/* \
src/*
	TEXINPUTS=$(SLIDES_INPUTS) \
	BIBINPUTS=$(SLIDES_INPUTS) \
	TTFONTS=$(SLIDES_INPUTS) \
	OPENTYPEFONTS=$(SLIDES_INPUTS) \
	$(LATEXMK) $(LATEXMK_FLAGS) -jobname=$(SLIDES_NAME) $(SOURCE_ROOT)/src/main.tex

build/standing-acf-%.svg: data/standing-acf-% gnuplot/acf.gnuplot Makefile
	gnuplot -e "sx=300;sy=200;outext='svg';infile='$<'" \
		$(SOURCE_ROOT)/gnuplot/acf.gnuplot
	mv -v $<.svg build

build/propagating-acf-%.svg: data/propagating-acf-% gnuplot/acf.gnuplot Makefile
	gnuplot -e "sx=300;sy=200;outext='svg';infile='$<'" \
		$(SOURCE_ROOT)/gnuplot/acf.gnuplot
	mv -v $<.svg build

build/standing-%.svg: data/standing-% gnuplot/quantile.gnuplot Makefile
	gnuplot -e "sx=250;sy=250;outext='svg';infile='$<';start_index=15" \
		$(SOURCE_ROOT)/gnuplot/quantile.gnuplot
	mv -v $<.svg build

build/propagating-%.svg: data/propagating-% gnuplot/quantile.gnuplot Makefile
	gnuplot -e "sx=250;sy=250;outext='svg';infile='$<';start_index=18" \
		$(SOURCE_ROOT)/gnuplot/quantile.gnuplot
	mv -v $<.svg build

%.eps: %.svg
	inkscape --without-gui --export-eps=$@ $<

build:
	mkdir build

clean:
	rm -rf build
