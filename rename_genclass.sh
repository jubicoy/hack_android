#!/bin/bash
pushd app/build/intermediates/classes
shopt -s globstar
for f in **/*\$\$*; do
    mv "$f" "`echo ${f} | sed 's/^\(.*\)\$\$\(.*\)/\1\$\2/'`"
done
popd