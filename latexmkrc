$pdf_mode = 1;
$pdflatex = 'pdflatex -interaction=nonstopmode -synctex=1 %O %S';
@default_files = ('main.tex');
$aux_dir = 'latex.out';
$do_cd = 1;

$biber = './biber-wrapper.sh %O %S';
$bibtex_use = 2;

# sil: "silence" package
# exttmp.*: biber-wrapper.sh
$clean_ext = 'synctex.gz synctex.gz(busy) run.xml bbl bcf fdb_latexmk run tdo %R-blx.bib sil exttmp.bib exttmp.bcf exttmp.bbl exttmp.blg';
