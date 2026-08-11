#!/bin/bash

##### mamba activate stack-v2.64 #####

ref_path="ref/purged.fa"
reads="data/adtrim.stdlen"
out="aln"
mkdir -p "$aln"

for r1 in $reads/*.1.fq.gz
do
	r2="${r1%.1.fq.gz}.2.fq.gz"
	sample_path="${r1%%_*}"
	sample=$(basename "$sample_path")
	bam="$out/${sample}.bam"
	echo "$ref_path"
	echo "$r1"
	echo "$r2"
	echo "$bam"
	bwa mem -t 32 "$ref_path" "$r1" "$r2" | samtools sort -o "$bam"
done
