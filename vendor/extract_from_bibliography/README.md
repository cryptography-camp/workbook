# Extract biblatex entries from big bibliographies

This is a python script that will allow you to extract entries from large bibliographies.

For example, if you're using [cryptobib][cryptobib], it may take a few minutes to compile everything.

Not anymore! This script will take your biblatex `bcf` file and then extract the needed entries from larger bibfiles.


## Makefile example

```Makefile
.PHONY: main.pdf
main.pdf: extracted_cryptobib.bib
	./latexrun --bibtex-cmd=biber -Wall main.tex
	# or latexmk, or just pdflatex a bunch of times...

latex.out/main.bcf:
	mkdir -p latex.out
	pdflatex -interaction=batchmode -output-directory=latex.out main

extracted_cryptobib.bib: latex.out/main.bcf cryptobib/crypto.bib
	python3 extract_from_bibliography.py $^ > $@
```

[cryptobib]: https://cryptobib.di.ens.fr
