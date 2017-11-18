#!/usr/bin/gnuplot -persist

set xlabel 'Expected' offset 0,0.5
set ylabel 'Estimated' offset 1.5,0

unset key

set style line 1 lt 1 lc rgb "#202D9F" lw 2 pt 6
set style line 2 lt 1 lc rgb "#404040" lw 2 

set terminal outext size sx,sy font 'serif, 12'

set output infile . '.' . outext
#set size ratio -1
set label infile[start_index:*] at graph 0.1,0.9
plot infile with points ls 1, x with lines ls 2
