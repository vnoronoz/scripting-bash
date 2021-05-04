#!/bin/bash
wget -O covid.csv "https://analisi.transparenciacatalunya.cat/api/views/c7sd-zy9j/rows.csv?accessType=DOWNLOAD&sorting=true"
echo "ARCHIVO GUARDADO COMO covid.csv"
echo ""
echo "APARTADO A"
echo ""
echo "Listado de comarcas:"
cat covid.csv | cut -d ',' -f1 | tail -n +2 | sort | uniq | paste -d";" -s
echo ""
echo "APARTADO B"
echo ""
cat covid.csv | cut -d ',' -f1 | tail -n +2 | sort | uniq > comarcas.txt
mapfile -t arraycom < comarcas.txt
echo "Toda la matriz:"
echo ${arraycom[@]}
echo "Valores de las posiciones 0, 20 y 30 de la matriz:"
echo ${arraycom[0]}
echo ${arraycom[20]}
echo ${arraycom[30]}
echo ""
echo "APARTADO C"
echo ""
echo "Listado de meses y años:"
cat covid.csv | cut -d ',' -f3 | tail -n +2 | cut -d '/' -f2,3 | sort -k 1 -t "/" -u
echo ""
echo "APARTADO D"
echo ""
#pcr dona
pcrdona=$(cat covid.csv | cut -d ',' -f4,8 | tail -n +2 | grep Dona | cut -d ',' -f2 | paste -s -d+ | bc --)
echo "Numero PCR mujeres: $pcrdona"
#pcr home
pcrhome=$(cat covid.csv | cut -d ',' -f4,8 | tail -n +2 | grep Home | cut -d ',' -f2 | paste -s -d+ | bc --)
echo "Numero PCR hombres: $pcrhome"
diferencia=$((pcrdona - pcrhome))
echo "Diferencia entre PCRs de mujeres y hombres: $diferencia"
if ((pcrdona > pcrhome)); then
	echo "Mujeres han recibido mas PCRs"
else
	echo "Hombres han recibido mas PCRs"
fi
echo ""
echo "APARTADO E"
echo ""
cat covid.csv | cut -d ',' -f3 | tail -n +2 | cut -d '/' -f2,3 > mes.txt
cat covid.csv | cut -d ',' -f1,7,8 | tail -n +2 > datos.txt
paste -d ',' datos.txt mes.txt > covid_e.txt
env LC_NUMERIC=en_CA.UTF-8 datamash -st, -g1,4 sum 2,3 < covid_e.txt > agrupados.txt
cat agrupados.txt | cut -d "," -f1 | tr -d " " | tr -d "'" | tr -d "Ã" > sinespacios.txt
paste -d ',' agrupados.txt sinespacios.txt > final.txt
ALLVALUES=()
while read l1 
do
	ALLVALUES+=( $l1 )       
done < sinespacios.txt
#length=${#ALLVALUES[@]}
#echo $length
i=0
while IFS="," read f1 f2 f3 f4 f5
do	
	if [[ "$f5" = "${ALLVALUES[i-1]}" ]]; then
        	echo -e "\t\e[0m$f2"
        	echo -e "\t\tCasos confirmados: $f3"
        	echo -e "\t\tTotal de PCRs : $f4"
        else
        	echo -e "\e[1m\e[31m==$f1=="
        	echo -e "\t\e[0m$f2"
        	echo -e "\t\tCasos confirmados: $f3"
        	echo -e "\t\tTotal de PCRs : $f4"
        fi  
        i=$(($i + 1))  
done < final.txt
