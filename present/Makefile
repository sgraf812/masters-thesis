BUILD=build
BASE=present
DEPS=$(wildcard *.tex) $(wildcard *.sty)

default: $(BASE).pdf

$(BUILD)/$(BASE).pdf: $(BASE).tex $(DEPS)
	mkdir -p $(BUILD)
	TEXINPUTS=$(TEXINPUTS):style latexmk -f -e '$$pdflatex=q/pdflatex %O -shell-escape %S/' -pdf -halt-on-error -jobname=build/$(BASE) $<

$(BASE).pdf: $(BUILD)/$(BASE).pdf
	mv $< $@ # atomic update
	cp $@ $<

.PHONY: show clean

show: $(BASE).pdf
	gnome-open $< || open $<

clean:
	rm -rf build
