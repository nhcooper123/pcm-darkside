all: dark.pdf

dark.pdf: dark.tex
	pdflatex dark
	bibtex dark
	pdflatex dark
	pdflatex dark

tidy:
	rm -f dark.{aux,bbl,blg,log}

clean: tidy
	rm -f dark.pdf

.PHONY: all tidy clean
