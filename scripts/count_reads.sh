#!/bin/bash

DATA=/home/wheeled/projects/202401mcoleman/data

echo "|sample|r1 count|r1 trim count| r2 count| r2 trim count|"
echo "|---|---|---|---|---|"

for trimr1 in $DATA/*adtrim.1.fq.gz
do
	trimr2=$(echo $trimr1 | sed 's/1.fq.gz/2.fq.gz/')
	r1=$(echo $trimr1 | sed 's/adtrim.//')
	r2=$(echo $trimr2 | sed 's/adtrim.//')
	trimr1cnt=$(zcat $trimr1 | wc -l)/4|bc
	trimr2cnt=$(zcat $trimr2 | wc -l)/4|bc
	r1cnt=$(zcat $r1 | wc -l)/4|bc
	r2cnt=$(zcat $r2 | wc -l)/4|bc
	rowname=$(basename $r1 | sed 's/.1.fq.gz//')
	echo "|$rowname|$r1cnt|$trimr1cnt|$r2cnt|$trimr2cnt|"
done
