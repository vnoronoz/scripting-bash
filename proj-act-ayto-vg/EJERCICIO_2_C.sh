#!/bin/bash
# Este script generará un HTML
# que contendrá una tabla en la que cada fila contendrá un equipamiento.
# Mostramos los marcadores HTML iniciales.
echo "<html>"
echo "<body>"
echo "<table border='1'>"
# Lectura del fichero obtenido anteriormente.
# Cada fila contiene un equipamiento. Los campos están separados por ;
# El primer campo contiene el nombre. El segundo la vía.
cat CCVG_cat.csv | tail -n +2 | sort -k 6 -t ";" > html.csv
input="html.csv"
i=1
while IFS=";" read f1 f2 f3 f4 f5 f6
	do
	act=$f3
	ocu=$f6
	echo "<tr><td>$act</td><td>$ocu</td></tr>"
done < "$input"
# Mostramos los marcadores HTML finales.
echo "</table>"
echo "</body>"
echo "</html>"
