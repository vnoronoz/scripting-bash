#!/bin/awk -f

function print_head(){

	printf "\n\t\t\tOFERTA DE ACTIVIDADES AYUNTAMIENTO DE VITORIA-GASTEIZ\n\n"
	printf "Actividad\t\t\tPlazas Ofertadas\tPlazas Ocupadas\t\tPorcentaje Ocupacion\n"
	printf "---------------------------------------------------------------------------------"
	printf "----------------------------------\n\n"
}

function process_customer(NAME, ofer, ocu, porc){	
	
	if (length(NAME)>30) printf ("%.30s\t\t",NAME)
	else printf ("%-30s\t\t",NAME)
	
	printf ("%.0f\t\t\t%.0f\t\t\t%.2f\n",ofer,ocu,porc)
}

BEGIN {FS=";"; print_head()}

# MAIN
{
	if (NR!=1) { 
	name=$2
	process_customer(name,$3,$4,$5)
	tofertadas+=$3
	tocupadas+=$4
	tporcentaje=($4/$3)*100
	}
}

END {
	printf "---------------------------------------------------------------------------------"
	printf "----------------------------------\n"
	process_customer("Total:\t ",tofertadas,tocupadas,tporcentaje) 
}
