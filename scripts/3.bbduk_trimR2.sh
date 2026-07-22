#!/bin/bash

# use bbduk to hard trim R1 to 142bp which
# is the minimum read length for this batch of data after barcodes rem
# keep the R2 at 150bp

#use: for r2 in path_to_data/*.adtrim.2.fq.gz do ...
R2="$1"
R1="${R2%.2.fq.gz}.1.fq.gz"
R2OUT="$(basename "${R2%.2.fq.gz}.stdlen.2.fq.gz")"
R1OUT="$(basename "${R1%.1.fq.gz}.stdlen.1.fq.gz")"

echo "processing $R2"

# output
mkdir -p data/adtrim.stdlen

# keep at 150 but change name
#/home/wheeled/software/bbmap/bbduk.sh in="$R2" out="data/adtrim.stdlen/$R2OUT" forcetrimright=149 ordered=t
# or
# much quicker as not doing anything this time around!
cp "$R2" "data/adtrim.stdlen/$R2OUT"

# keep bases 0-141 (142bp in total) with zero index
/home/wheeled/software/bbmap/bbduk.sh in="$R1" out="data/adtrim.stdlen/$R1OUT" forcetrimright=141 ordered=t
