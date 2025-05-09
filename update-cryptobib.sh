#!/bin/sh

# This script adds or updates the cryptobib subtree.
prefix="vendor/cryptobib"

# Switch to the directory of this script
cd -P -- "$(dirname -- "$0")" || exit 1

if [ ! -d "$prefix" ]; then
    cmd="add"
else
    cmd="pull"
fi

git subtree "$cmd" --squash --prefix "$prefix" -m "Update to latest cryptobib" https://github.com/cryptobib/export master
