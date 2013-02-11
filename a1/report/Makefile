TEX=$(shell which pdflatex)
DOT=$(shell which dot)
TEXFILES=$(filter %.tex, $(shell /usr/bin/find .))
DOTFILES=$(filter %.gv, $(shell /usr/bin/find .))
DRAWINGS=$(patsubst %.gv, %.pdf, $(DOTFILES))

all: document.pdf

document.pdf: ${TEXFILES} ${DRAWINGS} ../vhdl/a1.vhdl
	$(TEX) document.tex

%.pdf: %.gv
	$(DOT) -Tpdf -o $*.pdf $*.gv

.PHONY: clean

clean:
	rm *.pdf -f

spellcheck: ${TEXFILES}
	for f in ${TEXFILES}; do\
		aspell -t --home-dir=. -c $$f ; \
	done
