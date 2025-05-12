#!/usr/bin/env bash
set -e

# bib: The path to original BibTeX file (may not contain "<", ">", and "&").
bib="vendor/cryptobib/crypto.bib"


lastarg="${*: -1}"
bcf_stem="${lastarg/%.bcf/}"
bcf="$bcf_stem.bcf"
bcf_dir=$(dirname "$bcf")
jobname=$(basename "$lastarg" ".bcf")
bib_ex="${bcf_stem}.exttmp.bib"

# Switch to the directory of this script
cd "${BASH_SOURCE%/*}" || exit 1

# Do the extraction
./vendor/extract_from_bibliography/extract_from_bibliography.py "$bcf" "$bib" > "$bib_ex"

# Modify the BCF file to use the extracted BibTeX file
bcf_ex="${bcf_stem}.exttmp.bcf"
sed -e "s&>$bib</bcf:datasource>&>$bib_ex</bcf:datasource>&" "$bcf" > "$bcf_ex"

# Call biber with the modified BCF file
biber "${@:1:$#-1}" "$bcf_ex"
ret=$?
if [ $ret -ne 0 ]; then
    exit $ret
fi

# Rename the generated files to have the right jobname
mv "${bcf_stem}.exttmp.bbl" "$bcf_dir/$jobname.bbl"
mv "${bcf_stem}.exttmp.blg" "$bcf_dir/$jobname.blg"

# Remove the temporary files
#
# We delibaretly them when an error occurs, so they can be inspected.
rm -f "./$bcf_ex"
rm -f "./$bib_ex"
