#!/bin/bash

# Info pagina
echo "- Pagina informacion del dataset:"
echo "https://opendata.euskadi.eus/catalogo/-/ocupacion-plazas-centros-civicos-2020-2021/"
echo ""
# URL de descarga del dataset
echo "- URL de descarga del dataset:"
# http://www.vitoria-gasteiz.org/docs/j34/catalogo/02/09/Estadisticausooctubre.csv
echo "http://www.vitoria-gasteiz.org/docs/j34/catalogo/02/09/Estadisticausooctubre.csv"
echo ""
# Descarga archivo
wget -O CCVG_original.csv "http://www.vitoria-gasteiz.org/docs/j34/catalogo/02/09/Estadisticausooctubre.csv"
# Metadatos
echo "- Metadatos:"
# https://opendata.euskadi.eus/contenidos/ds_localizaciones/aaa113u97aaaaaac10998aad/es_def/r01DCATDataset.rdf
echo "https://opendata.euskadi.eus/contenidos/ds_localizaciones/aaa113u97aaaaaac10998aad/es_def/r01DCATDataset.rdf"
echo ""
# Tipo Licencia
echo "- Tipo de licencia:"
# https://creativecommons.org/licenses/by/4.0/deed.es_ES
echo "https://creativecommons.org/licenses/by/4.0/deed.es_ES"
echo ""
# Formato archivo
echo "- Formato del archivo:"
archivo=$(file CCVG_original.csv)
echo $archivo
echo ""
# Quitar acentos del archivo
# Instalar herramienta unaccent (en caso necesario)
# sudo apt install unaccent
unaccent ISO-8859-1 < CCVG_original.csv > CCVG_unaccent.csv
