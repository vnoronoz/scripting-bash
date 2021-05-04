#!/bin/bash

source credentials.key

estacion=$1
parametro=$2

url_desc=$(curl --url 'https://opendata.aemet.es/opendata/api/valores/climatologicos/mensualesanuales/datos/anioini/2020/aniofin/2020/estacion/'"${estacion}"'?api_key='"${apikey}"'' --cipher 'DEFAULT:!DH' | grep -w datos | awk -F'"' '{print $4}')
curl ${url_desc} --cipher 'DEFAULT:!DH' | jq -r '.[] | [.indicativo, .fecha, .'"${parametro}"'] | @csv' > datos_estacion.csv
cat datos_estacion.csv | sed 's/"//g' | head -n -2 | sed 's/2020-//g' > datos.csv
gnuplot <<- EOF
  set xlabel "Meses"
  set ylabel "Valores"
  set title "Grafico ${parametro} Estacion ${estacion}"
  set term png
  set output "graph_est.png"
  set datafile separator comma
  set boxwidth 0.9 relative
  set style fill solid 1.0
  plot 'datos.csv' using 3:xtic(2) notitle with boxes
EOF
