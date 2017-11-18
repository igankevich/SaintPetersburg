#!/usr/bin/gnuplot -persist

set border 1+2+4+8+16
set xtics nomirror out
set ytics nomirror out
set ztics nomirror out offset 1,0

set xlabel 'x' offset -2,0
set ylabel 'y'

set zrange [-5:5]
set cbrange [-5:5]
set ztics -4,2,4
set xtics 0,2,9
set ytics 0,2,9

set terminal outext size sx,sy font 'Open Sans Regular, 10'

set pm3d
set hidden3d
load 'temperaturemap.gnuplot'
set output infile . '.' . outext
splot infile matrix using 2:1:3 with lines ls 1 notitle
