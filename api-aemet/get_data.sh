#!/bin/bash

source credentials.key

estacion=$1
parametro=$2

url_desc=$(curl --url 'https://opendata.aemet.es/opendata/api/observacion/convencional/datos/estacion/'"${estacion}"'?api_key='"${apikey}"'' --cipher 'DEFAULT:!DH' | grep -w datos | awk -F'"' '{print $4}')
curl ${url_desc} --cipher 'DEFAULT:!DH' | jq -r '.[] | .idema, .fint, .'"${parametro}"''
