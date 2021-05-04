#!/bin/bash
wget http://www.europarl.europa.eu/meps/en/full-list/xml/ --output-document=list.xml
xmlstarlet sel -T -t -m /meps/mep -v "concat(fullName,',',id)" -n list.xml > meps.csv 
tail -5 meps.csv > meps5.csv
echo "Lista de los ultimos 5 resultados:"
cat meps5.csv
echo ""
numero=$(cat meps.csv | wc -l) 
echo "Numero total de registros en el fichero: $numero"
echo ""
randomnum=$(shuf -i 5-$numero -n 1)
echo "Numero aleatorio: $randomnum"
echo ""
echo "Lista de 5 registros hasta el numero aleatorio:"
head -n $randomnum meps.csv | tail -5
echo ""
echo "Registros donde el identificador del eurodiputado es de solamente 4 dígitos:"
grep -E '(^|[^0-9])[0-9]{4}($|[^0-9])' meps.csv
