#!/bin/sh
set -eu

rm -rf extensions.txt
code --list-extensions >>extensions_tmp.txt

grep -v -f ai.txt extensions_tmp.txt >>extensions.txt
rm -rf extensions_tmp.txt
