#!/bin/bash

## see https://catchenlab.life.illinois.edu/stacks/manual/

src="/home/wheeled/projects/202607gwood"
bwa_db="$src/ref/purged.fa"
    
#files=”sample_01
#sample_02
#sample_03”

#####################
# see scripts/x.bwa.sh
#####################

#
# Align paired-end data with BWA, convert to BAM and SORT.
#
#for sample in $files
#do 
#    bwa mem -t 8 $bwa_db $src/samples/${sample}.1.fq.gz $src/samples/${sample}.2.fq.gz |
#      samtools view -b |
#      samtools sort --threads 4 > $src/aligned/${sample}.bam
#done


#
# Run gstacks to build loci from the aligned paired-end data. We have instructed
# gstacks to remove any PCR duplicates that it finds.
#
gstacks -I $src/aln/ -M $src/pop-final.txt --rm-pcr-duplicates -O $src/stacks-ref/ -t 16

#
# Run populations. Calculate Hardy-Weinberg deviation, population statistics, f-statistics and 
# smooth the statistics across the genome. Export several output files.
#
populations -P $src/stacks-ref/ -M $src/pop-final.txt -r 0.65 --vcf --genepop --fstats --smooth --hwe -t 16
