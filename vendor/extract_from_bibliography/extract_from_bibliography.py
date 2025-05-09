#!/usr/bin/env python3
import re
import logging
from typing import Iterable, Set, Tuple, cast
from pathlib import Path
import xml.etree.ElementTree as ET
from collections import OrderedDict

NAMESPACES = {'bcf': "https://sourceforge.net/projects/biblatex"}


def get_keys(filename: Path | str) -> Set[str]:
    parser = ET.parse(filename)
    root = parser.getroot()
    return {cast(str, item.text) for item in root.findall('.//bcf:citekey', NAMESPACES)}


def get_items_from_bib(keys: Iterable[str], filename: Path | str) -> Iterable[Tuple[str, str]]:
    with open(filename, 'r') as f:
        contents = f.read()
    regex = re.compile(
        r"""
        ^@ \w+ \{ (?P<key>%s),$\n          # KEY
          .*?                    # BODY
        ^\s*\}$""" % '|'.join(map(re.escape, keys)),
        re.MULTILINE | re.VERBOSE | re.DOTALL)
    for match in regex.finditer(contents):
        key = match.group("key")
        assert isinstance(key, str)
        item = match.group(0)
        logging.debug("Found %s", item.split('\n')[0])
        yield key, item

def cleanup_item(item: str):
    if 'date' not in item:
        return item
    cleaned = []
    for line in item.split('\n'):
        if line.lstrip().startswith('month '):
            line = line.replace("month =", "_month =")
        elif line.lstrip().startswith('year '):
            line = line.replace("year =", "_year =")
        cleaned.append(line.rstrip())
    return '\n'.join(cleaned)

if __name__ == "__main__":
    logging.basicConfig(level=logging.WARNING)

    import sys
    if len(sys.argv) < 3:
        print(f"Usage: {sys.argv[0]} <bcf-file> <bibfile...> > <output.bib>")
        sys.exit(1)
    bcf_file = sys.argv[1]
    bibfiles = sys.argv[2:]
    keys = get_keys(bcf_file)
    found_items = OrderedDict()

    for bibfile in bibfiles:
        for key, item in get_items_from_bib(keys, bibfile):
            if key not in found_items:
                found_items[key] = {"content": item, "file": bibfile, "also_found": []}
            else:
                logging.info("Already printed %s before, second definition found in %s", key, bibfile)
                found_items[key]["also_found"].append({"file": bibfile, "content": item})

    print(f"% This file is managed by {sys.argv[0]} and should not be edited!\n\n")
    for key, item in sorted(found_items.items()):
        print(f"% Found in {item['file']}")
        print(cleanup_item(item["content"]))
        print()
        for second_item in item["also_found"]:
            print(f"% Also found in {second_item['file']}")
            for line in second_item["content"].splitlines():
                print(f"% {line.rstrip()}")
            print()

    logging.debug("Found items: %s", sorted(found_items.keys()))
    logging.debug("Requested items: %s", sorted(keys))

    for key in (keys - set(found_items.keys())):
        logging.warning("Haven't found %s in .bib sources", key)
