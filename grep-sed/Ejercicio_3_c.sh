#!/bin/bash
cat datosParlamentariosPP.xml | grep "fullName" | sed 's/<\/\?[^>]\+>//g' | sed -nr '/^[[:space:]]*[^[:space:]]+[[:space:]]+[^[:space:]@]+[[:space:]]*$/p' | sed -e 's/\(.*\)/\U\1/' | sed -E 's/(\S+)\s+(\S+)/\2 \1/'
