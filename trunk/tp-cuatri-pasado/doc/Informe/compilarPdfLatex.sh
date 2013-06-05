#!/bin/bash

nombre="TP Grupal - Distribuidos"
echo $nombre

# Compilo dos veces para que aparezca el índice
pdflatex "$nombre".tex
pdflatex "$nombre".tex

# Pdf creado. Borrando archivos auxiliares
echo "$nombre.pdf creado. Borrando archivos auxiliares"
rm "$nombre".toc "$nombre".aux "$nombre".log "$nombre".out 

