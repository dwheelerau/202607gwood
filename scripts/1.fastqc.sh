#!/bin/bash

# fastqc reports for trimming params
IN1="George_data_subset_for_reina_analysis/DDRAD_1_for_reina"
IN2="George_data_subset_for_reina_analysis/DDRAD_2_for_reina"
IN3="George_data_subset_for_reina_analysis/DDRAD_3_for_reina"

OUT=fastqc_raw

for fq in $IN1/*.fastq.gz;
do
	echo $fq
	fastqc -t 100 -o $OUT/ $fq
done

for fq in $IN2/*.fastq.gz;
do
	echo $fq
	fastqc -t 100 -o $OUT/ $fq
done

for fq in $IN3/*.fastq.gz;
do
	echo $fq
	fastqc -t 100 -o $OUT/ $fq
done
