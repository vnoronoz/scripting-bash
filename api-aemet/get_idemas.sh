#!/bin/bash

source credentials.key

url_desc=$(curl --url 'https://opendata.aemet.es/opendata/api/observacion/convencional/todas?api_key='"${apikey}"'' --cipher 'DEFAULT:!DH' | grep -w datos | awk -F'"' '{print $4}')
curl ${url_desc} --cipher 'DEFAULT:!DH' | jq -r '.[].idema' | uniq
