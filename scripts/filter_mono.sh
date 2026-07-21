#!/bin/bash

# https://evomics.org/learning/population-and-speciation-genomics/2020-population-and-speciation-genomics/first-steps-in-genomic-data-analysis/#ex3.2
# run after bgziptabix command

IN=$1
OUT=$(echo $IN | sed 's/vcf.gz/allele.vcf.gz/g')

echo processing: $IN

bcftools filter -e 'AC==0 || AC==AN' --SnpGap 10 $IN | bcftools view -m2 -M2 -v snps -O z -o $OUT

echo outfile is: $OUT
