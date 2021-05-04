#!/bin/bash

declare -i currentIndent=0
declare -i nextIncrement=0
# Leer archivo y controlar los cierres de los tags
while read -r line ; do
  currentIndent+=$nextIncrement
  nextIncrement=0
  # Control si la línea contiene un cierre, disminuir la sangría
  if [[ "$line" == "</"* ]]; then
    currentIndent+=-1
  else
    dirtyStartTag="${line%%>*}"
    dirtyTagName="${dirtyStartTag%% *}"
    tagName="${dirtyTagName//</}"
    # Aumentar la sangría a menos que la línea contenga una etiqueta de cierre o se cierre sola
    if [[ ! "$line" =~ "</$tagName>" && ! "$line" == *"/>"  ]]; then
      nextIncrement+=1
    fi
  fi

  # Imprimir con indexacion (sangrias)
  # Espacios de impresión para el recuento de sangría
  printf "%*s%s" $(( $currentIndent * 2 )) 
  echo $line
done <<< "$(cat datosParlamentarios.xml | sed 's/></>\n</g')" # Sustituir >< con una nueva línea

