#!/bin/bash
./Ejercicio_3_a.sh > datosParlamentariosPP.xml
cat datosParlamentariosPP.xml | grep "politicalGroup" | sed 's/<\/\?[^>]\+>//g' | sort | uniq -c

