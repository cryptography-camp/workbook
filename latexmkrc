$pdf_mode = 1;
$pdflatex = 'pdflatex -interaction=nonstopmode -synctex=1 %O %S';
@default_files = ('main.tex');
$bibtex_use = 2;
$aux_dir = 'latex.out';
$do_cd = 1;
$clean_ext = 'synctex.gz synctex.gz(busy) run.xml bbl bcf fdb_latexmk run tdo %R-blx.bib sil';
