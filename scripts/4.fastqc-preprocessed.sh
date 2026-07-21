#!/bin/bash

data=data/pre-processed
outdir=fastqc-final
mkdir -p $outdir

for r1 in $data/*.1.fq.gz; do
	r2=$(echo $r1 | sed 's/1.fq.gz/2.fq.gz/')
	echo "fastqc -t 100 -o $outdir $r1 $r2"
	fastqc -t 100 -o $outdir $r1 $r2
done
