#!/bin/sh

# This script updates the cryptobib subtree and converts the cryptobib files
# to the biblatexml format, which biber can read much faster than the bibtex
# format (20x faster).

set -e

cleanup() {
    rm -rf "$temp_dir"
}

cd -P -- "$(dirname -- "$0")"

prefix="vendor/cryptobib"

if [ ! -d "$prefix" ]; then
    cmd="add"
else
    cmd="pull"
fi

git diff HEAD --quiet || {
    echo ">>> error: You have unstaged changes. Please commit or stash them first."
    exit 1
}

head_before=$(git rev-parse HEAD)
git subtree "$cmd" --squash --prefix "$prefix" -m "Update to latest cryptobib" https://github.com/cryptobib/export master
head_after=$(git rev-parse HEAD)
if [ "$head_before" = "$head_after" ] && [ "$1" != "--force-regen-bltxml" ]; then
    exit 0
fi

echo
echo '>>> Regenerating cryptobib_converted.bltxml...'
echo '>>> '
echo '>>> Grab a coffee, this will take a while (~30 min on a modern laptop).'
echo '>>> You can interrupt with Ctrl+C at any time, but then biber will still'
echo '>>> use the old data. In that case, simply run this script later again'
echo '>>> with --force-regen-bltxml to finish the update.'
echo

temp_dir="$(mktemp -q -d -t "$(basename "$0").XXXXXX")"
cp cryptobib/abbrev3.bib "$temp_dir/combined.bib"
cat cryptobib/crypto.bib >> "$temp_dir/combined.bib"

# Make ePrint entries use BibLaTeX native "eprint" and "eprinttype" fields
# FIXME "eprint" fields are not supported at all in bltxml, see:
#       https://github.com/plk/biblatex/issues/1428
# sed -i -E 's|url *= *"https://eprint\.iacr\.org/([0-9]{4}/[0-9]+)"|eprint = {\1}, eprinttype = {iacr}|g; s|howpublished *= *"[^}]*",?||g' "$temp_dir/combined.bib"
#
# Alternative implementation as a source map, but it won't work either:
# \DeclareSourcemap{
#   \maps[datatype=biblatexml]{
#     \map{
#       \step[fieldsource=url, match=\regexp{https://eprint\.iacr\.org/(\d+)/(\d+)}, final]
#       % FIXME Biber doesn't like the slash here. How to deal with this?
#       \step[fieldset=eprint, fieldvalue={$1/$2}]
#       \step[fieldset=eprinttype, fieldvalue={iacr}]
#       \step[fieldset=url, null]
#     }
#   }
# }
#
# As a workaround, just do it manually in the "howpublished" field for now:
sed -i -E 's|howpublished *= *"[^"]*",?||; s|url *= *"https://eprint\.iacr\.org/([0-9]{4}/[0-9]+)"|howpublished = "\\iacreprint{\1}"|' "$temp_dir/combined.bib"

# For debugging:
# less "$temp_dir/combined.bib"
# exit

biber --tool --output-file="$temp_dir/cryptobib_converted.bltxml" --output-format=biblatexml "$temp_dir/combined.bib"
mv -f "$temp_dir/cryptobib_converted.bltxml" cryptobib_converted.bltxml

git diff HEAD --quiet || {
    echo '>>> error: You have unstaged changes, refusing to commit automatically.'
    echo '>>> cryptobib_converted.bltxml has been generated successfully but you'
    echo '>>> will need to commit it manually. Use:'
    echo '>>> '
    echo '>>> git add cryptobib_converted.bltxml'
    echo '>>> git commit -m "Regenerate cryptobib_converted.bltxml"'
    cleanup
    exit 1
}

git add cryptobib_converted.bltxml
git commit -m "Regenerate cryptobib_converted.bltxml"
cleanup
