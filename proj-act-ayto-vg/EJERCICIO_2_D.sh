gnuplot <<- EOF
  set xlabel "Nivel Ocupacion"
  set ylabel "Recuento"
  set title "Actividades Ayto. Vitoria-Gasteiz"
  set term png
  set output "graph_CCVG.png"
  set datafile separator whitespace
  set boxwidth 0.8 relative
  set style fill solid 0.5
  plot 'CCVG_res.txt' using 1:xtic(2) notitle with boxes
EOF
