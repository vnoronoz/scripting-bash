#!/bin/bash

source credentials.key

url_desc=$(curl --url 'https://opendata.aemet.es/opendata/api/observacion/convencional/datos/estacion/9091R?api_key='"${apikey}"'' --cipher 'DEFAULT:!DH' | grep -w datos | awk -F'"' '{print $4}')

curl ${url_desc} --cipher 'DEFAULT:!DH' | jq .[-1] > "Lectura_$(date "+%Y.%m.%d-%H.%M")".txt
