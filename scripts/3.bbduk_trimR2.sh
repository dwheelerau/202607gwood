#!/bin/bash

# use bbduk to hard trim R1 and R2 to 140bp which
# is the minimum read length for this batch of data
# after barcodes removed

# grab the r2 ie
#for $r2 in *2.fq.gz....
R2=$1
R1=$(echo $R2 | sed 's/2.fq.gz/1.fq.gz/')
R2OUT=$(echo $(basename $R2) | sed 's/2.fq.gz/stdlen.2.fq.gz/')
R1OUT=$(echo $(basename $R1) | sed 's/1.fq.gz/stdlen.1.fq.gz/')

echo "processing" $R2

# trim to 140bp with 0 index
/home/wheeled/software/bbmap/bbduk.sh in=$R2 out=$R2OUT forcetrimright=139 ordered=t
/home/wheeled/software/bbmap/bbduk.sh in=$R1 out=$R1OUT forcetrimright=139 ordered=t

# data moved to demultiplex/adtrim.stdlen
