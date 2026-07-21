#!/bin/bash
# Remove adapters (ILLUMINACLIP:TruSeq3-PE.fa:2:30:10)
# Drop reads below the 142 bases long (MINLEN:142)
# No quality trimming as this effects downstream results

##### mamba activate stack-v2.64 #####

#DATA=/home/wheeled/projects/202407mcoleman/

#for r1 in $DATA/*.1.fq.gz
for r1 in $1/*.1.fq.gz
do
	r2=$(echo $r1 | sed 's/1.fq.gz/2.fq.gz/')
	r1_out=$(echo $r1 | sed 's/1.fq.gz/adtrim.1.fq.gz/')
	r1_out_unpaired=$(echo $r1 | sed 's/1.fq.gz/unpaired.1.fq.gz/')
	r2_out=$(echo $r2 | sed 's/2.fq.gz/adtrim.2.fq.gz/')
	r2_out_unpaired=$(echo $r2 | sed 's/2.fq.gz/unpaired.2.fq.gz/')
	log=$(echo $r1 | sed 's/1.fq.gz/log.txt/')
	summary=$(echo $r1 | sed 's/1.fq.gz/summary.txt/')
	adapt_path=/home/wheeled/mambaforge/envs/stack-v2.64/share/trimmomatic-0.39-2/adapters

	echo $r1
	trimmomatic PE -threads 100 -trimlog $log -summary $summary \
	       	$r1 $r2 $r1_out $r1_out_unpaired $r2_out $r2_out_unpaired \
		ILLUMINACLIP:$adapt_path/TruSeq3-PE-2.fa:2:30:10 MINLEN:142

done
