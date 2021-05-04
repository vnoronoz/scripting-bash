#!/bin/bash

# LIMPIEZA DE DATOS

# Borrar campo Jarduera
cat CCVG_unaccent.csv | cut -d ';' -f2 --complement > CCVG.csv
# Quitar de la cabecera palabras en euskera
sed -i 's/KODEA//g; s/PLAZAK//g; s/ESKAINITAKO//g; s/BETETAKO//g; s/OKUPAZIOAREN//g; s/EHUNEKOA//g' CCVG.csv
# Borrar espacios en blanco
sed -i 's/ *; */;/g' CCVG.csv
sed -i 's/^ *//g' CCVG.csv
# Borrar ultimo registro
sed -i '$d' CCVG.csv
# Numero de columnas y registros
registros=$(cat CCVG.csv | tail -n +2 | wc -l)
columnas=$(awk -F";" '{ print NF; exit }' CCVG.csv)
echo ""
echo "- Numero de registros: $registros"
echo "- Numero de columnas: $columnas"
echo ""
# Vista de los datos
echo "- Vista de los datos:"
head CCVG.csv
echo ""

# Exploracion de datos - FILTROS

echo "- Actividades para Mayores de 65:"
cat CCVG.csv | grep -i mayores
echo ""
echo "- Actividades relacionadas con feminismo:"
cat CCVG.csv | grep -i femini
echo ""
echo "- Top 10 actividades con mas plazas ofertadas:"
cat CCVG.csv | tail -n +2 | sort -k 3 -nr -t ";" | head
echo ""
echo "- Resumen de las actividades mas demandadas:"
cat CCVG.csv | tail -n +2 | sort -k 5 -nr -t ";" | head -20
echo ""
echo "- Resumen de las actividades menos demandadas:"
cat CCVG.csv | tail -n +2 | sort -k 5 -n -t ";" | head -20

# Calculo porcentaje numerico - WHILE

echo "percent" > percent.csv
tail -n +2 CCVG.csv | while IFS=";" read f1 f2 f3 f4 f5
do
	tporcentaje=$(echo "scale=2; (100*$f4/$f3)" | bc) 
	echo -e "$tporcentaje" >> percent.csv
done
# Unir la columna con el porcentaje calculado
paste -d';' percent.csv CCVG.csv > CCVG_percent.csv
# Crear categorias de ocupacion
# Si ocupacion < 50% --> ocupacion BAJA-MEDIA 
# Si ocupacion > 50% --> ocupacion MEDIA-ALTA 
awk 'BEGIN {FS=";";OFS=";"};{if(NR==1)print $0;}{if (NR!=1) {if($1>50.00) $6="MEDIA-ALTA"; else $6="BAJA-MEDIA"; print $0; }}' CCVG_percent.csv > CCVG_cat.csv
# Guarda resultado del recuento de las categorias en CCVG_res.txt
cat CCVG_cat.csv | cut -d ';' -f6 | tail -n +2 | sort | uniq -c | sed 's/^ *//g' > CCVG_res.txt
# Borrar archivos intermedios
rm percent.csv CCVG_percent.csv
echo ""
echo "HECHO."
